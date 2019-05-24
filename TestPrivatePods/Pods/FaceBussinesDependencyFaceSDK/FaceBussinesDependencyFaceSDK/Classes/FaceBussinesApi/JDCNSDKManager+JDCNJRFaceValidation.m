//
//  JDCNSDKManager+JDCNJRFaceValidation.m
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/11/16.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNSDKManager+JDCNJRFaceValidation.h"
#import "JDCNRiskFaceVerifyRequest.h"
#import "JDCNRiskFaceIdAuthRequest.h"
#import "JDCNSDKManager+FaceVerify.h"

#define JDCNStringIsNull(string)  {if((NSNull*)string == [NSNull null]){string = nil;}}

// APP名称 KEY
static NSString * const kRequestJDTDAppNameKey = @"appName";
// APP授权 KEY
static NSString * const kRequestJDTDAppAuthorityKey = @"appAuthorityKey";
// 业务ID KEY
static NSString * const kRequestJDTDBussinessIdKey = @"businessId";
// shieldInfo KEY
static NSString * const kRequestShieldInfoKey = @"shieldInfo";
// pin KEY
static NSString * const kRequestPinKey = @"pin";
// name KEY
static NSString * const kRequestNameKey = @"name";
// idCard KEY
static NSString * const kRequestIdCardKey = @"idCard";
// faceData KEY
static NSString * const kRequestFaceDataKey = @"faceData";
// sdkCmd
static NSString * const kRequestSdkCmdKey = @"sdkCmd";
// extra
static NSString * const kRequestJDTDExtraKey = @"extra";

// verifyBusinessType Key
static NSString * const kRequestBusinessTypeKey = @"verifyBusinessType";
// verifyBusinessType value
static NSString * const kRequestBusinessTypeValue = @"SIMPLE_VERIFY";
// kRequestBusinessTypeWithPinValue
static NSString * const kRequestBusinessTypeWithPinValue = @"MESHED_PHOTO_VERIFY";
// kRequestSdkCmdActionValue
static NSString * const kRequestSdkCmdActionValue = @"A";
// kRequestSdkCmdSlicnesValue
static NSString * const kRequestSdkCmdSlicnesValue = @"S";

@implementation JDCNSDKManager (JDCNJRFaceValidation)

/**
 刷脸验证(基于京东体系)
 
 @param appName 服务端分配的appName(必传 NONNULL)
 @param appAuthorityKey 服务端分配的app授权Key (必传 NONNULL)
 @param businessId 服务端分配的业务id(必传 NONNULL)
 @param pin 用户pin（必传 NONNULL）
 @param deviceInfo 设备信息 （非必传 可空）
 @param arrayAuthFaceData AKS加密的刷脸数据集合(必传 NONNULL SDK返回的faceData)
 @param arrayAuthFaceOtherData AKS加密的其它数据集合（非必传 身份证、驾照等数据）
 */
- (void)jdjrFaceIdAuthJDSystemWithAllocationAppName:(NSString *)appName
                      withAllocationAppAuthorityKey:(NSString *)appAuthorityKey
                           withAllocationBusinessId:(NSString *)businessId
                                          withJDPin:(NSString *)pin
                                     withDeviceInfo:(NSDictionary * _Nullable)deviceInfo
                                   withAuthFaceData:(NSArray *)arrayAuthFaceData
                              withAuthFaceOtherData:(NSArray <NSData *> * _Nullable)arrayAuthFaceOtherData
                                        didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete {
    NSParameterAssert(appName);
    NSParameterAssert(appAuthorityKey);
    NSParameterAssert(businessId);
    NSParameterAssert(pin);
    NSParameterAssert(arrayAuthFaceData);
    
    [self private_jdjrfaceIdAuthWithAllocationAppName:appName
                        withAllocationAppAuthorityKey:appAuthorityKey
                             withAllocationBusinessId:businessId
                                            withJDPin:pin
                                         withIdCardNo:nil
                                             withName:nil
                                       withDeviceInfo:deviceInfo
                                     withAuthFaceData:arrayAuthFaceData
                                withAuthFaceOtherData:arrayAuthFaceOtherData
                                       withIsJDSystem:YES
                                          didComplete:complete];
}

/**
 刷脸验证(非京东体系)
 
 @param appName 服务端分配的appName(必传 NONNULL)
 @param appAuthorityKey 服务端分配的app授权Key (必传 NONNULL)
 @param businessId 服务端分配的业务id(必传 NONNULL)
 @param idCardNo 身份证号 (必传 NONNULL)
 @param name 姓名 (必传 NONNULL)
 @param deviceInfo 设备信息 （非必传 可空）
 @param arrayAuthFaceData AKS加密的刷脸数据集合(必传 NONNULL SDK返回的faceData)
 @param arrayAuthFaceOtherData AKS加密的其它数据集合（非必传 身份证、驾照等数据）
 */
- (void)jdjrFaceIdAuthOtherSystemWithAllocationAppName:(NSString *)appName
                         withAllocationAppAuthorityKey:(NSString *)appAuthorityKey
                              withAllocationBusinessId:(NSString *)businessId
                                          withIdCardNo:(NSString *)idCardNo
                                              withName:(NSString *)name
                                        withDeviceInfo:(NSDictionary * _Nullable)deviceInfo
                                      withAuthFaceData:(NSArray *)arrayAuthFaceData
                                 withAuthFaceOtherData:(NSArray <NSData *> * _Nullable)arrayAuthFaceOtherData
                                           didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete {
    
    NSParameterAssert(appName);
    NSParameterAssert(appAuthorityKey);
    NSParameterAssert(businessId);
    NSParameterAssert(idCardNo);
    NSParameterAssert(name);
    NSParameterAssert(arrayAuthFaceData);
    
    [self private_jdjrfaceIdAuthWithAllocationAppName:appName
                        withAllocationAppAuthorityKey:appAuthorityKey
                             withAllocationBusinessId:businessId
                                            withJDPin:nil
                                         withIdCardNo:idCardNo
                                             withName:name
                                       withDeviceInfo:deviceInfo
                                     withAuthFaceData:arrayAuthFaceData
                                withAuthFaceOtherData:arrayAuthFaceOtherData
                                       withIsJDSystem:NO
                                          didComplete:complete];
    
}

#pragma mark - PrivateMethod
/**
 刷脸验证(私有)
 
 @param appName 服务端分配的appName(必传 NONNULL)
 @param appAuthorityKey 服务端分配的app授权Key (必传 NONNULL)
 @param businessId 服务端分配的业务id(必传 NONNULL)
 @param pin 用户pin（非必传 可空）
 @param idCardNo 身份证号 (非必传 可空)
 @param name 姓名 (非必传 可空)
 @param deviceInfo 设备信息 （非必传 可空）
 @param arrayAuthFaceData AKS加密的刷脸数据集合(必传 NONNULL SDK返回的faceData)
 @param arrayAuthFaceOtherData AKS加密的其它数据集合（非必传 身份证、驾照等数据）
 @param isJDSystem 是否京东体系
 */
- (void)private_jdjrfaceIdAuthWithAllocationAppName:(NSString *)appName
                      withAllocationAppAuthorityKey:(NSString *)appAuthorityKey
                           withAllocationBusinessId:(NSString *)businessId
                                          withJDPin:(NSString * _Nullable)pin
                                       withIdCardNo:(NSString * _Nullable)idCardNo
                                           withName:(NSString * _Nullable)name
                                     withDeviceInfo:(NSDictionary * _Nullable)deviceInfo
                                   withAuthFaceData:(NSArray *)arrayAuthFaceData
                              withAuthFaceOtherData:(NSArray <NSData *> * _Nullable)arrayAuthFaceOtherData
                                     withIsJDSystem:(BOOL)isJDSystem
                                        didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete {
    // 默认静默活体
    NSString *sdkCmdValue = kRequestSdkCmdSlicnesValue;
    if (arrayAuthFaceData.count > 1) {
        // 动作活体
        sdkCmdValue = kRequestSdkCmdActionValue;
    }
    
    // faceData
    NSMutableArray *arrayFaceData = [[NSMutableArray alloc] initWithArray:arrayAuthFaceData];
    
    // 其它相关比对数据
    if (arrayAuthFaceOtherData && arrayAuthFaceOtherData.count) {
        for (NSData *otherData in arrayAuthFaceOtherData) {
            // 添加到faceData
            [arrayFaceData addObject:otherData];
        }
    }
    
    NSMutableDictionary *requestParameter = [NSMutableDictionary dictionaryWithCapacity:10];
    // AppName
    [requestParameter setObject:appName forKey:kRequestJDTDAppNameKey];
    // App授权
    [requestParameter setObject:appAuthorityKey forKey:kRequestJDTDAppAuthorityKey];
    // 业务ID
    [requestParameter setObject:businessId forKey:kRequestJDTDBussinessIdKey];
    // extra key SdkCmd
    [requestParameter setValue:@{kRequestSdkCmdKey: sdkCmdValue} forKey:kRequestJDTDExtraKey];
    
    // 验证是否京东体系
    if (isJDSystem) {
        // 京东体系
        // pin
        [requestParameter setObject:pin forKey:kRequestPinKey];
        [requestParameter setObject:kRequestBusinessTypeWithPinValue forKey:kRequestBusinessTypeKey];
    } else {
        // 其它体系
        // name
        [requestParameter setObject:name forKey:kRequestNameKey];
        // idcard
        [requestParameter setObject:idCardNo forKey:kRequestIdCardKey];
        // kRequestBusinessType
        [requestParameter setObject:kRequestBusinessTypeValue forKey:kRequestBusinessTypeKey];
    }
    
    // deviceInfo
    if (deviceInfo) {
        [requestParameter setObject:deviceInfo forKey:kRequestShieldInfoKey];
    }
    // faceData
    [requestParameter setObject:arrayFaceData forKey:kRequestFaceDataKey];
    
    // idauth request
    [JDCNRiskFaceIdAuthRequest postRiskFaceIdAuthWithParameter:requestParameter success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleFaceAuthenticationResponseWithRecevieObject:responseObject
                                                   withComplete:complete];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (complete) {
            complete(NO, nil, nil, nil);
        }
    } sessionDidBecomeInvalid:^(NSURLSession *session, NSError *error) {
        if (complete) {
            complete(NO, nil, nil, nil);
        }
    } taskDidComplete:^(NSURLSession *session, NSURLSessionTask *task, NSError *error) {
        
    }];
    
}

/**
 处理刷脸认证响应
 
 @param object 接受数据对象
 */
- (void)handleFaceAuthenticationResponseWithRecevieObject:(id)object withComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete{
    
    // 验证外层节点 字典类型
    if (![object isKindOfClass:[NSDictionary class]]) {
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    
    // 验证code节点
    if (![object valueForKey:@"code"]) {
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    // code非0 系统开小差
    NSInteger code = [object[@"code"] integerValue];
    
    // 验证data节点
    if (![object valueForKey:@"data"]) {
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    
    // data数据判断
    NSDictionary* data = object[@"data"];
    if (!data){
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    
    // 验证data类型
    if (![data isKindOfClass:[NSDictionary class]]) {
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    
    // 验证id
    if (![data valueForKey:@"verifyId"]) {
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    NSString *verifyId = data[@"verifyId"];
    JDCNStringIsNull(verifyId);
    
    // token
    if (![data valueForKey:@"token"]) {
        if (complete) {
            // fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, nil, nil, object);
        }
        return;
    }
    NSString *verifyToken = data[@"token"];
    JDCNStringIsNull(verifyToken);
    
    // 0: 成功
    if (code == 0) {
        if (complete) {
            // Success
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(YES, verifyToken, verifyId, object);
        }
    } else {
        if (complete) {
            // Fail
            // BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject
            complete(NO, verifyToken, verifyId, object);
        }
    }
}

@end
