//
//  MSCoreFileManager+UIKit.m
//  Pods
//
//  Created by ryan on 15/10/23.
//
//

#import "MSCoreFileManager.h"
#import "MSCoreFileManager+UIKit.h"

BOOL MSFileManagerSaveImage(NSString *filename, UIImage *image)
{
    NSData *data = nil;
    
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", EMGetDefaultImageDirectory(), filename];
    
    return MSFileManagerSaveFile(filePath, data);
}


UIImage* MSFileManagerLoadImage(NSString *filename)
{
    NSString *dir = EMGetDefaultImageDirectory();
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", dir, filename];
    
    return [UIImage imageWithContentsOfFile:filePath];
}

