//
//  EMCoreFileManager.m
//  Core
//
//  Created by Mac mini 2012 on 15-3-9.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import "MSCoreFileManager.h"

static NSString *__defaultImageDirectory = nil; // 默认的图片文件夹路径

NSString* EMGetDefaultImageDirectory();


NSURL* MSFileURL(NSString *path)
{
    return [[NSURL alloc] initFileURLWithPath:path];
}

BOOL MSIsFileExistAtPath(NSString *filePath)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    const bool isExist = [fileManager fileExistsAtPath:filePath];
    
    if (!isExist){
        NSLog(@"%@ not exist!", filePath);
    }
    
    return isExist;
}


# pragma mark -
# pragma mark Read and write plist file

NSArray* MSArrayFromMainBundle(NSString *filename)
{
    NSArray *arrayForReturn = nil;
    NSString *path = MSPathForBundleResource(nil, filename);
    
    if (MSIsFileExistAtPath(path)){
        arrayForReturn = [NSArray arrayWithContentsOfFile:path];
    }
    return arrayForReturn;
}


NSDictionary* MSDictionaryFromMainBundle(NSString *filename)
{
    NSDictionary *dictionaryForReturn = nil;
    NSString *path = MSPathForBundleResource(nil, filename);
    
    if (MSIsFileExistAtPath(path)){
        dictionaryForReturn = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dictionaryForReturn;
}


NSArray* MSArrayFromCachesDirectory(NSString *filename)
{
    NSString *path = MSPathForCachesResource(filename);
    return [NSArray arrayWithContentsOfFile:path];
}


NSDictionary* MSDictionaryFromDocumentDirectory(NSString *filename)
{
    NSString *path = MSPathForCachesResource(filename);
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


BOOL MSSaveArrayToCachesDirectory(NSString *filename, NSArray *array)
{
    NSString *path = MSPathForCachesResource(filename);
    return [array writeToFile:path atomically:YES];
}


BOOL MSSaveDictionaryToCachesDirectory(NSString *filename, NSDictionary *dictionary)
{
    NSString *path = MSPathForCachesResource(filename);
    return [dictionary writeToFile:path atomically:YES];
}


BOOL MSFileManagerCreateDirectory(NSString *dir)
{
    BOOL flag = NO;
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error = nil;
    
    if (![fileManger fileExistsAtPath:dir])
    {
        flag = [fileManger createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"createDirectoryAtPath faild:%@", error);
        }
    }
    else{
        NSLog(@"%@ 文件夹已存在", dir);
    }
    
    return flag;
}


BOOL MSFileManagerRemoveDirectory(NSString *dir)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dir error:nil];
}


BOOL MSFileManagerRemoveFile(NSString *file)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:file error:nil];
}


BOOL MSFileManagerSaveFile(NSString *file, NSData *data)
{
    NSError *error = nil;
    BOOL flag = [data writeToFile:file options:NSDataWritingAtomic error:&error];

    if (flag == NO) {
        NSLog(@"MSFileManagerSaveFile error = %@", error);
    }
    
    return flag;
}


NSData *MSFileManagerFileAtPath(NSString *filePath)
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    return data;
}


NSString* EMGetDefaultImageDirectory()
{
    if (__defaultImageDirectory==nil) {
        __defaultImageDirectory = MSPathForCachesResource(@"/pic");
        MSFileManagerCreateDirectory(__defaultImageDirectory);
    }
    
    return __defaultImageDirectory;
}


void MSSetDefaultImageDirectory(NSString *directory)
{
    if (__defaultImageDirectory==nil) {
        __defaultImageDirectory = EMGetDefaultImageDirectory();
    }
    
    __defaultImageDirectory = directory;
}

# pragma mark - Path
NSString* MSPathForMainBundleResource(NSString* relativePath)
{
    NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


NSString* MSPathForBundleResource(NSBundle* bundle, NSString* relativePath) {
    NSString* resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


NSString* MSPathForDocumentsResource(NSString* relativePath) {
    
    if (relativePath==nil) {
        relativePath = @"";
    }
    
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


NSString* MSPathForLibraryResource(NSString* relativePath) {
    static NSString* libraryPath = nil;
    if (nil == libraryPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        libraryPath = [dirs objectAtIndex:0];
    }
    return [libraryPath stringByAppendingPathComponent:relativePath];
}


NSString* MSPathForCachesResource(NSString* relativePath) {
    static NSString* cachesPath = nil;
    if (nil == cachesPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        cachesPath = [dirs objectAtIndex:0];
    }
    return [cachesPath stringByAppendingPathComponent:relativePath];
}
