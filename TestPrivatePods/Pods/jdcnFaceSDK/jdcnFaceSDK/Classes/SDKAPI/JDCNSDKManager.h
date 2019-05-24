//
//  JDCNSDKManager.h
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/20.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JDCNSDKDelegate.h"


@interface JDCNSDKManager : NSObject

#pragma mark - SDK Class Method

/**
 *  @brief  SDK名称
 *  @return str
 */
+ (NSString *)sdkName;

/**
 *  @brief  SDK版本号
 *  @return str
 */
+ (NSString *)sdkVersion;

+ (JDCNSDKManager*)sharedInstance;


#pragma mark - SDK Shared-Process

- (BOOL)setSDKConfig:(JDCNLiveConfig*)SDKConfig;
/**
 *  @brief  start face live detection with preview,
 *          combined using with +setSDKConfig:;
 *          called after "+ (BOOL)setSDKConfig:(JDCNLiveConfig*)SDKConfig;"
 *
 */
- (void)startLiveWithPreview:(UIView*)cameraPreview
                    delegate:(id<JDCNLiveDelegate>)delegate;

/**
 *  @brief  start face live detection with preview
 *
 */
- (void)startLiveWithPreview:(UIView*)cameraPreview
                   SDKConfig:(JDCNLiveConfig*)SDKConfig
                    delegate:(id<JDCNLiveDelegate>)delegate;



/**
 *  @brief  stop detection manually
 *
 */
- (void)JDCNLiveStop;

- (void)JDCNLivePause;

/**
 *  @brief  only Slience usefull now
 */
- (void)JDCNLiveResume;

- (void)JDCNLiveStopCameraCapture;


/**
 获取帧率失败的情况下 每种失败原因的次数统计

 @return 返回结构体。每种失败原因次数
 */
- (JDCNLiveFrameInfo)getFaielFrameInfo;

@end
