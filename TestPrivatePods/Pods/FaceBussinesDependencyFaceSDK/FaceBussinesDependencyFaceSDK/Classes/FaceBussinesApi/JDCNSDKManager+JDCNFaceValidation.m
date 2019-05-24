//
//  JDCNSDKManager+FaceValidation.m
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/10/25.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNSDKManager+JDCNFaceValidation.h"
#import "JDCNsdkDnsAksManager.h"
#import "JDCNRiskFaceIdAuthRequest.h"
#import "JDJR_Base64.h"
#import "JDJR_MD5.h"
#import "JDJR_Sha_XX.h"
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

@implementation JDCNSDKManager (JDCNFaceValidation)


/**
 刷脸验证(基于京东体系)
 
 @param appName 服务端分配的appName(必传 NONNULL)
 @param appAuthorityKey 服务端分配的app授权Key (必传 NONNULL)
 @param businessId 服务端分配的业务id(必传 NONNULL)
 @param pin 用户pin（必传 NONNULL）
 @param deviceInfo 设备信息 （非必传 可空）
 @param arrayAuthFaceData 刷脸数据集合(必传 NONNULL SDK返回的faceData)
 @param dictAuthFaceOtherData 其它数据集合（非必传 身份证、驾照等数据）
 */
- (void)faceIdAuthJDSystemWithAllocationAppName:(NSString *)appName
                  withAllocationAppAuthorityKey:(NSString *)appAuthorityKey
                       withAllocationBusinessId:(NSString *)businessId
                                      withJDPin:(NSString *)pin
                                 withDeviceInfo:(NSDictionary * _Nullable)deviceInfo
                               withAuthFaceData:(NSArray *)arrayAuthFaceData
                          withAuthFaceOtherData:(NSDictionary * _Nullable)dictAuthFaceOtherData
                                    didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete {
    NSParameterAssert(appName);
    NSParameterAssert(appAuthorityKey);
    NSParameterAssert(businessId);
    NSParameterAssert(pin);
    NSParameterAssert(arrayAuthFaceData);
    
    [self private_faceIdAuthWithAllocationAppName:appName
                    withAllocationAppAuthorityKey:appAuthorityKey
                         withAllocationBusinessId:businessId
                                        withJDPin:pin
                                     withIdCardNo:nil
                                         withName:nil
                                   withDeviceInfo:deviceInfo
                                 withAuthFaceData:arrayAuthFaceData
                            withAuthFaceOtherData:dictAuthFaceOtherData
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
 @param arrayAuthFaceData 刷脸数据集合(必传 NONNULL SDK返回的faceData)
 @param dictAuthFaceOtherData 其它数据集合（非必传 身份证、驾照等数据）
 */
- (void)faceIdAuthOtherSystemWithAllocationAppName:(NSString *)appName
                     withAllocationAppAuthorityKey:(NSString *)appAuthorityKey
                          withAllocationBusinessId:(NSString *)businessId
                                      withIdCardNo:(NSString *)idCardNo
                                          withName:(NSString *)name
                                    withDeviceInfo:(NSDictionary * _Nullable)deviceInfo
                                  withAuthFaceData:(NSArray *)arrayAuthFaceData
                             withAuthFaceOtherData:(NSDictionary * _Nullable)dictAuthFaceOtherData
                                       didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete {
    
    NSParameterAssert(appName);
    NSParameterAssert(appAuthorityKey);
    NSParameterAssert(businessId);
    NSParameterAssert(idCardNo);
    NSParameterAssert(name);
    NSParameterAssert(arrayAuthFaceData);
    
    [self private_faceIdAuthWithAllocationAppName:appName
                    withAllocationAppAuthorityKey:appAuthorityKey
                         withAllocationBusinessId:businessId
                                        withJDPin:nil
                                     withIdCardNo:idCardNo
                                         withName:name
                                   withDeviceInfo:deviceInfo
                                 withAuthFaceData:arrayAuthFaceData
                            withAuthFaceOtherData:dictAuthFaceOtherData
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
 @param arrayAuthFaceData 刷脸数据集合(必传 NONNULL SDK返回的faceData)
 @param dictAuthFaceOtherData 其它数据集合（非必传 身份证、驾照等数据）
 @param isJDSystem 是否京东体系
 */
- (void)private_faceIdAuthWithAllocationAppName:(NSString *)appName
                  withAllocationAppAuthorityKey:(NSString *)appAuthorityKey
                       withAllocationBusinessId:(NSString *)businessId
                                      withJDPin:(NSString * _Nullable)pin
                                   withIdCardNo:(NSString * _Nullable)idCardNo
                                       withName:(NSString * _Nullable)name
                                 withDeviceInfo:(NSDictionary * _Nullable)deviceInfo
                               withAuthFaceData:(NSArray *)arrayAuthFaceData
                          withAuthFaceOtherData:(NSDictionary * _Nullable)dictAuthFaceOtherData
                                 withIsJDSystem:(BOOL)isJDSystem
                                    didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete {
    
    // 默认静默活体
    NSString *sdkCmdValue = kRequestSdkCmdSlicnesValue;
    
    // 刷脸数据加密
    NSMutableData *mutableEncryptFaceData = [JDCNsdkDnsAksManager jdcnFaceDataAksEncryptWithSourceData:arrayAuthFaceData[0]];
    //NSMutableData *mutableEncryptFullFaceData = [JDCNDnsAksManager faceDataAksEncryptWithSourceData:arrayAuthFaceData[1]];
    NSString *base64FaceStrAction = nil;
    // 动作活体图
    if (arrayAuthFaceData.count > 2) {
        // 动作活体
        sdkCmdValue = kRequestSdkCmdActionValue;
        NSMutableData *mutableEncryptActionData = [JDCNsdkDnsAksManager jdcnFaceDataAksEncryptWithSourceData:arrayAuthFaceData[2]];
        
        base64FaceStrAction = [self faceEncryptFormatWithFaceType:JDCNSDKManagerFaceDataTypeAP
                                                                                  Identifier:[JDJR_Sha_XX sha384:[JDJR_Base64 stringByEncodingData:mutableEncryptActionData]]
                                                                              withFaceString:[JDJR_Base64 stringByEncodingData:mutableEncryptActionData]];
    }
    // 小图
    NSString *base64FaceStr = [[JDCNSDKManager sharedInstance] faceEncryptFormatWithFaceType:JDCNSDKManagerFaceDataTypeSFF
                                                                                  Identifier:[JDJR_Sha_XX sha384:[JDJR_Base64 stringByEncodingData:mutableEncryptFaceData]]
                                                                              withFaceString:[JDJR_Base64 stringByEncodingData:mutableEncryptFaceData]];
    // 全景图
//    NSString *base64FaceStrFull = [[JDCNSDKManager sharedInstance] faceEncryptFormatWithFaceType:JDCNSDKManagerFaceDataTypeFF
//                                                                                      Identifier:[JRMD5 md5:[JRBase64 stringByEncodingData:mutableEncryptFullFaceData]]
//                                                                                  withFaceString:[JRBase64 stringByEncodingData:mutableEncryptFullFaceData]];
    // faceData
    NSMutableArray *arrayFaceData = base64FaceStrAction ? [[NSMutableArray alloc] initWithObjects:base64FaceStr, base64FaceStrAction, nil] : [[NSMutableArray alloc] initWithObjects:base64FaceStr, nil];
    
    // 其它相关比对数据
    if (dictAuthFaceOtherData && dictAuthFaceOtherData.count) {
        // 遍历key
        for (NSString *key in dictAuthFaceOtherData) {
            // 根据key获取value
            NSMutableData *mutableEncryptOtherData = [JDCNsdkDnsAksManager jdcnFaceDataAksEncryptWithSourceData:dictAuthFaceOtherData[key]];
            NSString *base64OtherData = [NSString stringWithFormat:@"%@#%@:%@:%@:%@:ios", key, [JDJR_Sha_XX sha384:[JDJR_Base64 stringByEncodingData:mutableEncryptOtherData]], [JDCNSDKManager sdkName], [JDCNSDKManager sdkVersion], [JDJR_Base64 stringByEncodingData:mutableEncryptOtherData]];
            // 添加到FaceData base64OtherData
            [arrayFaceData addObject:base64OtherData];
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
