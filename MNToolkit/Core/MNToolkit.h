//
//  MNToolkit.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;

/**
 *  @brief iOS工具类
 */
@interface MNToolkit : NSObject

@end

@interface MNToolkit (SandboxPath)
//sandbox path
+ (NSString *)sandboxPathHome;
+ (NSString *)sandboxPathApp;
+ (NSString *)sandboxPathDocuments;
+ (NSString *)sandboxPathLibrary;
+ (NSString *)sandboxPathLibraryCaches;
+ (NSString *)sandboxPathTmp;
+ (NSString *)sandboxFilePath:(NSString *)fileName suffix:(NSString *)suffix;
+ (NSString *)sandboxFilePath:(NSString *)fileName suffix:(NSString *)suffix inDirectory:(NSString *)directory;

@end