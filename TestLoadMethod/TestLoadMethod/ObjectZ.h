//
//  ObjectZ.h
//  TestLoadMethod
//
//  Created by niuyulong on 2019/5/13.
//  Copyright © 2019 nyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface ObjectZ : NSObject
+ (void)testClassMethod;
- (void)reloadData;
- (void)fd_reloadData;
+ (void)replaceMethod;
@end

NS_ASSUME_NONNULL_END
