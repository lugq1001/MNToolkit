//
//  MNToolkit+SandboxPath.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNToolkit.h"

@implementation MNToolkit (SandboxPath)

+ (NSString *)sandboxPathHome
{
    return NSHomeDirectory();
}

+ (NSString *)sandboxPathApp
{
    return [[NSBundle mainBundle] bundlePath];
}

+ (NSString *)sandboxPathDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)sandboxPathLibrary
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)sandboxPathLibraryCaches
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)sandboxPathTmp
{
    return NSTemporaryDirectory();
}

+ (NSString *)sandboxFilePath:(NSString *)fileName suffix:(NSString *)suffix;
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:suffix];
}

+ (NSString *)sandboxFilePath:(NSString *)fileName suffix:(NSString *)suffix inDirectory:(NSString *)directory;
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:suffix inDirectory:directory];
}

+ (NSString *)sandboxPathImages
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *dir = [[self sandboxPathDocuments] stringByAppendingPathComponent:@"imgs"];
    BOOL isDir;
    BOOL exist = [manager fileExistsAtPath:dir isDirectory:&isDir];
    if (!isDir || !exist) {
        [manager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dir;
}

+ (NSURL *)sandboxFilePathForCoreDataStore:(NSString *)sqliteFileName
{
    //NSURL *documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsDirectory URLByAppendingPathComponent:[sqliteFileName stringByAppendingString:@".sqlite"]];
}

@end
