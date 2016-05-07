//
//  NSData+compress.m
//  ymStock
//
//  Created by flora on 13-10-23.
//
//

#import "NSData+Compress.h"
#import <zlib.h>
@implementation NSData (Compress)
- (NSData *)compressData
{
    NSData *uncompressedData = self;
	if ([uncompressedData length] == 0) return uncompressedData;
	z_stream strm;
	
	strm.zalloc = Z_NULL;
	strm.zfree = Z_NULL;
	strm.opaque = Z_NULL;
	strm.total_out = 0;
	strm.next_in=(Bytef *)[uncompressedData bytes];
	strm.avail_in = (unsigned int)[uncompressedData length];
	
	// Compresssion Levels:
	//   Z_NO_COMPRESSION
	//   Z_BEST_SPEED
	//   Z_BEST_COMPRESSION
	//   Z_DEFAULT_COMPRESSION
	
	if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
	
	NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
	
	do {
		
		if (strm.total_out >= [compressed length])
			[compressed increaseLengthBy: 16384];
		
		strm.next_out = [compressed mutableBytes] + strm.total_out;
		strm.avail_out = (unsigned int)([compressed length] - strm.total_out);
		
		deflate(&strm, Z_FINISH);
		
	} while (strm.avail_out == 0);
	
	deflateEnd(&strm);
	
	[compressed setLength: strm.total_out];
	return [NSData dataWithData:compressed];
}
#define CHUNK 16384

// NOTE: To debug this method, turn off Data Formatters in Xcode or you'll crash on closeFile
+ (int)compressDataFromFile:(NSString *)sourcePath toFile:(NSString *)destinationPath
{
	// Create an empty file at the destination path
	[[NSFileManager defaultManager] createFileAtPath:destinationPath contents:[NSData data] attributes:nil];
	
	// Get a FILE struct for the source file
	NSFileHandle *inputFileHandle = [NSFileHandle fileHandleForReadingAtPath:sourcePath];
	FILE *source = fdopen([inputFileHandle fileDescriptor], "r");
    
	// Get a FILE struct for the destination path
	NSFileHandle *outputFileHandle = [NSFileHandle fileHandleForWritingAtPath:destinationPath];
	FILE *dest = fdopen([outputFileHandle fileDescriptor], "w");
    
	// compress data in source and save in destination
	int status = [NSData compressDataFromSource:source toDestination:dest];
    
	// Close the files
	fclose(dest);
	fclose(source);
	
	// We have to close both of these explictly because CFReadStreamCreateForStreamedHTTPRequest() seems to go bonkers otherwise
	[inputFileHandle closeFile];
	[outputFileHandle closeFile];
    
	return status;
}

//
// Also from the zlib sample code  at http://www.zlib.net/zpipe.c
//
+ (int)compressDataFromSource:(FILE *)source toDestination:(FILE *)dest
{
    int ret, flush;
    unsigned have;
    z_stream strm;
    unsigned char in[CHUNK];
    unsigned char out[CHUNK];
	
    /* allocate deflate state */
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);
    if (ret != Z_OK)
        return ret;
	
    /* compress until end of file */
    do {
        strm.avail_in = (unsigned int)fread(in, 1, CHUNK, source);
        if (ferror(source)) {
            (void)deflateEnd(&strm);
            return Z_ERRNO;
        }
        flush = feof(source) ? Z_FINISH : Z_NO_FLUSH;
        strm.next_in = in;
		
        /* run deflate() on input until output buffer not full, finish
		 compression if all of source has been read in */
        do {
            strm.avail_out = CHUNK;
            strm.next_out = out;
            ret = deflate(&strm, flush);    /* no bad return value */
            assert(ret != Z_STREAM_ERROR);  /* state not clobbered */
            have = CHUNK - strm.avail_out;
            if (fwrite(out, 1, have, dest) != have || ferror(dest)) {
                (void)deflateEnd(&strm);
                return Z_ERRNO;
            }
        } while (strm.avail_out == 0);
        assert(strm.avail_in == 0);     /* all input will be used */
		
        /* done when last data in file processed */
    } while (flush != Z_FINISH);
    assert(ret == Z_STREAM_END);        /* stream will be complete */
	
    /* clean up and return */
    (void)deflateEnd(&strm);
    return Z_OK;
}

@end
