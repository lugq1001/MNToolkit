//
//  NSString+MNToolkitTests.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNToolkit.h"
#import "NSString+MNToolkit.h"

@interface NSString_MNToolkitTests : XCTestCase

@property (nonatomic, strong) NSString *testString;

@end

@implementation NSString_MNToolkitTests

- (void)setUp {
    [super setUp];
    self.testString = @"2014-01-01 00:00:00";
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    NSLog(@"======================================================================");
    NSLog(@"sandboxPathApp:%@",[MNToolkit sandboxPathApp]);
    NSLog(@"sandboxPathDocuments:%@",[MNToolkit sandboxPathDocuments]);
    NSLog(@"sandboxPathHome:%@",[MNToolkit sandboxPathHome]);
    NSLog(@"sandboxPathLibrary:%@",[MNToolkit sandboxPathLibrary]);
    NSLog(@"sandboxPathLibraryCaches:%@",[MNToolkit sandboxPathLibraryCaches]);
    NSLog(@"sandboxPathTmp:%@",[MNToolkit sandboxPathTmp]);
    NSLog(@"sandboxFilePath:%@",[MNToolkit sandboxFilePath:@"dog" suffix:@"png"]);
    
    NSLog(@"testString:%@",self.testString);
    NSLog(@"reverse:%@",[self.testString reverse]);
    NSLog(@"newDate:%@",[self.testString newDateFrom:@"yyyy-MM-dd HH:mm:ss" to:@"yyyy/MM/dd HH-mm-ss"]);
    NSLog(@"======================================================================");
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
