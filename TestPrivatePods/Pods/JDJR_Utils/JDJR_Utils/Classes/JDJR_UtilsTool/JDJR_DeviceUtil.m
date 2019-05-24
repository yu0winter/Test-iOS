//
//  JDJR_DeviceUtil.m
//  JDJR_Utils
//
//  Created by ixf on 2018/6/19.
//

#import "JDJR_DeviceUtil.h"
// 获取设备类型
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

@implementation JDJR_DeviceUtil

+ (NSDictionary*)deviceNamesByCode {
    static NSDictionary *deviceNamesByCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceNamesByCode = @{
                              @"i386"       : @(Simulator),
                              @"x86_64"     : @(Simulator),
                              
                              // iPod
                              @"iPod1,1"    : @(iPod),
                              @"iPod2,1"    : @(iPod_2),
                              @"iPod3,1"    : @(iPod_3),
                              @"iPod4,1"    : @(iPod_4),
                              @"iPod5,1"    : @(iPod_5),
                              @"iPod7,1"    : @(iPod_6),
                              
                              // iPhone
                              @"iPhone1,1"  : @(iPhone),
                              @"iPhone1,2"  : @(iPhone_3G),
                              @"iPhone2,1"  : @(iPhone_3GS),
                              
                              @"iPhone3,1"  : @(iPhone_4),
                              @"iPhone3,2"  : @(iPhone_4),
                              @"iPhone3,3"  : @(iPhone_4),
                              @"iPhone4,1"  : @(iPhone_4S),
                              
                              @"iPhone5,1"  : @(iPhone_5),
                              @"iPhone5,2"  : @(iPhone_5),
                              @"iPhone5,3"  : @(iPhone_5C),
                              @"iPhone5,4"  : @(iPhone_5C),
                              @"iPhone6,1"  : @(iPhone_5S),
                              @"iPhone6,2"  : @(iPhone_5S),
                              
                              @"iPhone7,2"  : @(iPhone_6),
                              @"iPhone7,1"  : @(iPhone_6_Plus),
                              @"iPhone8,1"  : @(iPhone_6S),
                              @"iPhone8,2"  : @(iPhone_6S_Plus),
                              
                              @"iPhone8,4"  : @(iPhone_SE),
                              
                              @"iPhone9,1"  : @(iPhone_7),
                              @"iPhone9,3"  : @(iPhone_7),
                              @"iphone9,2"  : @(iPhone_7_Plus),
                              @"iphone9,4"  : @(iPhone_7_Plus),
                              
                              @"iPhone10,1" : @(iPhone_8),
                              @"iPhone10,4" : @(iPhone_8),
                              @"iPhone10,2" : @(iPhone_8_Plus),
                              @"iPhone10,5" : @(iPhone_8_Plus),
                              
                              @"iPhone10,3" : @(iPhone_X),
                              @"iPhone10,6" : @(iPhone_X),
                              
                              // iPad
                              @"iPad1,1"    : @(iPad),
                              @"iPad2,1"    : @(iPad_2),
                              @"iPad2,2"    : @(iPad_2),
                              @"iPad2,3"    : @(iPad_2),
                              @"iPad2,4"    : @(iPad_2),
                              
                              @"iPad3,1"    : @(iPad_3),
                              @"iPad3,2"    : @(iPad_3),
                              @"iPad3,3"    : @(iPad_3),
                              
                              @"iPad3,4"    : @(iPad_4),
                              @"iPad3,5"    : @(iPad_4),
                              @"iPad3,6"    : @(iPad_4),
                              
                              @"iPad6,11"   : @(iPad_5),
                              @"iPad6,12"   : @(iPad_5),
                              
                              // iPad Air
                              @"iPad4,1"    : @(iPad_Air),
                              @"iPad4,2"    : @(iPad_Air),
                              @"iPad4,3"    : @(iPad_Air),
                              @"iPad5,3"    : @(iPad_Air_2),
                              @"iPad5,4"    : @(iPad_Air_2),
                              
                              // iPad mini
                              @"iPad2,5"    : @(iPad_Mini),
                              @"iPad2,6"    : @(iPad_Mini),
                              @"iPad2,7"    : @(iPad_Mini),
                              
                              @"iPad4,4"    : @(iPad_Mini_2),
                              @"iPad4,5"    : @(iPad_Mini_2),
                              @"iPad4,6"    : @(iPad_Mini_2),
                              
                              @"iPad4,7"    : @(iPad_Mini_3),
                              @"iPad4,8"    : @(iPad_Mini_3),
                              @"iPad4,9"    : @(iPad_Mini_3),
                              
                              @"iPad5,1"    : @(iPad_Mini_4),
                              @"iPad5,2"    : @(iPad_Mini_4),
                              
                              // iPad Pro
                              @"iPad6,3"    : @(iPad_Pro_9_7),
                              @"iPad6,4"    : @(iPad_Pro_9_7),
                              
                              @"iPad7,3"    : @(iPad_Pro_10_5),
                              @"iPad7,4"    : @(iPad_Pro_10_5),
                              
                              @"iPad6,7"    : @(iPad_Pro_12_9),
                              @"iPad6,8"    : @(iPad_Pro_12_9),
                              
                              @"iPad7,1"    : @(iPad_Pro_12_9_2),
                              @"iPad7,2"    : @(iPad_Pro_12_9_2)};
    });
    return deviceNamesByCode;
}

/**
 获取设备的类型的封装
 
 @return 返回设备类型
 */
+ (NSString*)getDeviceInfoType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //MARK: More official list is at
    //http://theiphonewiki.com/wiki/Models
    //MARK: You may just return machineName. Following is for convenience
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"i386 Simulator",
      @"x86_64":   @"x86_64 Simulator",
      
      @"iPhone1,1":    @"iPhone",
      @"iPhone1,2":    @"iPhone 3G",
      @"iPhone2,1":    @"iPhone 3GS",
      @"iPhone3,1":    @"iPhone 4",
      @"iPhone3,2":    @"iPhone 4(Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      @"iPhone4,1":    @"iPhone 4S",
      @"iPhone5,1":    @"iPhone 5(GSM)",
      @"iPhone5,2":    @"iPhone 5(GSM+CDMA)",
      @"iPhone5,3":    @"iPhone 5c(GSM)",
      @"iPhone5,4":    @"iPhone 5c(GSM+CDMA)",
      @"iPhone6,1":    @"iPhone 5s(GSM)",
      @"iPhone6,2":    @"iPhone 5s(GSM+CDMA)",
      
      @"iPhone7,1":    @"iPhone 6+(GSM+CDMA)",
      @"iPhone7,2":    @"iPhone 6(GSM+CDMA)",
      
      @"iPhone8,1":    @"iPhone 6S(GSM+CDMA)",
      @"iPhone8,2":    @"iPhone 6S+(GSM+CDMA)",
      @"iPhone8,4":    @"iPhone SE(GSM+CDMA)",
      @"iPhone9,1":    @"iPhone 7(GSM+CDMA)",
      @"iPhone9,2":    @"iPhone 7+(GSM+CDMA)",
      @"iPhone9,3":    @"iPhone 7(GSM+CDMA)",
      @"iPhone9,4":    @"iPhone 7+(GSM+CDMA)",
      @"iPhone10,1":   @"iPhone 8(CDMA)",
      @"iPhone10,4":   @"iPhone 8(GSM)",
      @"iPhone10,2":   @"iPhone 8+(CDMA)",
      @"iPhone10,5":   @"iPhone 8+(GSM)",
      @"iPhone10,3":   @"iPhone X(CDMA)",
      @"iPhone10,6":   @"iPhone X(GSM)",
      
      @"iPad1,1":  @"iPad",
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPad Mini 1G (WiFi)",
      @"iPad2,6":  @"iPad Mini 1G (GSM)",
      @"iPad2,7":  @"iPad Mini 1G (GSM+CDMA)",
      @"iPad3,1":  @"iPad 3(WiFi)",
      @"iPad3,2":  @"iPad 3(GSM+CDMA)",
      @"iPad3,3":  @"iPad 3(GSM)",
      @"iPad3,4":  @"iPad 4(WiFi)",
      @"iPad3,5":  @"iPad 4(GSM)",
      @"iPad3,6":  @"iPad 4(GSM+CDMA)",
      
      @"iPad4,1":  @"iPad Air(WiFi)",
      @"iPad4,2":  @"iPad Air(GSM)",
      @"iPad4,3":  @"iPad Air(GSM+CDMA)",
      
      @"iPad5,3":  @"iPad Air 2 (WiFi)",
      @"iPad5,4":  @"iPad Air 2 (GSM+CDMA)",
      
      @"iPad4,4":  @"iPad Mini 2G (WiFi)",
      @"iPad4,5":  @"iPad Mini 2G (GSM)",
      @"iPad4,6":  @"iPad Mini 2G (GSM+CDMA)",
      
      @"iPad4,7":  @"iPad Mini 3G (WiFi)",
      @"iPad4,8":  @"iPad Mini 3G (GSM)",
      @"iPad4,9":  @"iPad Mini 3G (GSM+CDMA)",
      
      @"iPod1,1":  @"iPod 1st Gen",
      @"iPod2,1":  @"iPod 2nd Gen",
      @"iPod3,1":  @"iPod 3rd Gen",
      @"iPod4,1":  @"iPod 4th Gen",
      @"iPod5,1":  @"iPod 5th Gen",
      @"iPod7,1":  @"iPod 6th Gen",
      };
    NSString *deviceName = commonNamesDictionary[machineName];
    if (deviceName == nil) {
        deviceName = machineName;
    }
    return deviceName;
}

/**
 获取设备类型
 
 @return 返回设备类型
 */
+ (JDJR_DeviceType)getDeviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    JDJR_DeviceType version = (JDJR_DeviceType)[[self.deviceNamesByCode objectForKey:code] integerValue];
    return version;
}

/**
 获取Hardware
 
 @return Hardware
 */
+(NSString *)getHardware {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *hardware = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return  hardware;
}

/**
 获取设备尺寸类型
 
 @return 设备尺寸类型
 */
+ (JDJR_DeviceSizeType)getDeviceSizeType {
    JDJR_DeviceSizeType sizeType = UnknownSize;
    JDJR_DeviceType deviceType = [self getDeviceType];
    if (iPod == deviceType
        || iPad_2 == deviceType
        || iPad_3 == deviceType
        || iPad_4 == deviceType) {
        sizeType = iPod_3_5_inch;
    } else if (iPod_5 == deviceType
               || iPod_6 == deviceType) {
        sizeType = iPod_4_0_inch;
    }else if (iPhone_3G == deviceType
              || iPhone_3GS == deviceType
              || iPhone_4 == deviceType
              || iPhone_4S == deviceType) {
        sizeType = iPhone_3_5_inch;
    }
    else if (iPhone_5 == deviceType
             || iPhone_5C == deviceType
             || iPhone_5S == deviceType
             || iPhone_SE == deviceType){
        sizeType = iPhone_4_0_inch;
    } else if (iPhone_6 == deviceType
               || iPhone_6S == deviceType
               || iPhone_7 == deviceType
               || iPhone_8 == deviceType) {
        sizeType = iPhone_4_7_inch;
    } else if (iPhone_6_Plus == deviceType
               || iPhone_6S_Plus == deviceType
               || iPhone_7_Plus == deviceType
               || iPhone_8_Plus == deviceType) {
        sizeType = iPhone_5_5_inch;
    }
    else if (iPhone_X == deviceType) {
        sizeType = iPhone_5_8_inch;
    }
    else if (iPad_Mini == deviceType
             || iPad_Mini_2 == deviceType
             || iPad_Mini_3 == deviceType
             || iPad_Mini_4 == deviceType) {
        sizeType = iPad_7_9_inch;
    }
    else if (iPad == deviceType
             || iPad_2 == deviceType
             || iPad_3 == deviceType
             || iPad_4 == deviceType
             || iPad_5 == deviceType
             || iPad_Air == deviceType
             || iPad_Air_2 == deviceType
             || iPad_Pro_9_7 == deviceType) {
        sizeType = iPad_9_7_inch;
    }
    else if (iPad_Pro_10_5 == deviceType) {
        sizeType = iPad_10_5_inch;
    }
    else if (iPad_Pro_12_9 == deviceType
             || iPad_Pro_12_9_2 == deviceType) {
        sizeType = iPad_12_9_inch;
    }
    return sizeType;
}
+ (NSString *)deviceInchWithType:(JDJR_DeviceSizeType)sizeType {
    NSString *sizeTypeStr = @"Unknow";
    switch (sizeType){
        case Unknow:
            sizeTypeStr = @"Unknow";
            break;
        case iPod_3_5_inch:
            sizeTypeStr = @"iPod 3.5-inch";
            break;
        case iPod_4_0_inch:
            sizeTypeStr = @"iPod 4.0-inch";
            break;
        case iPhone_3_5_inch:
            sizeTypeStr = @"iPhone 3.5-inch";
            break;
        case iPhone_4_0_inch:
            sizeTypeStr = @"iPhone 4.0-inch";
            break;
        case iPhone_4_7_inch:
            sizeTypeStr = @"iPhone 4.7-inch";
            break;
        case iPhone_5_5_inch:
            sizeTypeStr = @"iPhone 5.5-inch";
            break;
        case iPhone_5_8_inch:
            sizeTypeStr = @"iPhone 5.8-inch";
            break;
        case iPad_7_9_inch:
            sizeTypeStr = @"iPad 7.9-inch";
            break;
        case iPad_10_5_inch:
            sizeTypeStr = @"iPad 10.5-inch";
            break;
        case iPad_12_9_inch:
            sizeTypeStr = @"iPad 12.9-inch";
            break;
        default:
            sizeTypeStr = @"Unknow";
            break;
    }
    return sizeTypeStr;
}

/**
 返回屏幕尺寸
 
 @return 当前设备的尺寸
 */
+ (CGFloat )getDeviceNumInch {
    return [self deviceNumInchWithType:[self getDeviceSizeType]];
}

+ (CGFloat )deviceNumInchWithType:(JDJR_DeviceSizeType)sizeType {
    CGFloat result = 4.7;
    switch (sizeType){
        case Unknow:
            result = 4.7;
            break;
        case iPod_3_5_inch:
            result = 3.5;
            break;
        case iPod_4_0_inch:
            result = 4.0;
            break;
        case iPhone_3_5_inch:
            result = 3.5;
            break;
        case iPhone_4_0_inch:
            result = 4.0;
            break;
        case iPhone_4_7_inch:
            result = 4.7;
            break;
        case iPhone_5_5_inch:
            result = 5.5;
            break;
        case iPhone_5_8_inch:
            result = 5.8;
            break;
        case iPad_7_9_inch:
            result = 7.9;
            break;
        case iPad_10_5_inch:
            result = 10.5;
            break;
        case iPad_12_9_inch:
            result = 12.9;
            break;
        default:
            result = 4.7;
            break;
    }
    return result;
}


/**
 获取不太准确的ppi
 
 @return ppi
 */
+(CGFloat)getHasErrorDevicePpi {
    int width = [[UIScreen mainScreen] currentMode].size.width;
    int height = [[UIScreen mainScreen] currentMode].size.height;
    int  inch = [self deviceNumInchWithType:[self getDeviceSizeType]];
    CGFloat ppi = sqrt(width*width + height * height)/inch;
    return ppi;
}
/**
 获取设备的ppi
 */
+(NSInteger)getDevicePpi {
    NSInteger retPpi = 163;
    JDJR_DeviceType deviceType = [self getDeviceType];
    switch (deviceType){
        case Unknow:
            retPpi = 163;
            break;
        case Simulator:
            retPpi = 163;
            break;
        case iPod:
            retPpi = 163;
            break;
        case iPod_2:
            retPpi = 163;
            break;
        case iPod_3:
            retPpi = 163;
            break;
        case iPod_4:
            retPpi = 163;
            break;
        case iPod_5:
            retPpi = 163;
            break;
        case iPod_6:
            retPpi = 163;
            break;
        case iPhone:
            retPpi = 163;
            break;
        case iPhone_3G:
            retPpi = 163;
            break;
        case iPhone_3GS:
            retPpi = 163;
            break;
        case iPhone_4:
            retPpi = 163;
            break;
        case iPhone_4S:
            retPpi = 326;
            break;
        case iPhone_5:
            retPpi = 326;
            break;
        case iPhone_5C:
            retPpi = 326;
            break;
        case iPhone_5S:
            retPpi = 326;
            break;
        case iPhone_6:
            retPpi = 326;
            break;
        case iPhone_6_Plus:
            retPpi = 401;
            break;
        case iPhone_6S:
            retPpi = 326;
            break;
        case iPhone_6S_Plus:
            retPpi = 401;
            break;
        case iPhone_SE:
            retPpi = 326;
            break;
        case iPhone_7:
            retPpi = 326;
            break;
        case iPhone_7_Plus:
            retPpi = 401;
            break;
        case iPhone_8:
            retPpi = 326;
            break;
        case iPhone_8_Plus:
            retPpi = 401;
            break;
        case iPhone_X:
            retPpi = 458;
            break;
        case iPad:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_2:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_3:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_4:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_5:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Air:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Air_2:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Mini:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Mini_2:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Mini_3:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Mini_4:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Pro_9_7:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Pro_10_5:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Pro_12_9:
            retPpi = [self getHasErrorDevicePpi];
            break;
        case iPad_Pro_12_9_2:
            retPpi = [self getHasErrorDevicePpi];
            break;
        default:
            retPpi = [self getHasErrorDevicePpi];
            break;
    }
    return retPpi;
}

/**
 判断系统是否是iOS7 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS7Later {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

/**
 判断系统是否是iOS8 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS8Later {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}

/**
 判断系统是否是iOS9 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS9Later {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0;
}

/**
 判断系统是否是iOS10 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS10Later {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0;
}

/**
 判断系统是否是iOS11 之后的系统
 
 @return 返回是否
 */
- (BOOL)iOS11Later {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0;
}

@end
