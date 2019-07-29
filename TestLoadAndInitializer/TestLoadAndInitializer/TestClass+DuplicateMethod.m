//
//  TestClass+DuplicateMethod.m
//  TestLoadAndInitializer
//
//  Created by niuyulong on 2019/7/8.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "TestClass+DuplicateMethod.h"

@implementation TestClass (DuplicateMethod)
+ (void)load {
    NSLog(@"DuplicateMethod : %s",__func__);
}
+ (void)initialize {
    NSLog(@"DuplicateMethod : %s",__func__);
}
@end
