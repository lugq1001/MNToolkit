//
//  MNToolkit+UserPermission.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/18.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNToolkit.h"
@import AVFoundation;
@import AssetsLibrary;
@import CoreLocation;

@implementation MNToolkit (UserPermission)

+ (BOOL)permissionCaptureEnable
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized://已经获得了许可
            return YES;
        case AVAuthorizationStatusDenied://被拒绝了，不能打开
            return NO;
        case AVAuthorizationStatusNotDetermined://不确定是否获得了许可
            return YES;
        case AVAuthorizationStatusRestricted://受限制：已经询问过是否获得许可但被拒绝
            return NO;
        default:
            return NO;
    }
}

+ (BOOL)permissionAlbumEnable
{
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized://已经获得了许可
            return YES;
        case AVAuthorizationStatusDenied://被拒绝了，不能打开
            return NO;
        case AVAuthorizationStatusNotDetermined://不确定是否获得了许可
            return YES;
        case AVAuthorizationStatusRestricted://受限制：已经询问过是否获得许可但被拒绝
            return NO;
        default:
            return NO;
    }
}

+ (BOOL)permissionLocationEnable
{
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
        switch (authStatus) {
            case AVAuthorizationStatusAuthorized://已经获得了许可
                return YES;
            case AVAuthorizationStatusDenied://被拒绝了，不能打开
                return NO;
            case AVAuthorizationStatusNotDetermined://不确定是否获得了许可
                return YES;
            case AVAuthorizationStatusRestricted://受限制：已经询问过是否获得许可但被拒绝
                return NO;
            default:
                return NO;
        }
    }
    return NO;
}


@end