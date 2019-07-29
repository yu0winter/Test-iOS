//
//  main.m
//  TestLoadAndInitializer
//
//  Created by niuyulong on 2019/7/8.
//  Copyright © 2019 nyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestClass.h"
#import "TestClass+DuplicateMethod.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        [TestClass test];
        NSLog(@"Hello, World!");
    }
    return 0;
}
