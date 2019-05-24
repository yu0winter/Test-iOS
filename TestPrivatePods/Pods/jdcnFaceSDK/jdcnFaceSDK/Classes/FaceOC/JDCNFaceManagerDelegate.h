/**
 *  JDCNFaceManagerDelegate.h
 *  JDCNSDK
 *
 *  delegate methods for JDCNFaceOCManager
 *
 *  Created by zhengxuexing on 2017/8/16.
 *  Copyright © 2017年 JDJR. All rights reserved.
 */

#import <Foundation/Foundation.h>

#import "JDCNSDKStruct.h"

@protocol JDCNFaceManagerDelegate <NSObject>

/**
 刷脸回调
 
 @param type 返回类型枚举
 @param arrayFaceImage 人脸图像集合(原图集合 用于展示 index 0:原图 1:脸图 2:动作图)
 @param faceData 人脸图像Data集合(压缩后的Data集合 用于识别 index 0:原图 1:脸图 2:动作图)
 @param actionType 动作类型
 @param faceFrame 人脸框矩形
 @param arrayFaceKeyPoint 人脸关键点集合
 */
- (void)JDCBFaceCallBackWithType:(JDCNCallBackType)type
                       faceImage:(NSArray <UIImage *> * _Nullable)arrayFaceImage
                        faceData:(NSArray <NSData *> * _Nullable)faceData
                      actionType:(JDCNActionType)actionType
                       faceFrame:(CGRect)faceFrame
                    faceKeyPoint:(NSArray * _Nullable)arrayFaceKeyPoint;


@end

