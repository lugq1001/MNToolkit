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

@end

@interface MNToolkit (UserInterface)
// 获取栈顶视图
+ (UIViewController *)topViewControllerInWondow:(UIWindow *)window;
// 获取sb
+ (UIStoryboard *)getStroyboard:(NSString *)stroyboardName;
// 确认对话框
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
//关闭软键盘
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







