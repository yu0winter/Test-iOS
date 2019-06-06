//
//  ObjectB.m
//  TestLoadMethod
//
//  Created by niuyulong on 2019/5/10.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ObjectB.h"

@interface ObjectB ()

@end
@implementation ObjectB
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

@interface ObjectB1 ()

@end
@implementation ObjectB1
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
@interface ObjectB2 ()

@end
@implementation ObjectB2
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
@interface ObjectB3 ()

@end
@implementation ObjectB3
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
@interface ObjectB4 ()

@end
@implementation ObjectB4
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
@interface ObjectB5 ()

@end
@implementation ObjectB5
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
@interface ObjectB6 ()

@end
@implementation ObjectB6
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
@interface ObjectB7 ()

@end
@implementation ObjectB7
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
@interface ObjectB8 ()

@end
@implementation ObjectB8
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
@interface ObjectB9 ()

@end
@implementation ObjectB9
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
@interface ObjectB10 ()

@end
@implementation ObjectB10
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
@interface ObjectB11 ()

@end
@implementation ObjectB11
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
@interface ObjectB12 ()

@end
@implementation ObjectB12
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
@interface ObjectB13 ()

@end
@implementation ObjectB13
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
@interface ObjectB14 ()

@end
@implementation ObjectB14
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
@interface ObjectB15 ()

@end
@implementation ObjectB15
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
@interface ObjectB16 ()

@end
@implementation ObjectB16
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
@interface ObjectB17 ()

@end
@implementation ObjectB17
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
@interface ObjectB18 ()

@end
@implementation ObjectB18
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
@interface ObjectB19 ()

@end
@implementation ObjectB19
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

