//
//  MNCommonCryptorTestCase.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/9.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNCommonCryptor.h"

@interface MNCommonCryptorTestCase : XCTestCase

@property (nonatomic, strong) NSString *clearText;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation MNCommonCryptorTestCase

- (void)setUp
{
    [super setUp];
    self.clearText = @"QWEASDZXC";
    self.filePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@".png"];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //[self testMD5];
    [self testSHA];
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
    NSString *md5 = [MNCommonCryptor md5:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(md5)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",md5);
    
    NSData *data = [self.clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *md5WithData = [MNCommonCryptor md5WithData:data];
    NSLog(@"----------------------MNCommonCryptor(md5WithData)----------------------");
    NSLog(@"data:%@",[data description]);
    NSLog(@"cipher text:%@",md5WithData);
    
    NSString *md5WithFile = [MNCommonCryptor md5WithFile:self.filePath];
    NSLog(@"----------------------MNCommonCryptor(md5WithFile)----------------------");
    NSLog(@"file path:%@",self.filePath);
    NSLog(@"cipher text:%@",md5WithFile);
    
    NSString *md5_16 = [MNCommonCryptor md5StringTo16bit:md5WithFile];
    NSLog(@"----------------------MNCommonCryptor(md5To16bit)----------------------");
    NSLog(@"md5_32bit:%@",md5);
    NSLog(@"md5_16bit:%@",md5_16);
    
    XCTAssert(YES, @"Test MD5 successed");
}

- (void) testSHA
{
    NSString *sha1 = [MNCommonCryptor sha1:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha1)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha1);
    
    NSString *sha224 = [MNCommonCryptor sha224:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha224)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha224);
    
    NSString *sha256 = [MNCommonCryptor sha256:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha256)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha256);
    
    NSString *sha384 = [MNCommonCryptor sha384:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha384)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha384);
    
    NSString *sha512 = [MNCommonCryptor sha512:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(sha512)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha512);
    
    NSData *data = [self.clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *sha1WithData = [MNCommonCryptor sha1WithData:data];
    NSLog(@"----------------------MNCommonCryptor(sha1WithData)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"cipher text:%@",sha1WithData);
    
    NSString *sha1WithFile = [MNCommonCryptor sha1WithFile:self.filePath];
    NSLog(@"----------------------MNCommonCryptor(sha1WithFile)----------------------");
    NSLog(@"file path:%@",self.filePath);
    NSLog(@"cipher text:%@",sha1WithFile);
    
    XCTAssert(YES, @"Test testSHA successed");
}

- (void) testBase64Encode
{
    NSString *b64Text = [MNCommonCryptor base64Encode:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(base64Encode)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"base64 text:%@",b64Text);
    
    NSString *clearText = [MNCommonCryptor base64Decode:b64Text];
    NSLog(@"----------------------MNCommonCryptor(base64Decode)----------------------");
    NSLog(@"base64 text:%@",b64Text);
    NSLog(@"clear text:%@",clearText);
    XCTAssertEqualObjects(clearText, self.clearText, @"Test Base64 Failed");
}

- (void) testUrlEncode
{
    NSString *urlText = [MNCommonCryptor urlEncode:self.clearText];
    NSLog(@"----------------------MNCommonCryptor(urlEncode)----------------------");
    NSLog(@"clear text:%@",self.clearText);
    NSLog(@"url text:%@",urlText);
    
    NSString *clearText = [MNCommonCryptor urlDecode:urlText];
    NSLog(@"----------------------MNCommonCryptor(urlDecode)----------------------");
    NSLog(@"url text:%@",urlText);
    NSLog(@"clear text:%@",clearText);
    XCTAssertEqualObjects(clearText, self.clearText, @"Test Url Failed");
}

@end
