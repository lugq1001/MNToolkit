//
//  MNCryptorTestCase.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNCryptor.h"

@interface MNCryptorTestCase : XCTestCase

@property (nonatomic, strong) NSString *clearText;
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *key;

@end

@implementation MNCryptorTestCase

- (void)setUp
{
    [super setUp];
    self.clearText = @"QWEASDZXC";
    self.filePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@".png"];
    self.key = @"123456";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) testMD5
{
    NSString *md5 = [MNCryptor md5:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(md5)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",md5);
    
    NSData *data = [self.clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *md5WithData = [MNCryptor md5WithData:data];
    NSLog(@"----------------------MNCommonCryptor(md5WithData)----------------------");
    NSLog(@"data:%@",[data description]);
    NSLog(@"cipher text:%@",md5WithData);
    
    NSString *md5WithFile = [MNCryptor md5WithFile:self.filePath];
    NSLog(@"----------------------MNCommonCryptor(md5WithFile)----------------------");
    NSLog(@"file path:%@",self.filePath);
    NSLog(@"cipher text:%@",md5WithFile);
    
    NSString *md5_16 = [MNCryptor md5StringTo16bit:md5WithFile];
    NSLog(@"----------------------MNCommonCryptor(md5To16bit)----------------------");
    NSLog(@"md5_32bit:%@",md5);
    NSLog(@"md5_16bit:%@",md5_16);
    
}

- (void) testSHA
{
    NSString *sha1 = [MNCryptor sha1:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha1)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha1);
    
    NSString *sha224 = [MNCryptor sha224:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha224)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha224);
    
    NSString *sha256 = [MNCryptor sha256:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha256)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha256);
    
    NSString *sha384 = [MNCryptor sha384:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha384)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha384);
    
    NSString *sha512 = [MNCryptor sha512:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha512)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha512);
    
    NSData *data = [self.clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sha1WithData = [MNCryptor sha1WithData:data];
    NSLog(@"----------------------MNCommonCryptor(sha1WithData)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha1WithData);
    
    NSString *sha1WithFile = [MNCryptor sha1WithFile:self.filePath];
    NSLog(@"----------------------MNCommonCryptor(sha1WithFile)----------------------");
    NSLog(@"file path:%@",self.filePath);
    NSLog(@"cipher text:%@",sha1WithFile);
    
    XCTAssert(YES, @"Test testSHA successed");
}

- (void) testBase64Encode
{
    NSString *b64Text = [MNCryptor base64Encode:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(base64Encode)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"base64 text:%@",b64Text);
    
    NSString *clearText = [MNCryptor base64Decode:b64Text];
    NSLog(@"----------------------MNCommonCryptor(base64Decode)----------------------");
    NSLog(@"base64 text:%@",b64Text);
    NSLog(@"clear text:%@",clearText);
    XCTAssertEqualObjects(clearText, self.clearText, @"Test base64 encoding failed");
    
    NSData *data = [self.clearText dataUsingEncoding:NSASCIIStringEncoding];
    b64Text = [MNCryptor base64EncodeWithData:data];
    NSLog(@"----------------------MNCommonCryptor(base64EncodeWithData)----------------------");
    NSLog(@"clear data:%s",[[data description] UTF8String]);
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"base64 text:%@",b64Text);
    
    clearText = [MNCryptor base64Decode:b64Text];
    NSLog(@"----------------------MNCommonCryptor(base64Decode)----------------------");
    NSLog(@"base64 text:%@",b64Text);
    NSLog(@"clear text:%@",clearText);
    XCTAssertEqualObjects(clearText, self.clearText, @"Test base64 encoding failed");
    
    data = [MNCryptor base64DecodeForData:b64Text];
    NSLog(@"----------------------MNCommonCryptor(base64DecodeForData)----------------------");
    NSLog(@"base64 text:%@",b64Text);
    NSLog(@"clear data:%s",[[data description] UTF8String]);
    
    //test file
    data = [NSData dataWithContentsOfFile:self.filePath];
    b64Text = [MNCryptor base64EncodeWithData:data];
    NSLog(@"----------------------MNCommonCryptor(base64EncodeWithData)----------------------");
    NSLog(@"file path:%@",self.filePath);
    NSLog(@"base64 text:%@",b64Text);
    
}

- (void) testUrlEncode
{
    NSString *urlText = [MNCryptor urlEncode:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(urlEncode)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"url text:%@",urlText);
    
    NSString *clearText = [MNCryptor urlDecode:urlText];
    NSLog(@"----------------------MNCommonCryptor(urlDecode)----------------------");
    NSLog(@"url text:%@",urlText);
    NSLog(@"clear text:%@",clearText);
    XCTAssertEqualObjects(clearText, self.clearText, @"Test url encoding failed");
}

- (void) testAES
{
    {
        NSData *data = [self.clearText dataUsingEncoding:NSUTF8StringEncoding];
        NSString *dataB64 = [MNCryptor base64EncodeWithData:data];
        NSData *aes256encrypt = [MNCryptor aes256EncryptWithData:data key:self.key];
        NSString *encryptB64 = [MNCryptor base64EncodeWithData:aes256encrypt];
        NSLog(@"----------------------MNCommonCryptor(aes256Encrypt)----------------------");
        NSLog(@"clear text:%@",self.clearText);
        NSLog(@"clear data:%s",[[data description] UTF8String]);
        NSLog(@"clear data base64:%@",dataB64);
        NSLog(@"cipher text base64:%@",encryptB64);
        NSLog(@"cipher data:%s",[[aes256encrypt description] UTF8String]);
        
        NSData *cipherData = [MNCryptor base64DecodeForData:encryptB64];
        data = [MNCryptor aes256DecryptWithData:cipherData key:self.key];
        NSString *decryptB64 = [MNCryptor base64EncodeWithData:data];
        NSLog(@"----------------------MNCommonCryptor(aes256Decrypt)----------------------");
        NSLog(@"cipher data:%s",[[cipherData description] UTF8String]);
        NSLog(@"clear text:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"clear data base64:%@",decryptB64);
        
        XCTAssertEqualObjects(dataB64, decryptB64, @"Test aes failed");
    }
    
    {
        
        NSData *fileData = [NSData dataWithContentsOfFile:self.filePath];
        NSData *encrypt = [MNCryptor aes256EncryptWithData:fileData key:self.key];
        NSString *encryptB64 = [MNCryptor base64EncodeWithData:encrypt];
        
        //test file
        NSString *target = [NSTemporaryDirectory() stringByAppendingPathComponent:@"dog.bat"];
        [MNCryptor aes256EncryptFromFile:self.filePath to:target key:self.key];
        NSData *encryptData = [NSData dataWithContentsOfFile:target];
        NSString *targetB64 = [MNCryptor base64EncodeWithData:encryptData];
        NSLog(@"----------------------MNCommonCryptor(aes256EncryptFromFile)----------------------");
        NSLog(@"file path:%@",self.filePath);
        NSLog(@"file encrypt b64:%@",encryptB64);
        NSLog(@"==================================================================================================");
        NSLog(@"target b64:%@",targetB64);
        XCTAssertEqualObjects(encryptB64, targetB64, @"Test aes file failed");
        
        NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:@"dog.png"];
        [MNCryptor aes256DecryptFromFile:target to:file key:self.key];
        
    }
}

@end