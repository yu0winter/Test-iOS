//
//  NSDate+JDJR_Category.m
//  JDJRDR_DeviceInfoLib
//
//  Created by ixf on 2018/6/13.
//  Copyright © 2018 JD. All rights reserved.
//

#import "NSDate+JDJR_Category.h"

@implementation NSDate (JDJR_Category)

/**
 获取当前时间戳

 @return 返回对应时间的时间戳
 */
+ (NSString *)jdjr_currentTimeStr {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

/**
 返回时间字符串

 @param format yyyy-MM-dd HH:mm:ss
 @return 返回时间字符串
 */
- (NSString *)jdjr_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}
@end
