//
//  MNCommonCryptor+SHA.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "MNCommonCryptor.h"
#import <CommonCrypto/CommonDigest.h>

#define FileHashDefaultChunkSizeForReadingData 4096

typedef NS_ENUM(NSInteger, MNSHAType)
{
    MNSHAType1,
    MNSHAType224,
    MNSHAType256,
    MNSHAType384,
    MNSHAType512
};

@implementation MNCommonCryptor (shaHash)

+ (NSString *) sha1:(NSString *)string
{
    return [self sha:string type:MNSHAType1];
}

+ (NSString *) sha224:(NSString *)string
{
    return [self sha:string type:MNSHAType224];
}

+ (NSString *) sha256:(NSString *)string
{
    return [self sha:string type:MNSHAType256];
}

+ (NSString *) sha384:(NSString *)string
{
    return [self sha:string type:MNSHAType384];
}

+ (NSString *) sha512:(NSString *)string
{
    return [self sha:string type:MNSHAType512];
}

+ (NSString *) sha1WithData:(NSData *)data
{
    return [self sha:data type:MNSHAType1];
}

+ (NSString *) sha224WithData:(NSData *)data
{
    return [self sha:data type:MNSHAType224];
}

+ (NSString *) sha256WithData:(NSData *)data
{
    return [self sha:data type:MNSHAType256];
}

+ (NSString *) sha384WithData:(NSData *)data
{
    return [self sha:data type:MNSHAType384];
}

+ (NSString *) sha512WithData:(NSData *)data
{
    return [self sha:data type:MNSHAType512];
}


+ (NSString *) sha1WithFile:(NSString *)filePath
{
    return (__bridge_transfer NSString *)FileSHAHashCreateWithPath((__bridge CFStringRef)filePath,FileHashDefaultChunkSizeForReadingData, MNSHAType1);
}

+ (NSString *) sha224WithFile:(NSString *)filePath
{
    return (__bridge_transfer NSString *)FileSHAHashCreateWithPath((__bridge CFStringRef)filePath,FileHashDefaultChunkSizeForReadingData, MNSHAType224);
}

+ (NSString *) sha256WithFile:(NSString *)filePath
{
    return (__bridge_transfer NSString *)FileSHAHashCreateWithPath((__bridge CFStringRef)filePath,FileHashDefaultChunkSizeForReadingData, MNSHAType256);
}

+ (NSString *) sha384WithFile:(NSString *)filePath
{
    return (__bridge_transfer NSString *)FileSHAHashCreateWithPath((__bridge CFStringRef)filePath,FileHashDefaultChunkSizeForReadingData, MNSHAType384);
}

+ (NSString *) sha512WithFile:(NSString *)filePath
{
    return (__bridge_transfer NSString *)FileSHAHashCreateWithPath((__bridge CFStringRef)filePath,FileHashDefaultChunkSizeForReadingData, MNSHAType512);
}

+ (NSString *)sha:(id)class type:(MNSHAType)type
{
    NSData *data;
    if ([class isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)class;
        const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
        data = [NSData dataWithBytes:cstr length:string.length];
    } else if ([class isKindOfClass:[NSData class]]) {
        data = (NSData *)class;
    } else {
        return nil;
    }
    
    NSUInteger len;
    switch (type) {
        case MNSHAType224:
            len = CC_SHA224_DIGEST_LENGTH;
            break;
        case MNSHAType256:
            len = CC_SHA256_DIGEST_LENGTH;
            break;
        case MNSHAType384:
            len = CC_SHA384_DIGEST_LENGTH;
            break;
        case MNSHAType512:
            len = CC_SHA512_DIGEST_LENGTH;
            break;
        default:
            len = CC_SHA1_DIGEST_LENGTH;
    }
    uint8_t digest[len];
    switch (type) {
        case MNSHAType224:
            CC_SHA224(data.bytes, data.length, digest);
            break;
        case MNSHAType256:
            CC_SHA256(data.bytes, data.length, digest);
            break;
        case MNSHAType384:
            CC_SHA384(data.bytes, data.length, digest);
            break;
        case MNSHAType512:
            CC_SHA512(data.bytes, data.length, digest);
            break;
        default:
            CC_SHA1(data.bytes, data.length, digest);
    }
    NSMutableString* result = [NSMutableString stringWithCapacity:len * 2];
    for(int i = 0; i < len; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

CFStringRef FileSHAHashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData, MNSHAType type) {
    
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                                     (CFStringRef)filePath,
                                                     kCFURLPOSIXPathStyle,
                                                     (Boolean)false);
    
    if (!fileURL) goto done;
    
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, (CFURLRef)fileURL);
    if (!readStream) goto done;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    switch (type) {
        case MNSHAType224:
        {
            CC_SHA256_CTX hashObject;
            CC_SHA224_Init(&hashObject);
            
            if (!chunkSizeForReadingData) {
                chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
            }
            
            bool hasMoreData = true;
            while (hasMoreData) {
                uint8_t buffer[chunkSizeForReadingData];
                CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                          (UInt8 *)buffer,
                                                          (CFIndex)sizeof(buffer));
                if (readBytesCount == -1)break;
                if (readBytesCount == 0) {
                    hasMoreData =false;
                    continue;
                }
                CC_SHA224_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
            }
            didSucceed = !hasMoreData;
            unsigned char digest[CC_SHA224_DIGEST_LENGTH];
            CC_SHA224_Final(digest, &hashObject);
            if (!didSucceed) goto done;
            
            char hash[2 *sizeof(digest) + 1];
            for (size_t i =0; i < sizeof(digest); ++i) {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = CFStringCreateWithCString(kCFAllocatorDefault,
                                               (const char *)hash,
                                               kCFStringEncodingUTF8);
            break;
        }
        case MNSHAType256:
        {
            CC_SHA256_CTX hashObject;
            CC_SHA256_Init(&hashObject);
            
            if (!chunkSizeForReadingData) {
                chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
            }
            
            bool hasMoreData = true;
            while (hasMoreData) {
                uint8_t buffer[chunkSizeForReadingData];
                CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                          (UInt8 *)buffer,
                                                          (CFIndex)sizeof(buffer));
                if (readBytesCount == -1)break;
                if (readBytesCount == 0) {
                    hasMoreData =false;
                    continue;
                }
                CC_SHA256_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
            }
            didSucceed = !hasMoreData;
            unsigned char digest[CC_SHA256_DIGEST_LENGTH];
            CC_SHA256_Final(digest, &hashObject);
            if (!didSucceed) goto done;
            
            char hash[2 *sizeof(digest) + 1];
            for (size_t i =0; i < sizeof(digest); ++i) {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = CFStringCreateWithCString(kCFAllocatorDefault,
                                               (const char *)hash,
                                               kCFStringEncodingUTF8);
            break;
        }
        case MNSHAType384:
        {
            CC_SHA512_CTX hashObject;
            CC_SHA384_Init(&hashObject);
            
            if (!chunkSizeForReadingData) {
                chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
            }
            
            bool hasMoreData = true;
            while (hasMoreData) {
                uint8_t buffer[chunkSizeForReadingData];
                CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                          (UInt8 *)buffer,
                                                          (CFIndex)sizeof(buffer));
                if (readBytesCount == -1)break;
                if (readBytesCount == 0) {
                    hasMoreData =false;
                    continue;
                }
                CC_SHA384_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
            }
            didSucceed = !hasMoreData;
            unsigned char digest[CC_SHA384_DIGEST_LENGTH];
            CC_SHA384_Final(digest, &hashObject);
            if (!didSucceed) goto done;
            
            char hash[2 *sizeof(digest) + 1];
            for (size_t i =0; i < sizeof(digest); ++i) {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = CFStringCreateWithCString(kCFAllocatorDefault,
                                               (const char *)hash,
                                               kCFStringEncodingUTF8);
            break;
        }
        case MNSHAType512:
        {
            CC_SHA512_CTX hashObject;
            CC_SHA512_Init(&hashObject);
            
            if (!chunkSizeForReadingData) {
                chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
            }
            
            bool hasMoreData = true;
            while (hasMoreData) {
                uint8_t buffer[chunkSizeForReadingData];
                CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                          (UInt8 *)buffer,
                                                          (CFIndex)sizeof(buffer));
                if (readBytesCount == -1)break;
                if (readBytesCount == 0) {
                    hasMoreData =false;
                    continue;
                }
                CC_SHA512_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
            }
            didSucceed = !hasMoreData;
            unsigned char digest[CC_SHA512_DIGEST_LENGTH];
            CC_SHA512_Final(digest, &hashObject);
            if (!didSucceed) goto done;
            
            char hash[2 *sizeof(digest) + 1];
            for (size_t i =0; i < sizeof(digest); ++i) {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = CFStringCreateWithCString(kCFAllocatorDefault,
                                               (const char *)hash,
                                               kCFStringEncodingUTF8);
            break;
        }
        default:
        {
            CC_SHA1_CTX hashObject;
            CC_SHA1_Init(&hashObject);
            
            if (!chunkSizeForReadingData) {
                chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
            }
            
            bool hasMoreData = true;
            while (hasMoreData) {
                uint8_t buffer[chunkSizeForReadingData];
                CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                          (UInt8 *)buffer,
                                                          (CFIndex)sizeof(buffer));
                if (readBytesCount == -1)break;
                if (readBytesCount == 0) {
                    hasMoreData =false;
                    continue;
                }
                CC_SHA1_Update(&hashObject, (const void *)buffer, (CC_LONG)readBytesCount);
            }
            didSucceed = !hasMoreData;
            unsigned char digest[CC_SHA1_DIGEST_LENGTH];
            CC_SHA1_Final(digest, &hashObject);
            if (!didSucceed) goto done;
            
            char hash[2 *sizeof(digest) + 1];
            for (size_t i =0; i < sizeof(digest); ++i) {
                snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
            }
            result = CFStringCreateWithCString(kCFAllocatorDefault,
                                               (const char *)hash,
                                               kCFStringEncodingUTF8);
        }
    }
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}



@end
