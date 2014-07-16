//
//  ImageProcessLogic.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "ImageProcessLogic.h"
#import "MNToolkit.h"
#import "ImageProcessController.h"

static NSString * const kSBImageProcess = @"ImageProcess";
static NSString * const kImageProcessControllerIdentifier = @"ImageProcessController";
static NSString * const kImageProcessRootController = @"ImageProcessRootController";

@interface ImageProcessLogic ()

@property (nonatomic, strong) UIViewController *userInterface;
@property (nonatomic, strong) UINavigationController *rootNav;

@end

@implementation ImageProcessLogic

- (instancetype)init
{
    if (self = [super init]) {
        self.userInterface = [self createUserInterface];
    }
    return self;
}

- (UIViewController *)createUserInterface
{
    UIStoryboard *sb = [MNToolkit getStroyboard:kSBImageProcess];
    UINavigationController* rootNav = [sb instantiateViewControllerWithIdentifier:kImageProcessRootController];
    ImageProcessController *imageProcessController = [sb instantiateViewControllerWithIdentifier:kImageProcessControllerIdentifier];
    rootNav.viewControllers = @[imageProcessController];
    self.rootNav = rootNav;
    return imageProcessController;
}

@end

@implementation ImageProcessLogic (Wireframe)

- (UINavigationController *)getRootNavigationController
{
    return self.rootNav;
}

@end


@implementation ImageProcessLogic (Presenter)



@end

@implementation ImageProcessLogic (Interactor)



@end