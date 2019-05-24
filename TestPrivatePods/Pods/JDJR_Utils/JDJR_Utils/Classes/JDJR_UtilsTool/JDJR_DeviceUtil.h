//
//  JDJR_DeviceUtil.h
//  JDJR_Utils
//
//  Created by ixf on 2018/6/19.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JDJR_DeviceType){
    Unknow                   = 0x0000,                   // Unknow type
    Simulator                = 0x0001,                   // Simulator
    
    iPod                     = 0x0010,                   // iPod touch
    iPod_2                  = 0x0011,                   // iPod touch (2nd generation)
    iPod_3                  = 0x0012,                   // iPod touch (3rd generation)
    iPod_4                  = 0x0013,                   // iPod touch (4th generation)
    iPod_5                  = 0x0014,                   // iPod touch (5th generation)
    iPod_6                  = 0x0015,                   // iPod touch (6th generation)
    
    iPhone                   = 0x0100,                   // iPhone
    iPhone_3G                = 0x0101,                   // iPhone 3G
    iPhone_3GS               = 0x0102,                   // iPhone 3GS
    iPhone_4                 = 0x0103,                   // iPhone 4
    iPhone_4S                = 0x0104,                   // iPhone 4S
    iPhone_5                 = 0x0105,                   // iPhone 5
    iPhone_5C                = 0x0106,                   // iPhone 5c
    iPhone_5S                = 0x0107,                   // iPhone 5S
    iPhone_6                 = 0x0108,                   // iPhone 6
    iPhone_6_Plus            = 0x0109,                   // iPhone 6 Plus
    iPhone_6S                = 0x010A,                   // iPhone 6S
    iPhone_6S_Plus           = 0x010B,                   // iPhone 6S Plus
    iPhone_SE                = 0x010C,                   // iPhone SE
    iPhone_7                 = 0x010D,                   // iPhone 7
    iPhone_7_Plus            = 0x010E,                   // iPhone 7 Plus
    iPhone_8                 = 0x010F,                   // iPhone 8
    iPhone_8_Plus            = 0x0110,                   // iPhone 8 Plus
    iPhone_X                 = 0x0111,                   // iPhone X
    
    iPad                     = 0x0200,                   // iPad
    iPad_2                  = 0x0201,                   // iPad 2
    iPad_3                  = 0x0202,                   // iPad (3rd generation)
    iPad_4                  = 0x0203,                   // iPad (4th generation)
    iPad_5                  = 0x0204,                   // iPad (5th generation)
    
    iPad_Air                 = 0x0300,                   // iPad Air
    iPad_Air_2              = 0x0301,                   // iPad Air 2
    
    iPad_Mini                = 0x0400,                   // iPad mini
    iPad_Mini_2             = 0x0401,                   // iPad mini 2
    iPad_Mini_3             = 0x0402,                   // iPad mini 3
    iPad_Mini_4             = 0x0403,                   // iPad mini 4
    
    iPad_Pro_9_7             = 0x0500,                   // iPad Pro (9.7-inch)
    
    iPad_Pro_10_5            = 0x0600,                   // iPad Pro (10.5-inch)
    
    iPad_Pro_12_9            = 0x0700,                   // iPad Pro (12.9-inch)
    iPad_Pro_12_9_2         = 0x0701,                   // iPad Pro (12.9-inch, 2nd generation)
};
/** 屏幕尺寸类型枚举 */
typedef NS_ENUM(NSUInteger, JDJR_DeviceSizeType) {
    UnknownSize                 = 0x00,                     // Unknow screen size
    iPod_3_5_inch               = 0x01,                     // iPod (3.5-inch)
    iPod_4_0_inch               = 0x02,                     // iPod (4.0-inch)
    
    iPhone_3_5_inch             = 0x10,                     // iPhone (3.5-inch)
    iPhone_4_0_inch             = 0x11,                     // iPhone (4.0-inch)
    iPhone_4_7_inch             = 0x12,                     // iPhone (4.7-inch)
    iPhone_5_5_inch             = 0x13,                     // iPhone (5.5-inch)
    iPhone_5_8_inch             = 0x14,                     // iPhone (5.8-inch)
    
    iPad_7_9_inch               = 0x20,                     // iPad mini (7.9-inch)
    iPad_9_7_inch               = 0x21,                     // iPad 、iPad Air (9.7-inch)
    iPad_10_5_inch              = 0x22,                     // iPad Pro (10.5-inch)
    iPad_12_9_inch              = 0x23,                     // iPad Pro (12.9-inch)
};

/*
 owner: cy
 update: 2018年06月01日14:41:26
 info: 设备信息工具类
 */
@interface JDJR_DeviceUtil : NSObject

/**
 获取设备类型
 
 @return 返回设备类型
 */
+ (JDJR_DeviceType)getDeviceType;

/**
 获取设备尺寸类型
 
 @return 设备尺寸类型
 */
+ (JDJR_DeviceSizeType)getDeviceSizeType;

/**
 获取设备的类型的封装
 
 @return 返回设备类型
 */
+ (NSString*)getDeviceInfoType;

/**
 获取Hardware
 
 @return Hardware
 */
+(NSString *)getHardware;

/**
 获取设备的ppi
 */
+(NSInteger)getDevicePpi;

/**
 返回屏幕尺寸

 @return 当前设备的尺寸
 */
+ (CGFloat )getDeviceNumInch;

/**
 判断系统是否是iOS7 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS7Later;

/**
 判断系统是否是iOS8 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS8Later;

/**
 判断系统是否是iOS9 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS9Later;

/**
 判断系统是否是iOS10 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS10Later;

/**
 判断系统是否是iOS11 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS11Later;
@end
