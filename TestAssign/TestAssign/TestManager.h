//
//  TestManager.h
//  TestSharedInstance
//
//  Created by niuyulong on 2019/9/11.
//  Copyright © 2019 nyl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestManager : NSObject
// 导致了崩溃
@property(nonatomic, assign) NSArray *shownHistory;
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
