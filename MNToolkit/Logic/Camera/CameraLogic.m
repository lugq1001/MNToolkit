//
//  CameraLogic.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "CameraLogic.h"
#import "MNToolkit.h"
#import "CameraController.h"

static NSString * const kSBCamera = @"Camera";
static NSString * const kCameraControllerIdentifier = @"CameraController";
static NSString * const kCameraRootController = @"CameraRootController";

@interface CameraLogic ()

@property (nonatomic, strong) UINavigationController *rootNav;

@end

@implementation CameraLogic

- (instancetype)init
{
    if (self = [super init]) {
        self.userInterface = [self createUserInterface];
    }
    return self;
}

- (UIViewController *)createUserInterface
{
    UIStoryboard *sb = [MNToolkit getStroyboard:kSBCamera];
    UINavigationController* rootNav = [sb instantiateViewControllerWithIdentifier:kCameraRootController];
    CameraController *cameraController = [sb instantiateViewControllerWithIdentifier:kCameraControllerIdentifier];
    rootNav.viewControllers = @[cameraController];
    self.rootNav = rootNav;
    return cameraController;
}

@end

@implementation CameraLogic (Wireframe)

- (UINavigationController *)getRootNavigationController
{
    return self.rootNav;
}

@end


@implementation CameraLogic (Presenter)



@end

@implementation CameraLogic (Interactor)



@end