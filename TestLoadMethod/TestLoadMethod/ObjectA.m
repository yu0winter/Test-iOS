//
//  ObjectA.m
//  TestLoadMethod
//
//  Created by niuyulong on 2019/5/10.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ObjectA.h"

@interface ObjectA ()

@end
@implementation ObjectA
+ (void)load {
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
    NSLog(@"reloadData");
}

- (void)fd_reloadData {
    NSLog(@"fd_reloadData");
    [self fd_reloadData];
}
@end

@interface ObjectA1 ()

@end
@implementation ObjectA1
+ (void)load {
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
    NSLog(@"reloadData");
}

- (void)fd_reloadData {
    NSLog(@"fd_reloadData");
    [self fd_reloadData];
}
@end
@interface ObjectA2 ()

@end
@implementation ObjectA2
+ (void)load {
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
@interface ObjectA3 ()

@end
@implementation ObjectA3
+ (void)load {
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
@interface ObjectA4 ()

@end
@implementation ObjectA4
+ (void)load {
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
@interface ObjectA5 ()

@end
@implementation ObjectA5
+ (void)load {
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
@interface ObjectA6 ()

@end
@implementation ObjectA6
+ (void)load {
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
@interface ObjectA7 ()

@end
@implementation ObjectA7
+ (void)load {
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
@interface ObjectA8 ()

@end
@implementation ObjectA8
+ (void)load {
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
@interface ObjectA9 ()

@end
@implementation ObjectA9
+ (void)load {
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
@interface ObjectA10 ()

@end
@implementation ObjectA10
+ (void)load {
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
@interface ObjectA11 ()

@end
@implementation ObjectA11
+ (void)load {
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
@interface ObjectA12 ()

@end
@implementation ObjectA12
+ (void)load {
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
@interface ObjectA13 ()

@end
@implementation ObjectA13
+ (void)load {
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
@interface ObjectA14 ()

@end
@implementation ObjectA14
+ (void)load {
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
@interface ObjectA15 ()

@end
@implementation ObjectA15
+ (void)load {
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
@interface ObjectA16 ()

@end
@implementation ObjectA16
+ (void)load {
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
@interface ObjectA17 ()

@end
@implementation ObjectA17
+ (void)load {
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
@interface ObjectA18 ()

@end
@implementation ObjectA18
+ (void)load {
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
@interface ObjectA19 ()

@end
@implementation ObjectA19
+ (void)load {
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

