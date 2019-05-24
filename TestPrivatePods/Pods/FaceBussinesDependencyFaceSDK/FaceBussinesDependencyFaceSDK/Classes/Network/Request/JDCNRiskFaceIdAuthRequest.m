//
//  JDCNRiskFaceIdAuthRequest.m
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/10/27.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNRiskFaceIdAuthRequest.h"
#import "JDCNRiskFaceNetManager.h"
#import <jdcnFaceSDK/JDCNSDKManager.h>

// 请求action
static NSString * const kRequestAction = @"/f/idAuth";
// sdk名称
static NSString * const kRequestFaceSDKKey = @"faceSDK";
// sdk版本
static NSString * const kRequestFaceSDKVersionKey = @"faceSDKVersion";

@implementation JDCNRiskFaceIdAuthRequest

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
                        taskDidComplete:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))complete {
    NSParameterAssert(dictParameter);
    
    // 拼接请求字典
    NSMutableDictionary *mutableParameter = [NSMutableDictionary dictionaryWithDictionary:dictParameter];
    [mutableParameter setValue:[JDCNSDKManager sdkName] forKey:kRequestFaceSDKKey];
    [mutableParameter setValue:[JDCNSDKManager sdkVersion] forKey:kRequestFaceSDKVersionKey];
    // post请求
    [[[JDCNRiskFaceNetManager riskFaceNetManager] jdjrNetManager] POST:kRequestAction parameters:mutableParameter success:success failure:failure];
    [[[JDCNRiskFaceNetManager riskFaceNetManager] jdjrNetManager] setSessionDidBecomeInvalidBlock:invalid];
    [[[JDCNRiskFaceNetManager riskFaceNetManager] jdjrNetManager] setTaskDidCompleteBlock:complete];
}

/*
 HTTP
 预发：172.23.88.67   identify.jd.com
 线上：不配hosts
 
 地址：http://identify.jd.com/f/idAuth
 
 post方式
 请求需要携带header
 Accept    application/json
 Content-Type    application/json
 
 
 参数：
 {
 "appName": "a******************ph",
 "appAuthorityKey": "qroe******************zw==",
 "verifyBusinessType": "",
 "businessId": "******************",
 "faceSDK": "jdin",
 "faceSDKVersion": "1.0",
 "ip": "61.148.244.209",
 "shieldInfo": {
 "model": "Xiaomi_Xiaomi_MI 6",
 "imei": "865873036862641",
 "macAddress": "6A4E43756250",
 "OpenUDID": null,
 "IDFA": null,
 "ip": "",
 "clientIp": "",
 "UUID": null,
 "appId": "com.jd.jrapp",
 "channelInfo": "JDJR",
 "country": "??",
 "province": "???",
 "city": "???",
 "clientVersion": "4.2.0",
 "deviceType": "MI 6",
 "latitude": "39.785973",
 "longitude": "116.563347",
 "networkType": "4G",
 "osPlatform": "android",
 "osVersion": "7.1.1",
 "resolution": "1080.0*1920.0",
 "startNo": 192,
 "terminalType": 2,
 "openUDID": null,
 "idfa": null,
 "uuid": null
 },
 "pin": "l************y",
 "faceData": [
 "FF#ff17e0a4d3f5286583c345cd8ac7caf0:jdin:1.0:/9j/4AAQSkZJRgA/2Q==",
 "SFF#cf6932678bc7ef79a047dc029b19b6d3:jdin:1.0:/9j/4AAQSkZJRgABAQAAAQABAAOJbfsCY//2Q=="
 ]
 }
 
 
 */

@end
