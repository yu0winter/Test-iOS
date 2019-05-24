//
//  NSDate+JDJR_Category.h
//  JDJRDR_DeviceInfoLib
//
//  Created by ixf on 2018/6/13.
//  Copyright © 2018 JD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JDJR_Category)

/**
 获取当前时间戳
 
 @return 返回对应时间的时间戳
 */
+ (NSString *)jdjr_currentTimeStr;

/**
 返回时间字符串
 
 @param format yyyy-MM-dd HH:mm:ss
 @return 返回时间字符串
 */
- (NSString *)jdjr_stringWithFormat:(NSString *)format ;
@end
