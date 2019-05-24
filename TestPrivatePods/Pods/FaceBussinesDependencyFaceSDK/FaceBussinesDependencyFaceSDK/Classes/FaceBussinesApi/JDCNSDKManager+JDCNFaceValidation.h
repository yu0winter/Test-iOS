//
//  JDCNSDKManager+FaceValidation.h
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/10/25.
//  Copyright © 2017年 JDJR. All rights reserved.
//  人脸验证

#import <jdcnFaceSDK/JDCNSDKManager.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDCNSDKManager (JDCNFaceValidation)

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
                                    didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete;

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
                                       didComplete:(void (^)(BOOL isSuccess, NSString * _Nullable verifyToken, NSString * _Nullable verifyId, id _Nullable responseObject))complete;

@end

NS_ASSUME_NONNULL_END
