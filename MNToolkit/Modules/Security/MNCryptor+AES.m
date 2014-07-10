//
//  MNCryptor+AES.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNCryptor.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

static const NSUInteger kMaxReadSize = 409600;
const CCAlgorithm kAlgorithm = kCCAlgorithmAES128;
const NSUInteger kAlgorithmKeySize = kCCKeySizeAES256;
const NSUInteger kAlgorithmBlockSize = kCCBlockSizeAES128;
const NSUInteger kPBKDFRounds = 10000;
static Byte salt[] = {5,2,1,1,9,9,4,4};
static Byte iv[]   = {5,2,1,1,9,9,4,4};

@implementation MNCryptor (AES)

+ (NSData *) aes256Encrypt:(NSString *)clearText key:(id)key
{
    return [self aes256EncryptWithData:[clearText dataUsingEncoding:NSUTF8StringEncoding] key:key];
}

+ (NSData *) aes256Decrypt:(NSString *)ciperText key:(id)key
{
    return [self aes256DecryptWithData:[ciperText dataUsingEncoding:NSUTF8StringEncoding] key:key];
}

+ (NSData *) aes256EncryptWithData:(NSData *)data key:(id)key
{
    NSData *password = [self generatePasswordWithKey:key];
    return [self aes256cryptor:kCCEncrypt data:data key:password];
}

+ (NSData *) aes256DecryptWithData:(NSData *)data key:(id)key
{
    NSData *password = [self generatePasswordWithKey:key];
    return [self aes256cryptor:kCCDecrypt data:data key:password];
}

+ (BOOL) aes256EncryptFromFile:(NSString *)filePath
                            to:(NSString *)targetPath
                           key:(id)key
{
    return [self aes256cryptorForFile:kCCEncrypt
                                 from:filePath
                                   to:targetPath
                                  key:key];
}

+ (BOOL) aes256DecryptFromFile:(NSString *)filePath
                            to:(NSString *)targetPath
                           key:(id)key
{
    return [self aes256cryptorForFile:kCCDecrypt
                                 from:filePath
                                   to:targetPath
                                  key:key];
}

+ (BOOL) aes256cryptorForFile:(CCOperation)operation
                         from:(NSString *)filePath
                           to:(NSString *)targetPath
                          key:(id)key
{
    NSData *password = [self generatePasswordWithKey:key];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        return NO;
    }
    if ([manager fileExistsAtPath:targetPath]) {
        [manager removeItemAtPath:targetPath error:nil];
    }
    [manager createFileAtPath:targetPath contents:nil attributes:nil];
    
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSFileHandle *writehHandler = [NSFileHandle fileHandleForWritingAtPath:targetPath];
    [writehHandler seekToFileOffset:0];
    unsigned long long fileSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    
    NSUInteger offset = 0;
    NSData *readData;
    while ((offset += kMaxReadSize) < fileSize) {
        readData = [self aes256cryptor:operation
                                  data:[readHandle readDataOfLength:kMaxReadSize]
                                   key:password];
        [writehHandler writeData:readData];
        [readHandle seekToFileOffset:offset];
    }
    readData = [self aes256cryptor:operation
                              data:[readHandle readDataToEndOfFile]
                               key:password];
    [writehHandler writeData:readData];
    NSLog(@"%lld",[readHandle offsetInFile]);
    [readHandle closeFile];
    [writehHandler closeFile];
    return YES;
}

+ (NSData *) aes256cryptor:(CCOperation)operation data:(NSData *)data key:(NSData *)key
{
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kAlgorithmBlockSize;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kAlgorithm,
                                          kCCOptionPKCS7Padding,
                                          [key bytes],
                                          kAlgorithmKeySize,
                                          iv,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus != kCCSuccess) {
        free(buffer);
        return nil;
    }
    return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
}

+ (NSData *) generatePasswordWithKey:(id)key
{
    NSString *keyStr;
    NSParameterAssert([key isKindOfClass: [NSData class]] || [key isKindOfClass: [NSString class]]);
    if ([key isKindOfClass:[NSString class]]) {
        keyStr = (NSString *)key;
    } else if ([key isKindOfClass:[NSData class]]) {
        NSData *keyData = (NSData *)key;
        keyStr = [[NSString alloc] initWithData:keyData encoding:NSUTF8StringEncoding];
    }
    NSMutableData *keyData = [NSMutableData dataWithLength:kAlgorithmKeySize];
    NSData *saltData = [NSData dataWithBytes:salt length:kCCKeySizeAES128];
    CCKeyDerivationPBKDF(kCCPBKDF2,
                         keyStr.UTF8String,
                         keyStr.length,
                         saltData.bytes,
                         saltData.length,
                         kCCPRFHmacAlgSHA1,
                         kPBKDFRounds,
                         keyData.mutableBytes,
                         keyData.length);
    return keyData;
}
@end