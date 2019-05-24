//
//  JDCNRiskStrategyRequest.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import "JDCNRiskFaceNetManager.h"

@interface JDCNRiskStrategyRequest : JDCNRiskFaceNetManager

/**
 风控策略Request
 
 @param dictParameter 请求参数字典
 @param success 成功block
 @param failure 失败block
 @param invalid 会话无效block
 @param complete 任务完成block
 */
+ (void)postRiskStrategyWithParameter:(NSDictionary *)dictParameter
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
              sessionDidBecomeInvalid:(void (^)(NSURLSession *session, NSError *error))invalid
                      taskDidComplete:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))complete;

@end
