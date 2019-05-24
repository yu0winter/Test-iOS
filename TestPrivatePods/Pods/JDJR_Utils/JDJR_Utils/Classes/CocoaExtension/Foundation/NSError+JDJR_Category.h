//
//  NSError+JDJR_Category.h
//  JDJR_Utils
//
//  Created by ixf on 2018/7/24.
//

#import <Foundation/Foundation.h>

@interface NSError (JDJR_Category)

/**
 更具错误提示 生成错误对象
 
 @param description 错误描述
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDescription:(NSString*)description;


/**
 更具错误提示 和错误码 生成错误对象
 
 @param code 错误码
 @param description 错误描述
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithCode:(NSInteger)code andDescription:(NSString*)description;


/**
 更具错误提示 错误码 domain 生成错误对象
 
 @param domain 错误提示
 @param code 错误码
 @param description 错误提示
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDomain:(NSString*)domain code:(NSInteger)code andDescription:(NSString*)description;


/**
 更具错误提示 错误码 domain 错误原因 生成错误对象
 
 @param domain 错误domain
 @param code 错误码
 @param description 错误提示
 @param failureReasonError 错误原因
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDomain:(NSString*)domain code:(NSInteger)code andDescription:(NSString*)description andFailureReasonError:(NSString*)failureReasonError;


/**
 更具错误提示 错误码 domain 错误原因 介意行为 生成错误对象
 
 @param domain 错误domain
 @param code 错误码
 @param description 错误描述
 @param failureReasonError 错误原因
 @param recoverySuggestionError 错误介意
 @return 错误对象
 */
+ (NSError*)jdjr_ErrorWithDomain:(NSString*)domain code:(NSInteger)code andDescription:(NSString*)description andFailureReasonError:(NSString*)failureReasonError andRecoverySuggestionError:(NSString*)recoverySuggestionError;
@end
