//
//  ObjectZ.m
//  TestLoadMethod
//
//  Created by niuyulong on 2019/5/13.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ObjectZ.h"

@implementation ObjectZ

+ (void)initialize {
    
}

+ (void)testClassMethod {
    
}

+ (void)replaceMethod {
    SEL selectors[] = {
        @selector(reloadData),
    };

    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"fd_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)reloadData {

}

- (void)fd_reloadData {

}


@end
