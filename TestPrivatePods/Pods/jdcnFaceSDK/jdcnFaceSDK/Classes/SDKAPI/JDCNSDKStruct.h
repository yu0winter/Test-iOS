//
//  JDCNSDKStruct.h
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/21.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNBaseStruct.h"

//选帧统计信息，从DetectResume开始统计的帧数，选帧成功后不再进行更新, DetectResume清零
typedef struct JDCNLiveFrameInfo
{
    int             frame_num;                          ///<当前已处理的帧数
    int             find_face;                          ///<已找到人脸的帧数
    int             frame_out;                          ///<判断为出框的帧数
    int             frame_far;                          ///<判断为太远的帧数
    int             frame_near;                         ///<判断为太近的帧数
    int             frame_blink;                        ///<判断为闭眼的帧数
    int             frame_pose;                         ///<姿态不正确的帧数
    int             frame_blur;                         ///<判断为模糊的帧数
}JDCNLiveFrameInfo;

/**
 *  @brief  live information config object
 */
@interface JDCNLiveConfig : NSObject
@property(nonatomic, assign) CGRect faceFrame;
@property(nonatomic, assign) JDCNLiveMode liveMode;
@property(nonatomic, strong) NSMutableArray *actionArray;
@property(assign, nonatomic) float frameOutOverlap; //判断是否出框的重合度阈值（0～1.0之间），越大越严格，默认值为0.8
@property(assign, nonatomic) BOOL  isFullCamera; //如果为yes。是基于摄像头的全识别区域 。 如果为no，基于设置的faceFrame为识别区域

@end
