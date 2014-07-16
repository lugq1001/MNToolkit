//
//  ImageProcessLogic.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface ImageProcessLogic : NSObject

- (instancetype)init;

@end

@interface ImageProcessLogic (Wireframe)

- (UINavigationController *)getRootNavigationController;

@end

@interface ImageProcessLogic (Presenter)

@end

@interface ImageProcessLogic (Interactor)

@end