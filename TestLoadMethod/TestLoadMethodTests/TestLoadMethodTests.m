//
//  TestLoadMethodTests.m
//  TestLoadMethodTests
//
//  Created by niuyulong on 2019/5/10.
//  Copyright © 2019 nyl. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObjectZ.h"

@interface TestLoadMethodTests : XCTestCase

@end

@implementation TestLoadMethodTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    ObjectZ *object = [[ObjectZ alloc] init];
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        for (int i=0; i < 100; i++) {
            [ObjectZ replaceMethod];
        }
    }];
}
@end
