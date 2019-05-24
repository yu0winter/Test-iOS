//
//  NSString+JDJR_Category.m
//  JDJR_Utils
//
//  Created by 成勇 on 2018/9/13.
//

#import "NSString+JDJR_Category.h"

@implementation NSString (JDJR_Category)

/**
 👍 返回long型value值
 
 @return 返回longvalue值
 */
- (long)jdjr_longValue {
    return (long)[self integerValue];
}

/**
 👍 返回number值
 
 @return 返回number值
 */
- (NSNumber *)jdjr_numberValue {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    return [formatter numberFromString:self];
}

@end
