/**
 *  JDCNBaseStruct.h
 *  JDCNSDK
 *
 *  Provides jdcn basic structs sdk-inner-use
 *
 *  Created by zhengxuexing on 2017/7/21.
 *  Copyright © 2017年 JDCN. All rights reserved.
 */

#ifndef JDCNBaseStruct_h
#define JDCNBaseStruct_h

#define kJDCNLandmarkCount      5       // face landmarks count
#define FEATURE_SIZE            512

typedef enum JDCNLiveMode 
{
    JDCNLiveModeSilence             = 1000,         //< 静默模式，单人脸模式下，livesuccess时输出图像顺序为：选帧成功预览图+选帧成功脸图， 多人脸模式下，livesuccess时输出图像顺序为：当前预览图+选帧成功脸图1+选帧成功脸图2+...
    JDCNLiveModeAction              = 1001,         //< 活体模式，单人脸模式下，livesuccess时输出图像顺序为：活体图1+活体图2+...，
    JDCNLiveModeSilenceAndAction    = 1002,         //< 静默加活体模式，单人脸模式下，livesuccess时输出图像顺序为：选帧成功预览图+选帧成功脸图+活体图1+活体图2+...，
}JDCNLiveMode;

typedef enum JDCNActionType 
{
    JDCNActionTypeNone      = 1000, //flag for finish
    JDCNActionTypePrepare   = 1001,
    JDCNActionTypeMouth     = 1002, //open mouth
    JDCNActionTypeBlink     = 1003, //eyes blink
    JDCNActionTypeShakeH    = 1004, //shake head
    JDCNActionTypeShakeL    = 1005, //shake head left
    JDCNActionTypeShakeR    = 1006, //shake heac right
    JDCNActionTypePitchU    = 1007, //pitch head up
    JDCNActionTypePitchD    = 1008, //pitch head down
}JDCNActionType;

typedef enum JDCNCallBackType 
{
    TYPE_PREPARE_SUCCESS        = 1000, //
    TYPE_SUCCESS                = 1001, // 选帧成功
    TYPE_FACE_LOST              = 1002, // 人脸丢失
    TYPE_DID_FIND_FACE          = 1003, // 
    TYPE_ACTION_CHANGE          = 1004, // 动作切换
    TYPE_FRAME_OUT              = 1005, // 出框
    TYPE_MOTION_BLUR            = 1006, // 运动模糊
    TYPE_EYE_CLOSE              = 1007, // 闭眼睛
    TYPE_HEAD_POSE_WRONG        = 1008, // 脸姿态不正
    TYPE_FACE_TOO_FAR           = 1009, // 人脸过远
    TYPE_FACE_TOO_NEAR          = 1010, // 人脸过近
    TYPE_FACE_POSE_RIGHT        = 1011, // 姿态正确
}JDCNCallBackType;

#endif /* JDCNBaseStruct_h */
