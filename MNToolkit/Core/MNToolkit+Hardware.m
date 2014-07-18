//
//  MNToolkit+Hardware.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/18.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNToolkit.h"

@implementation MNToolkit (Hardware)

+ (BOOL)hardwareCameraAvailable
{
    BOOL available = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    return available;
}

@end