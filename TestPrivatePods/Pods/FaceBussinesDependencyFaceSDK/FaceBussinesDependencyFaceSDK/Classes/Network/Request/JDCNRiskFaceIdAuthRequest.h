//
//  JDCNRiskFaceIdAuthRequest.h
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/10/27.
//  Copyright © 2017年 JDJR. All rights reserved.
//  idAuth Request

#import "JDCNRiskFaceNetManager.h"
@interface JDCNRiskFaceIdAuthRequest : JDCNRiskFaceNetManager

/**
 人脸验证Request
 
 @param dictParameter 请求参数字典
 @param success 成功block
 @param failure 失败block
 @param invalid 会话无效block
 @param complete 任务完成block
 */
+ (void)postRiskFaceIdAuthWithParameter:(NSDictionary *)dictParameter
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                sessionDidBecomeInvalid:(void (^)(NSURLSession *session, NSError *error))invalid
                        taskDidComplete:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))complete;

@end
