//
//  JDCNRiskFaceVerifyRequest.m
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import "JDCNRiskFaceVerifyRequest.h"
#import "JDCNRiskFaceNetManager.h"
#import <jdcnFaceSDK/JDCNSDKManager.h>

static NSString * const kRequestAction = @"/f/verify";

static NSString * const kRequestFaceSDKKey = @"faceSDK";
static NSString * const kRequestFaceSDKVersionKey = @"faceSDKVersion";

@implementation JDCNRiskFaceVerifyRequest

/**
 风控人脸验证Request
 
 @param dictParameter 请求参数字典
 @param success 成功block
 @param failure 失败block
 @param invalid 会话无效block
 @param complete 任务完成block
 */
+ (void)postRiskFaceVerifyWithParameter:(NSDictionary *)dictParameter
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
 sdk直接走https调用风控
 请求
 预发：172.23.88.67   identify.jd.com
 线上：不配hosts
 
 地址：http://identify.jd.com/f/verify
 
 参数
 注意：faceData具体
 
 {
 "appName": null,
 "appAuthorityKey": null,
 "verifyBusinessType": null,
 "businessId": null,
 "faceSDK": null,
 "faceSDKVersion": null,
 "ip": null,
 "pin": null,
 "photoType": null,
 "faceData": [
 "图片内容"
 ],
 "errorNum": 0,
 "kFaceLiveSessionId": "",
 "loginKey": null,
 "extra": null,
 "shieldInfo": {
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
     "resultCode": 0,
     "resultMsg": "通讯正常 特殊处理，不记在异常中，成功",
     "resultData": {
         "isSuccess": true,
         "errorType": "",
         "info": null,
         "data": {
         "verifyId": "54231023-1501212796526-1887051269",
         "result": "VARIFY_PASS",
         "verifyToken": "lyf/11aCW8XuxoX/wSDVdwg5EVKJTW6GdqUI9dznAJzfTS7vRByec4Ce3On0GgqzrgljRmXqZJ9IKlz4O9ks3vaFR64puRo0mY6i8LXsm3xzPZfUxmDNrP1pOhaGvY2oiq4asG5oJjYoCHnpHGdz5oCxeWDkN6iVB71ip7w0c13qRYPYubEwijjHAJVnjQ/N",
         "verityDate": 1501212798649,
         "message": null,
         "code": 0
         }
     }
 }


 */

@end
