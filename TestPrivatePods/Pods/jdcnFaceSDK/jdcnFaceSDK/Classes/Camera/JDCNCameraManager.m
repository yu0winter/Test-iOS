//
//  JDCNCameraManager.m
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/20.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNCameraManager.h"
#import "JDCNAppDevice.h"

@interface JDCNCameraManager ()

@property (nonatomic, strong, readwrite) AVCaptureSession *captureSession;

@property (nonatomic, strong, readwrite) AVCaptureDeviceInput *captureDeviceInputVideo;

@property (nonatomic, strong, readwrite) AVCaptureVideoDataOutput *captureVideoDataOutput;

@property (nonatomic, strong, readwrite) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@property (nonatomic, strong, readwrite) UIView *cameraPreview;

/**True - front camera device called; False - back camera device called*/
@property (nonatomic, assign, readwrite) volatile BOOL IsCameraFront;

//@property (nonatomic, readwrite) dispatch_queue_t sessionQueue;

@property (nonatomic, assign, readwrite) CGFloat cameraPreviewSizeWidth;
@property (nonatomic, assign, readwrite) CGFloat cameraPreviewSizeHeight;

@end


@implementation JDCNCameraManager

#pragma mark - Init
/**
 摄像头预览管理单例
 
 @return instance
 */
+ (JDCNCameraManager *)sharedInstance {
    static JDCNCameraManager *cameraManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cameraManager = [[JDCNCameraManager alloc] init];
    });
    return cameraManager;
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        self.sessionQueue = dispatch_queue_create( "jdcn face session queue", DISPATCH_QUEUE_SERIAL);
//    }
//    return self;
//}

#pragma mark - AVCaptureSession

/**
 授权检查
 
 @return 是否有权限
 */
- (BOOL)authorityCheck {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= kJDCNMinSysVersion) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusAuthorized) {
            // 已授权
            return YES;
        }
        return NO;
    } else {
        // ios 7 before return yes
        return YES;
    }
}

/**
 获取捕捉会话
 
 @param cameraPreview 摄像头预览视图
 @return 捕捉会话
 */
- (AVCaptureSession *)captureSessionWithPreview:(UIView *)cameraPreview {
    _cameraPreview = cameraPreview;
    _cameraPreviewSizeWidth = cameraPreview.frame.size.width;
    _cameraPreviewSizeHeight = cameraPreview.frame.size.height;
    // 设置捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    if ([UIScreen mainScreen].bounds.size.height < 568) {
        _captureSession.sessionPreset = AVCaptureSessionPreset640x480;
    } else {
        _captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    
    NSError *error = nil;
    // 捕捉输入视频设备
    NSArray *captureDeviceInputs = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *captureDevice in captureDeviceInputs) {
        // Front Camera
        if (AVCaptureDevicePositionFront == captureDevice.position) {
            self.IsCameraFront = true;
            // 设置摄像头参数 上锁配置
            if ([captureDevice lockForConfiguration:&error]) {
                // 自动闪光灯
                if ([captureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
                    [captureDevice setFlashMode:AVCaptureFlashModeAuto];
                }
                // 自动白平衡
                if ([captureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
                    [captureDevice setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
                }
                // 自动对焦
                if ([captureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                    [captureDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
                }
                // 自动曝光
                if ([captureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                    [captureDevice setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                    // 设置曝光值
                    [captureDevice setExposureTargetBias:0.5f
                                       completionHandler:nil];
                }
            }
            // 最大帧率 每秒30f
            captureDevice.activeVideoMaxFrameDuration = CMTimeMake(1, 30);
            captureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 30);
            // 解锁配置
            [captureDevice unlockForConfiguration];
            // 捕捉输入设备
            AVCaptureDeviceInput *captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
            if (captureDeviceInput && !error) {
                // 捕捉会话验证是否可以添加输入设备
                if ([_captureSession canAddInput:captureDeviceInput]) {
                    // 捕捉会话添加输入设备
                    [_captureSession addInput:captureDeviceInput];
                    _captureDeviceInputVideo = captureDeviceInput;
                } else {
                    NSLog(@"captureSession canAddInput error");
                    return nil;
                }
            } else {
                NSLog(@"deviceInputWithDevice error = %@",error.localizedDescription);
                return nil;
            }
        }
    }
    
    // 捕捉视频预览层
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    // 设置预览view的frame 0.f 0.f 宽和高
    captureVideoPreviewLayer.frame = CGRectMake(0.f, 0.f, cameraPreview.frame.size.width, cameraPreview.frame.size.height);
    dispatch_async(dispatch_get_main_queue(), ^{
        [cameraPreview.layer insertSublayer:captureVideoPreviewLayer below:cameraPreview.layer];
    });
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _captureVideoPreviewLayer = captureVideoPreviewLayer;
    // 首先设置先方向更新
    [self updateCameraOrientation:captureVideoPreviewLayer];
    
    // 捕捉视频输出
    AVCaptureVideoDataOutput *captureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [captureVideoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    NSDictionary * videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA] forKey:((NSString*)kCVPixelBufferPixelFormatTypeKey)];
    [captureVideoDataOutput setVideoSettings:videoSettings];
//    [captureVideoDataOutput setVideoSettings:@{(NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)}];
    // 设置代理以及队列 要求串行
    dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("com.dispatch.queue.videoDataOutput", DISPATCH_QUEUE_SERIAL);
    [captureVideoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
    // 捕捉会话验证是否可以添加输出设备
    if ([_captureSession canAddOutput:captureVideoDataOutput]) {
        // 捕捉会话添加输出设备
        [_captureSession addOutput:captureVideoDataOutput];
        _captureVideoDataOutput = captureVideoDataOutput;
    } else {
        NSLog(@"captureSession canAddOutput error");
        return nil;
    }
    
     AVCaptureConnection *captureConnection = [captureVideoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    _captureConnection = captureConnection;
    
    return _captureSession;
}

/**
 开启摄像头捕捉
 */
- (void)startCameraCapture {
    if (self.captureSession) {
//        dispatch_async(self.sessionQueue, ^{
            // 主线程操作会造成阻塞 所以需要串行处理
            [self.captureSession startRunning];
//        });
    }
}

/**
 停止摄像头捕捉
 */
- (void)stopCameraCapture {
    if (self.captureSession) {
//        dispatch_async(self.sessionQueue, ^{
            // 主线程操作会造成阻塞 所以需要串行处理
            [self.captureSession stopRunning];
//        });
    }
}

/**
 * flip camera between front and bear
 */
- (void)flipCameraCaptureDevicePosition {
    // Assume the session is already running
    NSError *error = nil;
    NSArray *inputs = self.captureSession.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront) {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
                self.IsCameraFront = false;
            }
            else {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
                self.IsCameraFront = true;
            }
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:&error];
            
            if(newInput && !error) { //v0.1_u13 modify
                // beginConfiguration ensures that pending changes are not applied immediately
                [self.captureSession beginConfiguration];
                
                [self.captureSession removeInput:input];
                [self.captureSession addInput:newInput];
                
                // Changes take effect once the outermost commitConfiguration is invoked.
                [self.captureSession commitConfiguration];
            }
            break;
        }
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}

- (BOOL)isCameraCaptureDevicePositionFront {
    return self.IsCameraFront;
}

- (void)updateCameraOrientation:(CALayer*)newCameraViewLayer {
    self.captureVideoPreviewLayer.bounds = newCameraViewLayer.bounds;
    self.captureVideoPreviewLayer.position = newCameraViewLayer.position;
    if ([self.captureVideoPreviewLayer.connection isVideoOrientationSupported]) {
        switch ([UIDevice currentDevice].orientation) {
            case UIDeviceOrientationLandscapeLeft:
                [self.captureVideoPreviewLayer.connection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
                break;
            case UIDeviceOrientationLandscapeRight:
                [self.captureVideoPreviewLayer.connection setVideoOrientation:AVCaptureVideoOrientationLandscapeLeft];
                break;
            case UIDeviceOrientationPortrait:
                [self.captureVideoPreviewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                [self.captureVideoPreviewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - CMSampleBufferRef
//CMSampleBufferRef转NSImage
-(UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    @autoreleasepool {
        // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        // 锁定pixel buffer的基地址
        CVPixelBufferLockBaseAddress(imageBuffer, 0);
        // 得到pixel buffer的基地址
        void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
        // 得到pixel buffer的行字节数
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        // 得到pixel buffer的宽和高
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        // 创建一个依赖于设备的RGB颜色空间
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
        CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        // 根据这个位图context中的像素数据创建一个Quartz image对象
        CGImageRef quartzImage = CGBitmapContextCreateImage(context);
        // 解锁pixel buffer
        CVPixelBufferUnlockBaseAddress(imageBuffer,0);
        // 释放context和颜色空间
        CGContextRelease(context); CGColorSpaceRelease(colorSpace);
        // 用Quartz image创建一个UIImage对象image
        UIImage *image = [UIImage imageWithCGImage:quartzImage];
        // 释放Quartz image对象
        CGImageRelease(quartzImage);
        return (image);
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
/**
 捕捉输出回调

 @param captureOutput 捕捉输出
 @param sampleBuffer 输出媒体类型
 @param connection 捕捉连接
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
       fromConnection:(AVCaptureConnection *)connection {
    
    if ([_cameraManagerDelegate respondsToSelector:@selector(sessionOutputSampleBuffer:)]) {
        [_cameraManagerDelegate sessionOutputSampleBuffer:sampleBuffer];
    }
}

@end
