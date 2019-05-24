//
//  JDCNLiveDelegate.h
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/21.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JDCNSDKStruct.h"

/**
 SDK初始化错误状态
 
 - JDCNLiveFaceInitFailStatusWithAVAuthorizationDenied: 相机未授权
 - JDCNLiveFaceInitFailStatusWithModelInitError: 模型加载错误
 - JDCNLiveFaceInitFailStatusWithDoesNotSupportOSVersion: 不支持系统版本(最低要求8.0 8.0以下不支持)
 */
typedef NS_OPTIONS(NSInteger, JDCNLiveFaceInitFailStatus) {
    JDCNLiveFaceInitFailStatusWithAVAuthorizationDenied,
    JDCNLiveFaceInitFailStatusWithModelInitError,
    JDCNLiveFaceInitFailStatusWithDoesNotSupportOSVersion
};

@protocol JDCNLiveDelegate <NSObject>

/**
 刷脸回调
 
 @param type 返回类型枚举
 @param faceImage 人脸图像集合(原图集合 用于展示 index 0:原图 1:脸图 2:动作图)
 @param faceData 人脸图像Data集合(压缩后的Data集合 用于识别 index 0:原图 1:脸图 2:动作图)
 @param actionType 动作类型
 @param faceFrame 人脸框矩形
 @param arrayFaceKeyPoint 人脸关键点集合
 */
- (void)JDCNFaceCallBackWithType:(JDCNCallBackType)type
                       faceImage:(NSArray <UIImage *> * _Nullable)faceImage
                        faceData:(NSArray <NSData *> * _Nullable)faceData
                      actionType:(JDCNActionType)actionType
                       faceFrame:(CGRect)faceFrame
                    faceKeyPoint:(NSArray * _Nullable)arrayFaceKeyPoint;


#pragma mark - InitComplete
/**
 @brief init sdk completion
 */
- (void) JDCNInitCompletion;

/**
 @brief init sdk failstatus
 @param initFailStatus failstatus
 */
- (void) JDCNInitFailWithStatus:(JDCNLiveFaceInitFailStatus)initFailStatus;

@end

