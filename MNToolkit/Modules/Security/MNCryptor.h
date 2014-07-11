//
//  MNCryptor.h
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

@import Foundation;

/**
 *  @class MNCryptor
 *  @brief 加密工具类
 */
@interface MNCryptor : NSObject

#pragma mark -Base64编码
+ (NSString *) base64Encode:(NSString *)clearText;
+ (NSString *) base64EncodeWithData:(NSData *)data;
+ (NSString *) base64Decode:(NSString *)b64String;
+ (NSData *)   base64DecodeForData:(NSString *)b64String;

#pragma mark -URL编码
+ (NSString *) urlEncode:(NSString *)clearText;
+ (NSString *) urlDecode:(NSString *)urlString;

@end

#pragma mark -OTP
@interface MNCryptor(OTP)

+ (NSString *) otpPassword:(NSString *)seed serverTime:(unsigned long long)serverTimeSecond;

@end

#pragma mark -MD5 HASH
@interface MNCryptor(md5Hash)

+ (NSString *) md5:(NSString *)clearText;
+ (NSString *) md5WithData:(NSData *)data;
+ (NSString *) md5WithFile:(NSString *)filePath;
+ (NSString *) md5StringTo16bit:(NSString *)md5_32bit;

@end

#pragma mark -SHA HASH
@interface MNCryptor(shaHash)

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

#pragma mark -AES
@interface MNCryptor(AES)

+ (NSData *) aes256Encrypt:(NSString *)clearText key:(id)key;
+ (NSData *) aes256Decrypt:(NSString *)ciperText key:(id)key;
+ (NSData *) aes256EncryptWithData:(NSData *)data key:(id)key;
+ (NSData *) aes256DecryptWithData:(NSData *)data key:(id)key;

+ (BOOL)     aes256EncryptFromFile:(NSString *)filePath
                                to:(NSString *)targetPath
                               key:(id)key;
+ (BOOL)     aes256DecryptFromFile:(NSString *)filePath
                                to:(NSString *)targetPath
                               key:(id)key;
@end

#pragma mark -RSA
@interface MNCryptor(RSA)

@end































