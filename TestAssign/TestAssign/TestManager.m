//
//  TestManager.m
//  TestSharedInstance
//
//  Created by niuyulong on 2019/9/11.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "TestManager.h"
NSString * const kJRPeterDoorbellLocalConfig = @"kJRPeterDoorbellLocalConfig";
@implementation TestManager
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TestManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    [instance loadFromUserDefault];
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (void)loadFromUserDefault {

    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kJRPeterDoorbellLocalConfig];
    
//    if (!dic || [dic isKindOfClass:[NSDictionary class]] == NO) return;
    
    
    self.shownHistory = @[@"dsds",@"dsfs"];
}
@end
