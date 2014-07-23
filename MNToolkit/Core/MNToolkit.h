//
//  MNToolkit.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;
@import UIKit;

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
+ (NSURL *)sandboxFilePathForCoreDataStore:(NSString *)sqliteFileName;
+ (NSString *)sandboxPathImages;

@end

@interface MNToolkit (UserInterface)
// 获取栈顶视图
+ (UIViewController *)topViewControllerInWondow:(UIWindow *)window;
// 获取sb
+ (UIStoryboard *)getStroyboard:(NSString *)stroyboardName;
// 确认对话框
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
// 关闭软键盘
+ (void)hideSoftKeyboard:(UIViewController *)viewController;

@end

@interface MNToolkit (UserPermission)

+ (BOOL)permissionCaptureEnable;
+ (BOOL)permissionAlbumEnable;
+ (BOOL)permissionLocationEnable;

@end


@interface MNToolkit (Hardware)

#define MNDeviceScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define MNDeviceScreenHeight ([UIScreen mainScreen].bounds.size.height)

+ (BOOL)hardwareCameraAvailable;

@end

@interface MNToolkit (Network)

+ (void)httpRequest:(NSString *)url
             params:(NSDictionary *)params
           callback:(void(^)(NSData *result, NSError *error))callback;

+ (void)httpRequest:(NSString *)url
   uploadWithParams:(NSDictionary *)params
          filePaths:(NSArray *)filePaths
           callback:(void (^)(NSData *result, NSError *error))callback;

+ (void)httpRequest:(NSString *)url
 downloadWithParams:(NSDictionary *)params
          storePath:(NSString *)storePath
           fileName:(NSString *)fileName
           callback:(void(^)(NSString *filePath, NSError *error))callback;

+ (void)httpRequest:(NSString *)url
    imageWithParams:(NSDictionary *)params
           callback:(void(^)(NSString *imagePath, NSError *error))callback;

+ (NSString *)makeupUrlForHttpGet:(NSString *)url param:(NSDictionary *)params;

@end







