/**
 *  JDCNFaceOCManager.mm
 *  JDCNSDK
 *
 *  Provides jdcn face manager process with OC
 *
 *  Created by zhengxuexing on 2017/8/16.
 *  Copyright © 2017年 JDJR. All rights reserved.
 */

#import "JDCNFaceOCManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "UIImage+JDCNImage.h"
#import "JDCNCameraManager.h"
#import "JDCNAppDevice.h"
#import "JDCNFaceSDKSourceManager.h"
#import "JDCNFaceSDK.h"

//Crypt

static const NSInteger kFaceRectInitValue = -9999;

static jdcn::face::FaceManager faceManager;

@interface JDCNFaceOCManager ()

@property (nonatomic, assign, readwrite) DetectFlag detectFlag;
@property (nonatomic, assign, readwrite) BOOL isSucess;
@property (nonatomic, assign, readwrite) jdcn::face::Rect lastFaceRect;
@property (nonatomic, assign, readwrite) BOOL isPortrait;

@end

@implementation JDCNFaceOCManager

+ (JDCNFaceOCManager*)sharedInstance {
    static dispatch_once_t onceToken;
    static JDCNFaceOCManager *OCManager = nil;
    dispatch_once(&onceToken, ^{
        OCManager = [[JDCNFaceOCManager alloc] init];
    });
    return OCManager;
}

#pragma mark - Init
/**
 *  @brief  init face sdk with assertKey and detSize
 *  @param  assertKey   key for bundle_id verify
 *  @param  detSize     control the detect face Size
 *  @return init result
 */
- (BOOL)InitFace:(NSString*)assertKey size:(int)detSize {
//    NSString *app_identifier = [[NSBundle mainBundle] bundleIdentifier];
//    app_identifier = [@"visi@jd." stringByAppendingString:app_identifier];
//    app_identifier = [app_identifier stringByAppendingString:@".visi@jd"];
//    const char *cStr = [app_identifier UTF8String];
//    unsigned char result[32];
//    CC_MD5(cStr, (int)strlen(cStr), result);
//    NSString *keyPrint = [NSString stringWithFormat:
//                          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//                          result[0],  result[1],  result[2],  result[3],  result[4],  result[5],
//                          result[6],  result[7],  result[8],  result[9],  result[10], result[11],
//                          result[12], result[13], result[14], result[15], result[16], result[17],
//                          result[18], result[19], result[20], result[21], result[22], result[23],
//                          result[24], result[25], result[26], result[27], result[28], result[29],
//                          result[30], result[31]];
//    if (![keyPrint isEqualToString:assertKey]) {
//        NSLog(@"\n========================================\nYou input key is error, please send your bundle id of iOS APP to jrchengzhengxin@jd.com.\n========================================");
//        return false;
//    }
    // 下沉版本需要更改模型bin的路径
//    NSString *ws_root = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    ws_root = [ws_root stringByAppendingString:@"/"];
    
    
    // 横竖屏判断
    _isPortrait = IsPortrait ? YES : NO;
    
    NSString *ws_root = [JDCNFaceSDKSourceManager JDCNSDKDependencyFace_GtePathForResource:@"models_16bit" ofType:@"bin"];
    if (!faceManager.Init(detSize, [ws_root UTF8String], &CBIMPFaceCallBack)) {
        _lastFaceRect.x0 = kFaceRectInitValue;
        return true;
    }
    return false;
}

- (void)setConfig:(JDCNLiveConfig*)cfg {
    jdcn::face::FaceConfig config;
    CGSize cameraSize = CGSizeZero;
    if ([UIScreen mainScreen].bounds.size.height < 568) {
        // AVCaptureSessionPreset640x480;
        cameraSize = CGSizeMake(640.f, 480.f);
    } else {
        // AVCaptureSessionPreset1280x720;
        cameraSize = CGSizeMake(1280.f, 720.f);
    }
    
    //判断是否出框的重合度阈值（0～1.0之间），越大越严格，默认值为0.8
    if (!cfg.frameOutOverlap) {
        config.frameOutOverlap = 0.8;  //default 0.8
    }else{
        config.frameOutOverlap = cfg.frameOutOverlap;
    }
    
    //如果为yes。是基于摄像头的全识别区域 。 如果为no，基于设置的faceFrame为识别区域
    if (cfg.isFullCamera) {
        config.faceBoundCenterX = 0.5;
        config.faceBoundCenterY = 0.5;
        config.faceBoundWidth = 1;
        config.faceBoundHeight = 1;
    }else{
        //default
        [self  setFrameBoundWithInPutConfig:cfg outPutconfig:config andCamerSize:cameraSize];
    }
   
    
    // 是否多人脸
    config.flagMutipleFace = 0;
    // 横竖屏模式
    config.flagRotate = 0;
    // 静默/动作活体
    config.liveMode = cfg.liveMode;
    // 人脸选帧的帧数上限
    config.faceSnapshotTimes = 100;
    // 人脸连续静止选帧
    config.continueStaticTimes = 6;
    // 人脸重合度阈值
    config.overlapArea1 = 0.80;
    // 人脸重合度阈值
    config.overlapArea2 = 0.90;
    config.flagLog=0;
    
    for (int i=0; i<[cfg.actionArray count]; i++) {
        JDCNActionType type = (JDCNActionType)[cfg.actionArray[i] integerValue];
        config.actions.push_back(type);
    }
    faceManager.SetLiveConfig(config);
}


#pragma mark - Detect

- (void)detectWithBuffer:(CMSampleBufferRef)frameBuffer {
    if (DetectFlagWithStop == self.detectFlag) {
        faceManager.DetectResume();
        return;
    }
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(frameBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    unsigned char *baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
   // size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    std::vector <jdcn::face::FaceInfo> facesInfo;
    faceManager.DetectFaceFrame(baseAddress, (int)width, (int)height, facesInfo);
    if (facesInfo.size() > 0) {
        // 重合度判断
        if (self.lastFaceRect.x0 != kFaceRectInitValue) {
            int centerX = facesInfo[0].faceRect.x0 + facesInfo[0].faceRect.width / 2 - self.lastFaceRect.x0 - self.lastFaceRect.width / 2;
            int centerY = facesInfo[0].faceRect.y0 + facesInfo[0].faceRect.height / 2 - self.lastFaceRect.y0 - self.lastFaceRect.height / 2;
            if(centerX*centerX + centerY*centerY > (facesInfo[0].faceRect.width + self.lastFaceRect.width)*(facesInfo[0].faceRect.width + self.lastFaceRect.width)/4)
            {
                CBIMPFaceLost();
            }
        }
        self.lastFaceRect = facesInfo[0].faceRect;
    }
    
    if (facesInfo.size() > 0 && ![JDCNFaceOCManager sharedInstance].isSucess) {
        CBIMPLiveDidFindFace(frameBuffer, facesInfo[0]);
    }
    facesInfo.clear();
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    CMSampleBufferInvalidate(frameBuffer);
}

- (void)detectStart {
    self.isSucess = NO;
    self.detectFlag = DetectFlagWithStart;
    faceManager.DetectResume();
}

- (void)detectResumeWithDetectFlag:(DetectFlag)flag {
    self.isSucess = NO;
    self.detectFlag = flag;
//    //if (flag == DetectFlagWithStart) {
//        faceManager.DetectResume();
//    //}
}

- (void)detectPauseWithDetectFlag:(DetectFlag)flag {
    self.detectFlag = flag;
}
- (FrameInfo)getFaielFrameInfo{
    
    jdcn::face::FrameInfo info = faceManager.GetFrameInfo();
    FrameInfo  transferFrameinfo;
    transferFrameinfo.frame_num = info.frame_num;
    transferFrameinfo.find_face = info.find_face;
    transferFrameinfo.frame_out = info.frame_out;
    transferFrameinfo.frame_far = info.frame_far;
    transferFrameinfo.frame_near = info.frame_near;
    transferFrameinfo.frame_blink = info.frame_blink;
    transferFrameinfo.frame_pose = info.frame_pose;
    transferFrameinfo.frame_blur = info.frame_blur;
    
    return  transferFrameinfo;
}
#pragma mark - CallBack

/********************* CallBack Methods IMP **********************/
static void CBIMPFaceCallBack(JDCNCallBackType type, std::vector<jdcn::face::CNMat> data, JDCNActionType actType, std::vector<jdcn::face::FaceDataInfo> facesInfo)
{
    switch (type)
    {
            case TYPE_PREPARE_SUCCESS :
            CBIMPLivePrepareSuccess();
            break;
            case TYPE_SUCCESS:
            CBIMPLiveSuccess(data);
            break;
            case TYPE_FACE_LOST:
            CBIMPFaceLost();
            break;
            case TYPE_ACTION_CHANGE:
            CBIMPLiveActionChange(actType);
            break;
            case TYPE_EYE_CLOSE:
            case TYPE_MOTION_BLUR:
            case TYPE_FRAME_OUT:
            case TYPE_HEAD_POSE_WRONG:
            CBIMPFacePose(type);
            break;
            
        default:
            break;
    }
    
}


static void CBIMPLivePrepareSuccess() {
    JDCN_DEBUG("%s Called!\n", __func__);
    if([[JDCNFaceOCManager sharedInstance].delegate respondsToSelector:@selector(JDCBFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNFaceOCManager sharedInstance].delegate JDCBFaceCallBackWithType:TYPE_PREPARE_SUCCESS
                                                                    faceImage:nil
                                                                     faceData:nil
                                                                   actionType:JDCNActionTypeNone
                                                                    faceFrame:CGRectZero
                                                                 faceKeyPoint:nil];
    }
}



static void CBIMPLiveSuccess(std::vector<jdcn::face::CNMat>data) {
    JDCN_DEBUG("%s Called!\n", __func__);
    [JDCNFaceOCManager sharedInstance].isSucess = YES;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<data.size(); i++) {
        UIImage *tmp = [[JDCNFaceOCManager sharedInstance] privateMethod_JdcnImageFromCNMat:data[i]];
        //if (tmp) {
        tmp = [tmp jdcnFixOrientationRight];
        [dataArray addObject:tmp];
        //}
    }
    
    NSArray <NSData *> *faceData = [[JDCNFaceOCManager sharedInstance] privateMethod_GetArrayFaceDataWithArrayImage:dataArray];
    
    if([[JDCNFaceOCManager sharedInstance].delegate respondsToSelector:@selector(JDCBFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNFaceOCManager sharedInstance].delegate JDCBFaceCallBackWithType:TYPE_SUCCESS
                                                                    faceImage:dataArray
                                                                     faceData:faceData
                                                                   actionType:JDCNActionTypeNone
                                                                    faceFrame:CGRectZero
                                                                 faceKeyPoint:nil];
    }
}

static void CBIMPFaceLost() {
    JDCN_DEBUG("%s Called!\n", __func__);
    
    if([[JDCNFaceOCManager sharedInstance].delegate respondsToSelector:@selector(JDCBFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNFaceOCManager sharedInstance].delegate JDCBFaceCallBackWithType:TYPE_FACE_LOST
                                                                    faceImage:nil
                                                                     faceData:nil
                                                                   actionType:JDCNActionTypeNone
                                                                    faceFrame:CGRectZero
                                                                 faceKeyPoint:nil];
    }
}

static void CBIMPFacePose(JDCNCallBackType callBackType) {
    JDCN_DEBUG("%s Called!\n", __func__);
    if([[JDCNFaceOCManager sharedInstance].delegate respondsToSelector:@selector(JDCBFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNFaceOCManager sharedInstance].delegate JDCBFaceCallBackWithType:callBackType
                                                                    faceImage:nil
                                                                     faceData:nil
                                                                   actionType:JDCNActionTypeNone
                                                                    faceFrame:CGRectZero
                                                                 faceKeyPoint:nil];
    }
}


static void CBIMPLiveDidFindFace(CMSampleBufferRef bufferRef, jdcn::face::FaceInfo faceInfo) {
    JDCN_DEBUG("%s Called!\n", __func__);
    
    UIImage *img = [UIImage imageFromCMSampleBuffer:bufferRef];
    
    // 摄像头视图宽
    CGFloat viewWidth = 0.f;
    // 摄像头视图高
    CGFloat viewHeight = 0.f;
    // 高宽比
    double scaleWH = 0.f;
    // 竖屏专用scale
    double scale = 0.f;
    // 横屏专用scale
    double scaleP = 0.f;
    
    if ([JDCNFaceOCManager sharedInstance].isPortrait) {
        viewWidth = [JDCNCameraManager sharedInstance].cameraPreviewSizeWidth;
        viewHeight = [JDCNCameraManager sharedInstance].cameraPreviewSizeHeight;
        scaleWH = viewWidth / img.size.height;
        scale = viewWidth * img.size.width / (img.size.height * viewHeight);
    } else {
        viewWidth = [JDCNCameraManager sharedInstance].cameraPreviewSizeWidth;
        viewHeight = [JDCNCameraManager sharedInstance].cameraPreviewSizeHeight;
        scaleP = INTERFACE_IS_PAD ? viewHeight / img.size.height : viewWidth / img.size.width;
    }
    /*
     1.竖屏比例依据宽宽比（图像的宽和屏幕的宽-宽指的是最短的边）
     2.横屏比例依据Pad和Phone不一样（Pad是高高比 Phone是宽宽比）
     */
    CGFloat pointX = [JDCNFaceOCManager sharedInstance].isPortrait ? faceInfo.faceRect.x0 * scaleWH : (img.size.width - faceInfo.faceRect.y0) * scaleP - (img.size.width * scaleP - viewWidth) / 2 - faceInfo.faceRect.height * scaleP;
    CGFloat pointY = [JDCNFaceOCManager sharedInstance].isPortrait ? faceInfo.faceRect.y0 * scaleWH - (scale - 1) / 2 * viewHeight : faceInfo.faceRect.x0 * scaleP - (img.size.height * scaleP - viewHeight) / 2;
    CGFloat sizeW = [JDCNFaceOCManager sharedInstance].isPortrait ? faceInfo.faceRect.width * scaleWH : faceInfo.faceRect.height * scaleP;
    CGFloat sizeH = [JDCNFaceOCManager sharedInstance].isPortrait ? faceInfo.faceRect.height * scaleWH : faceInfo.faceRect.width * scaleP;
    // 输出FaceFrame
    CGRect faceFrame = CGRectMake(pointX,
                                  pointY,
                                  sizeW,
                                  sizeH);
    
    
    // 关键点(暂时没有适配)
    NSMutableArray *arrayKeyPoint = [[NSMutableArray alloc] init];
    for (int i = 0; i < kJDCNLandmarkCount; i++) {
        [arrayKeyPoint addObject:NSStringFromCGPoint(CGPointMake(faceInfo.landmarks[i * 2] * scaleWH, faceInfo.landmarks[i * 2 + 1] * scaleWH - (scale - 1) / 2 * viewHeight))];
    }
    
    if([[JDCNFaceOCManager sharedInstance].delegate respondsToSelector:@selector(JDCBFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNFaceOCManager sharedInstance].delegate JDCBFaceCallBackWithType:TYPE_DID_FIND_FACE
                                                                    faceImage:@[img]
                                                                     faceData:nil
                                                                   actionType:JDCNActionTypeNone
                                                                    faceFrame:faceFrame
                                                                 faceKeyPoint:arrayKeyPoint];
    }
}

static void CBIMPLiveActionChange(JDCNActionType nextType) {
    JDCN_DEBUG("%s Called!\n", __func__);
    
    if([[JDCNFaceOCManager sharedInstance].delegate respondsToSelector:@selector(JDCBFaceCallBackWithType:faceImage:faceData:actionType:faceFrame:faceKeyPoint:)]) {
        [[JDCNFaceOCManager sharedInstance].delegate JDCBFaceCallBackWithType:TYPE_ACTION_CHANGE
                                                                    faceImage:nil
                                                                     faceData:nil
                                                                   actionType:nextType
                                                                    faceFrame:CGRectZero
                                                                 faceKeyPoint:nil];
    }
}

#pragma mark - PrivateMethod
- (void)setFrameBoundWithInPutConfig:(JDCNLiveConfig*)cfg  outPutconfig:(jdcn::face::FaceConfig)config andCamerSize:(CGSize)cameraSize{
    //identifyFrame
    /*
     可识别区域,传入起点坐标 以及frame的宽高
     */
    CGFloat ix = cfg.faceFrame.origin.x;
    CGFloat iy = cfg.faceFrame.origin.y;
    CGFloat iw = cfg.faceFrame.size.width;
    CGFloat ih = cfg.faceFrame.size.height;
    
    //相机的宽高
    CGFloat ch = cameraSize.width;
    CGFloat cw = cameraSize.height;
    //屏幕的宽高
    CGFloat fW = [UIScreen mainScreen].bounds.size.width;
    CGFloat fh = [UIScreen mainScreen].bounds.size.height;
    
    
    CGFloat scaleDifference = (fh * cameraSize.height) / (fW * cameraSize.width);
    
    if (scaleDifference < 1) {
        //暂存数据
        CGFloat mx = (fW*ch/cw);
        
        //可识别区域中心点X百分比 p:percentage
        CGFloat px = (ix+ iw/2)/(fW);
        //可识别区域中心点Y百分比
        CGFloat py = (iy+ ih/2 + (mx-fh)/2) /mx;
        //可识别区域宽w百分比
        CGFloat pw = iw/fW;
        //可识别区域高h百分比
        CGFloat ph = ih/mx;
        
#pragma -mark 防止出界 校正px pw
        //start 起点
        CGFloat spx = px - pw/2;
        //end 结束点
        CGFloat epx = px + pw/2;
        if (spx <= 0.01) {
            spx = 0.01;
        }
        if (epx >= 0.99) {
            epx = 0.99;
        }
        px = (spx + epx)/2;
        pw = epx - spx;
        
        //top 起点
        CGFloat tpy = py - ph/2;
        //buttom 结束点
        CGFloat bpy = py + ph/2;
        if (tpy <= 0.01) {
            tpy = 0.01;
        }
        if (bpy >= 0.99) {
            bpy = 0.99;
        }
        py = (tpy + bpy)/2;
        ph = bpy - tpy;
#pragma -mark 防止出界 校正px pw
        
        // X中心点
        config.faceBoundCenterX = px;
        // Y中心点
        config.faceBoundCenterY = py;
        // 宽
        config.faceBoundWidth = 1.0;
        //config.faceBoundWidth = pw;
        // 高
        //        config.faceBoundHeight = MIN(scaleDifference * 1.2, 0.99);
        config.faceBoundHeight = ph;
    } else {
        //暂存数据
        CGFloat mx = (fh*cw/ch);
        
        //可识别区域中心点X百分比 p:percentage
        CGFloat px =  ((mx - fW)/2 + ix + iw/2)/mx;
        //可识别区域中心点Y百分比
        CGFloat py = (iy + ih/2)/fh;
        //可识别区域宽w百分比
        CGFloat pw = iw/mx;
        //可识别区域高h百分比
        CGFloat ph = ih/fh;
        
#pragma -mark 防止出界
        //start 起点
        CGFloat spx = px - pw/2;
        //end 结束点
        CGFloat epx = px + pw/2;
        
        if (spx <= 0.01) {
            spx = 0.01;
        }
        if (epx >= 0.99) {
            epx = 0.99;
        }
        px = (spx + epx)/2;
        pw = epx - spx;
        
        //top 起点
        CGFloat tpy = py - ph/2;
        //buttom 结束点
        CGFloat bpy = py + ph/2;
        if (tpy <= 0.01) {
            tpy = 0.01;
        }
        if (bpy >= 0.99) {
            bpy = 0.99;
        }
        py = (tpy + bpy)/2;
        ph = bpy - tpy;
#pragma -mark 防止出界
        // X中心点
        config.faceBoundCenterX = px;
        // Y中心点
        config.faceBoundCenterY = py;
        // 宽
        config.faceBoundWidth = 1.0;
        //config.faceBoundWidth = pw;
        // 高
        //        config.faceBoundHeight = MIN(scaleDifference * 1.2, 0.99);
        config.faceBoundHeight = ph;
    }
}
- (NSArray <NSData *> *)privateMethod_GetArrayFaceDataWithArrayImage:(NSArray <UIImage *> *)arrayFaceImage {
    NSMutableArray *arrayFaceData = [[NSMutableArray alloc] initWithCapacity:arrayFaceImage.count];
    for (UIImage *image in arrayFaceImage) {
        if (image) {
            // 压缩到90%
            NSData *faceData = UIImageJPEGRepresentation(image, 0.9f);
            [arrayFaceData addObject:faceData];
        }
    }
    return arrayFaceData;
}

- (UIImage *)privateMethod_JdcnImageFromCNMat:(jdcn::face::CNMat)cnMat {
    UIImage * tmpImage = nil;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate((uint8_t*)cnMat.data, (size_t)cnMat.width, (size_t)cnMat.height, 8, (size_t)cnMat.width*cnMat.channel, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast); //kCGImageAlphaPremultipliedFirst
    CGImageRef newImage =  CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    tmpImage = [UIImage imageWithCGImage:newImage];
    CGImageRelease(newImage);
    
    return tmpImage;
}


@end
