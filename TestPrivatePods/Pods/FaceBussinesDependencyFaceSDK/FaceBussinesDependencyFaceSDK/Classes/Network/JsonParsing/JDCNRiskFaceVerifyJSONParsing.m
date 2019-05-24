//
//  JDCNRiskFaceVerifyJSONParsing.m
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/29.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNRiskFaceVerifyJSONParsing.h"
#import "JDCNRiskFaceVerifyResultDataResponse.h"
#import "JDCNRiskFaceVerifyDataResponse.h"

static NSString * const kResponseResultCodeKey = @"resultCode";
static NSString * const kResponseResultMsgKey = @"resultMsg";
static NSString * const kResponseResultDataKey = @"resultData";
static NSString * const kResponseErrorTypeKey = @"errorType";
static NSString * const kResponseInfoKey = @"info";
static NSString * const kResponseIsSuccessKey = @"isSuccess";
static NSString * const kResponseDataKey = @"data";
static NSString * const kResponseCodeKey = @"code";
static NSString * const kResponseMessageKey = @"message";
static NSString * const kResponseResultKey = @"result";
static NSString * const kResponseVerifyIdKey = @"verifyId";
static NSString * const kResponseVerifyTokenKey = @"verifyToken";
static NSString * const kResponseVerityDateKey = @"verityDate";

@implementation JDCNRiskFaceVerifyJSONParsing

/**
 解析响应数据
 
 @param responseObject 响应数据
 @return JDCNRiskFaceVerifyResponse instance
 */
+ (JDCNRiskFaceVerifyResponse *)jsonParsingWithResponseObject:(id)responseObject {
    
    NSParameterAssert(responseObject);
    
    NSString *resultCode = @"";
    NSString *resultMsg = @"";
    NSDictionary *resultData = [NSDictionary dictionary];
    NSString *errorType = @"";
    NSString *info = @"";
    BOOL isSuccess;
    NSDictionary *data = [NSDictionary dictionary];
    NSString *code = @"";
    NSString *message = @"";
    NSString *result = @"";
    NSString *verifyId = @"";
    NSString *verifyToken = @"";
    NSString *verityDate = @"";
    
    if ([responseObject valueForKey:kResponseResultCodeKey]) {
        // 响应码
        resultCode = responseObject[kResponseResultCodeKey];
    }
    if ([responseObject valueForKey:kResponseResultMsgKey]) {
        // 响应消息
        resultMsg = responseObject[kResponseResultMsgKey];
    }
    
    NSLog(@"resultCode = %@ resultMsg = %@",resultCode, resultMsg);
    
    if ([responseObject valueForKey:kResponseResultDataKey]) {
        // 结果数据字典
        resultData = responseObject[kResponseResultDataKey];
    }
    if (resultData && resultData.allKeys.count) {
        if ([resultData valueForKey:kResponseErrorTypeKey]) {
            // 错误类型
            errorType = resultData[kResponseErrorTypeKey];
        }
        if ([resultData valueForKey:kResponseInfoKey]) {
            // 信息
            info = resultData[kResponseInfoKey];
        }
        if ([resultData valueForKey:kResponseIsSuccessKey]) {
            // 是否成功
            isSuccess = resultData[kResponseIsSuccessKey];
        }
        NSLog(@"errorType = %@ info = %@ isSuccess = %zd",errorType, info, isSuccess);
        if ([resultData valueForKey:kResponseDataKey]) {
            // 数据字典
            data = resultData[kResponseDataKey];
            
            if (data && data.allKeys.count) {
                if ([data valueForKey:kResponseCodeKey]) {
                    // 结果码
                    code = data[kResponseCodeKey];
                }
                if ([data valueForKey:kResponseMessageKey]) {
                    // 消息
                    message = data[kResponseMessageKey];
                }
                if ([data valueForKey:kResponseResultKey]) {
                    // 结果
                    NSString *result = data[kResponseResultKey];
                }
                if ([data valueForKey:kResponseVerifyIdKey]) {
                    // 验证id
                    verifyId = data[kResponseVerifyIdKey];
                }
                if ([data valueForKey:kResponseVerifyTokenKey]) {
                    // 验证token
                    verifyToken = data[kResponseVerifyTokenKey];
                }
                if ([data valueForKey:kResponseVerityDateKey]) {
                    // 验证日期
                    verityDate = data[kResponseVerityDateKey];
                }
            }
        }
    }
    NSLog(@"code = %@, message = %@, result = %@, verifyId = %@, verifyToken = %@, verityDate = %@",code, message, result, verifyId, verifyToken, verityDate);
    
    // 序列化
    JDCNRiskFaceVerifyDataResponse *riskFaceVerifyDataResponse = [[JDCNRiskFaceVerifyDataResponse alloc] init];
    riskFaceVerifyDataResponse.code = code;
    riskFaceVerifyDataResponse.message = message;
    riskFaceVerifyDataResponse.result = result;
    riskFaceVerifyDataResponse.verifyId = verifyId;
    riskFaceVerifyDataResponse.verifyToken = verifyToken;
    riskFaceVerifyDataResponse.verityDate = verityDate;
    
    JDCNRiskFaceVerifyResultDataResponse *riskFaceVerifyResultDataResponse = [[JDCNRiskFaceVerifyResultDataResponse alloc] init];
    riskFaceVerifyResultDataResponse.isSuccess = isSuccess;
    riskFaceVerifyResultDataResponse.errorType = errorType;
    riskFaceVerifyResultDataResponse.info = info;
    riskFaceVerifyResultDataResponse.data = riskFaceVerifyDataResponse;
    
    JDCNRiskFaceVerifyResponse *riskFaceVerifyResponse = [[JDCNRiskFaceVerifyResponse alloc] init];
    riskFaceVerifyResponse.resultCode = resultCode;
    riskFaceVerifyResponse.resultMsg = resultMsg;
    riskFaceVerifyResponse.resultData = riskFaceVerifyResultDataResponse;
    
    return riskFaceVerifyResponse;
    
    
}

@end
