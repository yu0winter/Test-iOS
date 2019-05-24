/**
 *  JDCNFaceOCManager.h
 *  JDCNSDK
 *
 *  Provides jdcn face manager process with OC
 *
 *  Created by zhengxuexing on 2017/8/16.
 *  Copyright © 2017年 JDJR. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import "JDCNBaseStruct.h"
#import "JDCNFaceManagerDelegate.h"

/**
 检测标记

 - DetectFlagWithStart: 开启
 - DetectFlagWithStop: 停止
 - DetectFlagWithPause: 暂停
 */
typedef NS_OPTIONS(NSInteger, DetectFlag) {
    DetectFlagWithStart,
    DetectFlagWithStop,
    DetectFlagWithPause
};



//选帧统计信息，从DetectResume开始统计的帧数，选帧成功后不再进行更新, DetectResume清零
typedef struct FrameInfo
{
    int             frame_num;                          ///<当前已处理的帧数
    int             find_face;                          ///<已找到人脸的帧数
    int             frame_out;                          ///<判断为出框的帧数
    int             frame_far;                          ///<判断为太远的帧数
    int             frame_near;                         ///<判断为太近的帧数
    int             frame_blink;                        ///<判断为闭眼的帧数
    int             frame_pose;                         ///<姿态不正确的帧数
    int             frame_blur;                         ///<判断为模糊的帧数
}FrameInfo;

@interface JDCNFaceOCManager : NSObject

@property (nonatomic, weak) id <JDCNFaceManagerDelegate> delegate;
@property (nonatomic, assign, readonly) DetectFlag detectFlag;

+ (JDCNFaceOCManager*)sharedInstance;

#pragma mark - Init
/**
 *  @brief  init face sdk with assertKey and detSize
 *  @param  assertKey   key for bundle_id verify
 *  @param  detSize     control the detect face Size
 *  @return init result
 */
- (BOOL)InitFace:(NSString*)assertKey size:(int)detSize;

- (void)setConfig:(JDCNLiveConfig*)cfg;


#pragma mark - Detect

- (void)detectWithBuffer:(CMSampleBufferRef)frameBuffer;

- (void)detectStart;

- (void)detectResumeWithDetectFlag:(DetectFlag)flag;

- (void)detectPauseWithDetectFlag:(DetectFlag)flag;


- (FrameInfo)getFaielFrameInfo;

@end
