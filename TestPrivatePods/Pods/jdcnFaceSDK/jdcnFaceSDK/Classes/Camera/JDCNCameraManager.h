//
//  JDCNCameraManager.h
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/20.
//  Copyright © 2017年 JDJR. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol JDCNCameraManagerDelegate <NSObject>

- (void)sessionOutputSampleBuffer:(CMSampleBufferRef)output;

@end


@interface JDCNCameraManager : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong, readwrite) AVCaptureConnection *captureConnection;

@property (nonatomic, strong, readonly) UIView *cameraPreview;

@property (nonatomic, assign, readonly) CGFloat cameraPreviewSizeWidth;
@property (nonatomic, assign, readonly) CGFloat cameraPreviewSizeHeight;

/**
 摄像头预览协议
 */
@property (weak, nonatomic) id<JDCNCameraManagerDelegate> cameraManagerDelegate;

/**
 摄像头预览管理单例

 @return instance
 */
+ (JDCNCameraManager *)sharedInstance;

 /**
  授权检查
  
  @return 是否有权限
  */
- (BOOL)authorityCheck;

/**
 获取捕捉会话

 @param cameraPreview 摄像头预览视图
 @return 捕捉会话
 */
- (AVCaptureSession *)captureSessionWithPreview:(UIView *)cameraPreview;

/**
 开启摄像头捕捉
 */
- (void)startCameraCapture;

/**
 停止摄像头捕捉
 */
- (void)stopCameraCapture;

@end
