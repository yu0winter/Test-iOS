//
//  JDCNRiskStrategyJSONParsing.m
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/29.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNRiskStrategyJSONParsing.h"
#import "JDCNRiskStrategyDataResponse.h"

static NSString * const kResponseCodeKey = @"code";
static NSString * const kResponseMsgKey = @"msg";
static NSString * const kResponseDataKey = @"data";
static NSString * const kResponseRespTimeKey = @"resptime";
static NSString * const kResponseSdkCmdKey = @"sdkCmd";
static NSString * const kResponseVerifyId = @"verifyId";

@implementation JDCNRiskStrategyJSONParsing

/**
 解析响应数据
 
 @param responseObject 响应数据
 @return JDCNRiskStrategyResponse instance
 */
+ (JDCNRiskStrategyResponse *)jsonParsingWithResponseObject:(id)responseObject {
    
    NSParameterAssert(responseObject);
    
    NSString *code = @"";
    NSString *msg = @"";
    NSDictionary *data = [NSDictionary dictionary];
    NSString *resptime = @"";
    NSString *sdkCmd = @"";
    NSString *verifyId = @"";
    
    if ([responseObject valueForKey:kResponseCodeKey]) {
        // 状态码
        code = responseObject[kResponseCodeKey];
    }
    if ([responseObject valueForKey:kResponseMsgKey]) {
        // 响应消息
        msg = responseObject[kResponseMsgKey];
    }
    if ([responseObject valueForKey:kResponseDataKey]) {
        // 数据data
        data = responseObject[kResponseDataKey];
    }
    
    if (data && data.allKeys.count) {
        if ([data valueForKey:kResponseRespTimeKey]) {
            // 响应时间
            resptime = data[kResponseRespTimeKey];
        }
        if ([data valueForKey:kResponseSdkCmdKey]) {
            // sdk指令
            sdkCmd = data[kResponseSdkCmdKey];
        }
        if ([data valueForKey:kResponseVerifyId]) {
            // 验证id
            verifyId = data[kResponseVerifyId];
        }
    }
    
    NSLog(@"code = %@ msg = %@ resptime = %@ sdkCmd = %@ verifyId = %@",code, msg, resptime, sdkCmd, verifyId);
    
    // 序列化
    JDCNRiskStrategyResponse *riskStrategyResponse = [[JDCNRiskStrategyResponse alloc] init];
    riskStrategyResponse.code = code;
    riskStrategyResponse.msg = msg;
    JDCNRiskStrategyDataResponse *dataResponse = [[JDCNRiskStrategyDataResponse alloc] init];
    dataResponse.resptime = resptime;
    dataResponse.sdkCmd = sdkCmd;
    dataResponse.verifyId = verifyId;
    riskStrategyResponse.data = dataResponse;
    
    return riskStrategyResponse;
}

@end
