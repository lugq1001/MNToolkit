//
//  TabBarLogic.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "TabBarLogic.h"
#import "TabBarController.h"
#import "MNToolkit.h"
#import "AppColors.h"
#import "ImageProcessLogic.h"
#import "CameraLogic.h"

static NSString * const kSBMain = @"Main";
static NSString * const kTabBarControllerIdentifier = @"TabBarController";

@interface TabBarLogic () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIViewController *userInterface;

@end

@implementation TabBarLogic

- (instancetype)init
{
    if (self = [super init]) {
        self.userInterface = [self createUserInterface];
    }
    return self;
}

- (UIViewController *)createUserInterface
{
    UIStoryboard *sb = [MNToolkit getStroyboard:kSBMain];
    TabBarController *tabBarController = [sb instantiateViewControllerWithIdentifier:kTabBarControllerIdentifier];
    //tanController
    ImageProcessLogic *imageLogic = [[ImageProcessLogic alloc] init];
    UINavigationController *imageNav = [imageLogic getRootNavigationController];
    
    CameraLogic *cameraLogic = [[CameraLogic alloc] init];
    UINavigationController *cameraNav = [cameraLogic getRootNavigationController];
    
    NSArray *tabControllers = @[imageNav,cameraNav];
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
    return tabBarController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[TabBarPresentationTransition alloc] init];
}

@end

#pragma mark -Wireframe
@implementation TabBarLogic (Wireframe)

//跳转至TabbarController
- (void)presentTabBarFromViewController:(UIViewController *)controller
{
    [self.userInterface setTransitioningDelegate:self];
    [controller presentViewController:self.userInterface animated:YES completion:nil];
}

@end

#pragma mark -Presenter
@implementation TabBarLogic (Presenter)

@end

#pragma mark -Interactor
@implementation TabBarLogic (Interactor)



@end

#pragma mark -Helper

@implementation TabBarPresentationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TabBarController *to = (TabBarController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    [containView addSubview:to.view];
    
    to.view.transform = CGAffineTransformMakeScale(.0f, .0f);
    [containView insertSubview:to.view aboveSubview:from.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        to.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end

