//
//  JDJR_JSONParse.h
//  JDJR_Utils
//
//  Created by ixf on 2018/6/18.
//

#import <Foundation/Foundation.h>


@interface NSObject (JDJR_JSON)

/**
 将NSObject对象转换成JSON字符串

 @return 返回json字符串
 */
- (NSString *)jdjr_toJsonStr;
@end


@interface NSString (JDJR_JSON)

/**
 将JSON 转换成 Dictionary或者NSArray对象

 @return 返回OC对象Dictionary或者NSArray
 */
-(id)jdjr_parseToObject;
@end

@interface NSData (JDJR_JSON)

/**
 将nsdata 转换成 Dictionary或者NSArray对象

 @return 返回OC对象Dictionary或者NSArray
 */
-(id)jdjr_parseToObject;
@end

