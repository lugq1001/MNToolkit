//
//  ViewController.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "ViewController.h"
#import "MNToolkit.h"
#import "TabBarController.h"
#import "ImageProcessController.h"
#import "AppColors.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)customTabBarController:(id)sender {
    UIStoryboard *sb = [MNToolkit getStroyboard:@"Main"];
    TabBarController *tabBarController = [sb instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    //image process
    UIStoryboard *imageProcessSB = [MNToolkit getStroyboard:@"ImageProcess"];
    UIViewController *imageProcessNav = [imageProcessSB instantiateViewControllerWithIdentifier:@"ImageProcessRootController"];
    
    UIStoryboard *cameraSB = [MNToolkit getStroyboard:@"Camera"];
    UIViewController *cameraNav = [cameraSB instantiateViewControllerWithIdentifier:@"CameraRootController"];
    
    NSArray *tabControllers = @[imageProcessNav,cameraNav];
    NSArray *tabTexts = @[@"ImageProcess",@"Camera"];
    NSArray *tabIcons = @[@"ic_tab",@"ic_tab", ];
    NSArray *tabSelectedIcons = @[@"ic_tab_s",@"ic_tab_s"];
    NSUInteger tabCount = [tabControllers count];
    //UITabBar *tabBar = tabBarController.tabBar;
    for (NSUInteger i = 0; i < tabCount; i++) {
        //imageWithRenderingMode 使用icon自身颜色
        UIImage *icon = [[UIImage imageNamed:tabIcons[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *icon_sel = [[UIImage imageNamed:tabSelectedIcons[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:tabTexts[i] image:icon selectedImage:icon_sel];
        UIViewController *ctl = tabControllers[i];
        ctl.tabBarItem = item;
    }
    tabBarController.viewControllers = tabControllers;
    
    //背景图片,设置透明,不然颜色无效
    UIImage *transparent = [UIImage imageNamed:@"transparent"];
    [[UITabBar appearance] setBackgroundImage:transparent];
    [[UITabBar appearance] setBackgroundColor:[AppColors tabBarBackgroundColor]];
    //[[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_bg_sel"]];
    //隐藏黑线
    [[UITabBar appearance] setShadowImage:transparent];
    //文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[AppColors tabBarTextColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[AppColors tabBarTextColorSelected]} forState:UIControlStateSelected];
    [self presentViewController:tabBarController animated:YES completion:nil];
    
}

@end
