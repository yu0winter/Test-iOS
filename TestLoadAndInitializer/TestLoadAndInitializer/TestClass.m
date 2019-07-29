//
//  TestClass.m
//  TestLoadAndInitializer
//
//  Created by niuyulong on 2019/7/8.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass
+ (void)load {
    NSLog(@"%s",__func__);
}

+ (void)initialize {
    NSLog(@"%s",__func__);
}

+ (void)test {
    NSLog(@"%s",__func__);
}
@end

