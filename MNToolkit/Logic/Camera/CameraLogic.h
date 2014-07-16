//
//  CameraLogic.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface CameraLogic : NSObject

@property (nonatomic, strong) UIViewController *userInterface;

- (instancetype)init;

@end

@interface CameraLogic (Wireframe)

- (UINavigationController *)getRootNavigationController;

@end

@interface CameraLogic (Presenter)

@end

@interface CameraLogic (Interactor)

@end