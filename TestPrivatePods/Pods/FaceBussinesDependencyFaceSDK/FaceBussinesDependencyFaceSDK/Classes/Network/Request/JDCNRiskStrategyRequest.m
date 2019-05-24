//
//  JDCNRiskStrategyRequest.m
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import "JDCNRiskStrategyRequest.h"
#import <jdcnFaceSDK/JDCNSDKManager.h>

static NSString * const kRequestAction = @"/f/sdkCmd";

static NSString * const kRequestFaceSDKKey = @"faceSDK";
static NSString * const kRequestFaceSDKVersionKey = @"faceSDKVersion";
static NSString * const kRequestTimeKey = @"reqTime";

@implementation JDCNRiskStrategyRequest

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
                      taskDidComplete:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))complete {
    NSParameterAssert(dictParameter);
    
    // 时间戳
    NSDate *dateNow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateNow timeIntervalSince1970]];
    // 拼接请求字典
    NSMutableDictionary *mutableParameter = [NSMutableDictionary dictionaryWithDictionary:dictParameter];
    [mutableParameter setValue:[JDCNSDKManager sdkName] forKey:kRequestFaceSDKKey];
    [mutableParameter setValue:[JDCNSDKManager sdkVersion] forKey:kRequestFaceSDKVersionKey];
    [mutableParameter setValue:timeSp forKey:kRequestTimeKey];
    // post请求
    [[[JDCNRiskFaceNetManager riskFaceNetManager] jdjrNetManager] POST:kRequestAction parameters:mutableParameter success:success failure:failure];
    [[[JDCNRiskFaceNetManager riskFaceNetManager] jdjrNetManager] setSessionDidBecomeInvalidBlock:invalid];
    [[[JDCNRiskFaceNetManager riskFaceNetManager] jdjrNetManager] setTaskDidCompleteBlock:complete];
}

/*
sdk活体检测策略说明，机型检测

请求
预发：172.23.88.67   identify.jd.com
线上：不配hosts

地址：http://identify.jd.com/f/sdkCmd



参数

{
    "appName": "固定传参（风控分配）",
    "appAuthorityKey": "固定传参（风控分配）",
    "verifyBusinessType": "LOGIN",
    "businessId": "固定传参（风控分配）",
    "faceSDK": "yitu:依图，jdjr: 自研",
    "faceSDKVersion": "faceSDK版本号",
    "ip": "客户端外网ip",
    "bizScene": "",//业务场景. JRAPP_LOGIN:金融app登录, 白条鉴权:BT_IDAUTH
    "pin": "",
    "loginKey": "登录key",
    "reqTime": 0,//客户端发起http的当时间戳
    "shieldInfo": {//设备信息
        "model": null,
        "imei": null,
        "macAddress": null,
        "OpenUDID": null,
        "IDFA": null,
        "ip": null,
        "clientIp": null,
        "UUID": null,
        "appId": null,
        "channelInfo": null,
        "country": null,
        "province": null,
        "city": null,
        "clientVersion": null,
        "deviceType": null,
        "latitude": null,
        "longitude": null,
        "networkType": null,
        "osPlatform": null,
        "osVersion": null,
        "resolution": null,
        "startNo": null,
        "terminalType": null,
        "openUDID": null,
        "idfa": null,
        "uuid": null
    }
}



响应


{
    "code":0,
    "data" : {
        "verifyId":"唯一请求流水id",
        "sdkCmd":"sdk操作指令", //S:静默活体, A:动作活体, D:禁用自研
        "resptime":0 //服务器响应时间戳
    }
}
*/

@end
