//
//  MNToolkit+UserInterface.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNToolkit.h"

@implementation MNToolkit (UserInterface)

+ (UIStoryboard *)getStroyboard:(NSString *)stroyboardName
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:stroyboardName bundle:[NSBundle mainBundle]];
    return sb;
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

+ (UIViewController *)topViewControllerInWondow:(UIWindow *)window
{
    return [self topViewController:window.rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

@end