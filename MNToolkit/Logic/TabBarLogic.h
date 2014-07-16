//
//  TabBarLogic.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface TabBarLogic : NSObject

@property (nonatomic, strong) UIViewController *userInterface;

- (instancetype)init;

@end

@interface TabBarLogic (Wireframe)

//跳转至TabbarController
- (void)presentTabBarFromViewController:(UIViewController *)controller;

@end

@interface TabBarLogic (Presenter)

@end

@interface TabBarLogic (Interactor)

@end