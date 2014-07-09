//
//  MNCommonCryptor.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNCommonCryptor.h"

@implementation MNCommonCryptor 

+ (NSString *)base64Encode:(NSString *)clearText
{
    NSData *originData = [clearText dataUsingEncoding:NSASCIIStringEncoding];
    NSString *result = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return result;
}

+ (NSString *)base64Decode:(NSString *)b64String
{
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:b64String options:0];
    NSString *result = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    return result;
}

+ (NSString *)urlEncode:(NSString *)clearText
{
    NSString *result = [clearText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

+ (NSString *)urlDecode:(NSString *)urlString
{
    NSString *result = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

@end
















