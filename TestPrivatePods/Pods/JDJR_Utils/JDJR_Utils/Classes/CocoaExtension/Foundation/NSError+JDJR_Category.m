//
//  NSError+JDJR_Category.m
//  JDJR_Utils
//
//  Created by ixf on 2018/7/24.
//

#import "NSError+JDJR_Category.h"

@implementation NSError (JDJR_Category)


/**
 更具错误提示 生成错误对象

 @param description 错误描述
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDescription:(NSString*)description{
    return [NSError jdjr_ErrorWithCode:10010 andDescription:description];
}


/**
 更具错误提示 和错误码 生成错误对象

 @param code 错误码
 @param description 错误描述
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithCode:(NSInteger)code andDescription:(NSString*)description{
    return [NSError jdjr_ErrorWithDomain:@"client.custom.error" code:code andDescription:description];
}


/**
 更具错误提示 错误码 domain 生成错误对象

 @param domain 错误提示
 @param code 错误码
 @param description 错误提示
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDomain:(NSString*)domain code:(NSInteger)code andDescription:(NSString*)description{
    return [NSError jdjr_ErrorWithDomain:domain code:code andDescription:description andFailureReasonError:@"发生错误啦~"];
}


/**
 更具错误提示 错误码 domain 错误原因 生成错误对象

 @param domain 错误domain
 @param code 错误码
 @param description 错误提示
 @param failureReasonError 错误原因
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDomain:(NSString*)domain code:(NSInteger)code andDescription:(NSString*)description andFailureReasonError:(NSString*)failureReasonError {
    return [NSError jdjr_ErrorWithDomain:domain code:code andDescription:description andFailureReasonError:failureReasonError andRecoverySuggestionError:@"重新试试~~"];
}


/**
 更具错误提示 错误码 domain 错误原因 介意行为 生成错误对象

 @param domain 错误domain
 @param code 错误码
 @param description 错误描述
 @param failureReasonError 错误原因
 @param recoverySuggestionError 错误介意
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDomain:(NSString*)domain code:(NSInteger)code andDescription:(NSString*)description andFailureReasonError:(NSString*)failureReasonError andRecoverySuggestionError:(NSString*)recoverySuggestionError{
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: description,
                               NSLocalizedFailureReasonErrorKey: failureReasonError,
                               NSLocalizedRecoverySuggestionErrorKey: recoverySuggestionError
                               };
    return [NSError errorWithDomain: domain
                               code: code
                           userInfo: userInfo];
}

@end
