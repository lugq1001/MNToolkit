//
//  MNCommonCryptor.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;

/**
 *  @class MNCommonCryptor
 *  @brief 加密工具类
 */
@interface MNCommonCryptor : NSObject

#pragma mark -Base64编码
+ (NSString *)base64Encode:(NSString *)clearText;
+ (NSString *)base64Decode:(NSString *)b64String;

#pragma mark -URL编码
+ (NSString *)urlEncode:(NSString *)clearText;
+ (NSString *)urlDecode:(NSString *)urlString;

@end

#pragma mark -MD5 HASH
@interface MNCommonCryptor(md5Hash)

+ (NSString *) md5:(NSString *)clearText;
+ (NSString *) md5WithData:(NSData *)data;
+ (NSString *) md5WithFile:(NSString *)filePath;
+ (NSString *) md5StringTo16bit:(NSString *)md5_32bit;

@end

#pragma mark -SHA HASH
@interface MNCommonCryptor(shaHash)

+ (NSString *) sha1:(NSString *)clearText;
+ (NSString *) sha224:(NSString *)clearText;
+ (NSString *) sha256:(NSString *)clearText;
+ (NSString *) sha384:(NSString *)clearText;
+ (NSString *) sha512:(NSString *)clearText;

+ (NSString *) sha1WithData:(NSData *)data;
+ (NSString *) sha224WithData:(NSData *)data;
+ (NSString *) sha256WithData:(NSData *)data;
+ (NSString *) sha384WithData:(NSData *)data;
+ (NSString *) sha512WithData:(NSData *)data;

+ (NSString *) sha1WithFile:(NSString *)filePath;
+ (NSString *) sha224WithFile:(NSString *)filePath;
+ (NSString *) sha256WithFile:(NSString *)filePath;
+ (NSString *) sha384WithFile:(NSString *)filePath;
+ (NSString *) sha512WithFile:(NSString *)filePath;

@end
