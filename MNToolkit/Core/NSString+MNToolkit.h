//
//  NSString+MNToolkit.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;
@import UIKit;

/**
 *  @brief NNString帮助类
 */
@interface NSString (MNToolkit)

// 字符串翻转
- (NSString *)reverse;

// 为空
- (BOOL)isBlankOrNil;

//	alert
- (void)showAlertTitle:(NSString *)message;
- (void)showAlertMessage:(NSString *)title;

// 日期转换
- (NSString*)newDateFrom:(NSString *)from to:(NSString*)format;




@end
