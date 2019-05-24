//
//  JDCNSDKManager.m
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/20.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNSDKManager.h"
#import "JDCNCameraManager.h"
#import "UIImage+JDCNImage.h"
#import "JDCNAppDevice.h"
#import "JDCNFaceOCManager.h"

static NSString * const kSdkName = @"jdcn";
static NSString * const kSdkVersion = @"3.0";

@interface JDCNSDKManager () <JDCNCameraManagerDelegate, JDCNFaceManagerDelegate>
@property(nonatomic, assign) BOOL IsSDKPreProcessSucceed;
@property(nonatomic, strong) JDCNLiveConfig *config;
@property(nonatomic, weak) id<JDCNLiveDelegate> delegate;
/**
 SDK初始化失败枚举
 */
@property(nonatomic, assign) JDCNLiveFaceInitFailStatus initFailStatus;

@end


@implementation JDCNSDKManager

#pragma mark - SDK Class Method

+ (NSString *)sdkName {
    return kSdkName;
}

+ (NSString *)sdkVersion {
    return kSdkVersion;
}


+ (JDCNSDKManager *)sharedInstance {
    static JDCNSDKManager *sdkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sdkManager = [[JDCNSDKManager alloc] init];
        sdkManager.IsSDKPreProcessSucceed = FALSE;
    });
    return sdkManager;
}


#pragma mark - SDK Pre-Process

+ (BOOL)SDKPreProcess {
    // PreProcess Already OK
    if([JDCNSDKManager sharedInstance].IsSDKPreProcessSucceed) {
        return TRUE;
    }
    // SDK预处理状态置为YES
    [JDCNSDKManager sharedInstance].IsSDKPreProcessSucceed = TRUE;
    
    // Check System Version
    if ([[UIDevice currentDevice].systemVersion floatValue] < kJDCNMinSysVersion) {
        [JDCNSDKManager sharedInstance].initFailStatus = JDCNLiveFaceInitFailStatusWithDoesNotSupportOSVersion;
        [JDCNSDKManager sharedInstance].IsSDKPreProcessSucceed = FALSE;
        return FALSE;
    }
    
    // key = md5(visi@jd.${appid}.visi@jd)
    // JDMobile:    a3eeb8d1d43faa8c434679f14d497f8e
    // Live Sample: 366bac6a32c1227e444b38eb063f4703
    bool initResult = [[JDCNFaceOCManager sharedInstance] InitFace:@"366bac6a32c1227e444b38eb063f4703" size:200];
    if (!initResult) {
        [JDCNSDKManager sharedInstance].IsSDKPreProcessSucceed = FALSE;
        [JDCNSDKManager sharedInstance].initFailStatus = JDCNLiveFaceInitFailStatusWithModelInitError;
        return FALSE;
    }
    
    return TRUE;
}


#pragma mark - SDK Shared-Process

- (BOOL)setSDKConfig:(JDCNLiveConfig*)SDKConfig {
    // SDK Pre-Process
    if (![JDCNSDKManager SDKPreProcess]) {
        return FALSE;
    }
    [JDCNSDKManager sharedInstance].config = SDKConfig;
    [[JDCNFaceOCManager sharedInstance] setConfig:SDKConfig];
    return TRUE;
}

/**
 *  @brief  start face live detection with preview,
 *          combined using with +setSDKConfig:;
 *          called after "+ (BOOL)setSDKConfig:(JDCNLiveConfig*)SDKConfig;"
 *
 */
- (void)startLiveWithPreview:(UIView*)cameraPreview
                    delegate:(id<JDCNLiveDelegate>)delegate {
    
    _delegate = delegate;
    if ([JDCNSDKManager sharedInstance].IsSDKPreProcessSucceed) {
        // 相机权限
        if ([[JDCNCameraManager sharedInstance] authorityCheck]) {
            // 已授权
            //faceFrame not set, use cameraPreview.frame as default
            if (_config.faceFrame.size.width*_config.faceFrame.size.height<100) {
                _config.faceFrame = cameraPreview.frame;
                [[JDCNFaceOCManager sharedInstance] setConfig:_config];
            }
            [JDCNFaceOCManager sharedInstance].delegate = self;
            [[JDCNFaceOCManager sharedInstance] detectStart];
            //Camera
            [[JDCNCameraManager sharedInstance] captureSessionWithPreview:cameraPreview];
            [[JDCNCameraManager sharedInstance] setCameraManagerDelegate:self];
            [[JDCNCameraManager sharedInstance] startCameraCapture];
            
            // 初始化sdk完成协议回调
            if ([_delegate respondsToSelector:@selector(JDCNInitCompletion)]) {
                [_delegate JDCNInitCompletion];
            }
        } else {
            // Denied 未授权
            [JDCNSDKManager sharedInstance].initFailStatus = JDCNLiveFaceInitFailStatusWithAVAuthorizationDenied;
            [JDCNSDKManager sharedInstance].IsSDKPreProcessSucceed = FALSE;
            if ([_delegate respondsToSelector:@selector(JDCNInitFailWithStatus:)]) {
                [_delegate JDCNInitFailWithStatus:[JDCNSDKManager sharedInstance].initFailStatus];
            }
        }
    } else {
        if ([_delegate respondsToSelector:@selector(JDCNInitFailWithStatus:)]) {
            [_delegate JDCNInitFailWithStatus:[JDCNSDKManager sharedInstance].initFailStatus];
        }
    }
}

/**
 *  @brief  start face live detection with preview
 *  @return TRUE: start detect succeed; FALSE: start detect failed
 */
- (void)startLiveWithPreview:(UIView*)cameraPreview
                   SDKConfig:(JDCNLiveConfig*)SDKConfig
                    delegate:(id<JDCNLiveDelegate>)delegate {
    //faceFrame not set, use cameraPreview.frame as default
    if (SDKConfig.faceFrame.size.width*SDKConfig.faceFrame.size.height<100) {
        SDKConfig.faceFrame = cameraPreview.frame;
    }
    [self setSDKConfig:SDKConfig];
    
    [self startLiveWithPreview:cameraPreview delegate:delegate];
}

/**
 *  @brief  stop detection manually
 *  @param  mode    liveness stop mode, detail refer to JDCNStopMode
 */
- (void)JDCNLiveStop {
    [[JDCNFaceOCManager sharedInstance] detectResumeWithDetectFlag:DetectFlagWithStop];
}

- (void)JDCNLivePause {
    [[JDCNFaceOCManager sharedInstance] detectPauseWithDetectFlag:DetectFlagWithPause];
}

/**
 *  @brief  only Slience usefull now
 */
- (void)JDCNLiveResume {
    [[JDCNFaceOCManager sharedInstance] detectStart];
}

- (void)JDCNLiveStopCameraCapture {
    [[JDCNCameraManager sharedInstance] stopCameraCapture];
}

#pragma mark - JDCNCameraManagerDelegate

- (void)sessionOutputSampleBuffer:(CMSampleBufferRef)output {
    if (output) {
        [[JDCNFaceOCManager sharedInstance] detectWithBuffer:output];
        return;
    }
    printf("buffer is nil!\n");
}


#pragma mark - JDCNFaceManagerDelegate
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
                    faceKeyPoint:(NSArray * _Nullable)arrayFaceKeyPoint {
    if ([_delegate respondsToSelector:@selector(JDCNFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNSDKManager sharedInstance].delegate JDCNFaceCallBackWithType:type
                                                                 faceImage:arrayFaceImage
                                                                  faceData:faceData
                                                                actionType:actionType
                                                                 faceFrame:faceFrame
                                                              faceKeyPoint:arrayFaceKeyPoint];
    }
}

- (FrameInfo)getFaielFrameInfo{
    
    return  [[JDCNFaceOCManager sharedInstance] getFaielFrameInfo];
}

@end
