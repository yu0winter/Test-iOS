//
//  JDCNSDKManager+JDCNJRFaceValidation.h
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/11/16.
//  Copyright © 2017年 JDJR. All rights reserved.
//  人脸验证（京东金融专用）

#import <jdcnFaceSDK/JDCNSDKManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCNSDKManager (JDCNJRFaceValidation)

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
                                        didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete;

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
                                           didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete;

@end

NS_ASSUME_NONNULL_END
