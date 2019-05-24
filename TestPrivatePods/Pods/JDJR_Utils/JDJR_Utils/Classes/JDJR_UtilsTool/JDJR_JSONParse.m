//
//  JDJR_JSONParse.m
//  JDJR_Utils
//
//  Created by ixf on 2018/6/18.
//

#import "JDJR_JSONParse.h"


@implementation NSObject (JDJR_JSON)

/**
 将NSDictionary对象转换成JSON字符串
 
 @return 返回json字符串
 */
- (NSString *)jdjr_toJsonStr{
    NSString *jsonString = @"";
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (error) {
            NSLog(@"Error:%@" , error);
        }
    }
    return jsonString;
}
@end


@implementation NSString (JDJR_JSON)

/**
 将JSON 转换成 Dictionary或者NSArray对象
 
 @return 返回OC对象Dictionary或者NSArray
 */
-(id)jdjr_parseToObject{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return object;
}
@end

@implementation NSData (JDJR_JSON)

/**
 将nsdata 转换成 Dictionary或者NSArray对象
 
 @return 返回OC对象Dictionary或者NSArray
 */
-(id)jdjr_parseToObject{
    NSError *err;
    id object = [NSJSONSerialization JSONObjectWithData:self
                                                options:NSJSONReadingMutableContainers
                                                  error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return object;
}
@end
