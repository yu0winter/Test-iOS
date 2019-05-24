//
//  AppDevice.h
//
//
//  Created by wangxiugang on 12-10-31.
//
//设备定义

#ifndef jrapp_AppDevice_h
#define jrapp_AppDevice_h



// Screen Size
#define UIScreen_W CGRectGetWidth([[UIScreen mainScreen] bounds])
#define UIScreen_H CGRectGetHeight([[UIScreen mainScreen] bounds])

#define IsPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)


#define IOS9 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
#define IOS10 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
#define IOS11 (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0"))

//判断itouch
#define iPod_touch [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]

#define iPad {\
    NSString* model = [[UIDevice currentDevice] model];\
    if([model hasPrefix:@"iPad"]){return YES;} else{return NO}}


#define INTERFACE_IS_PAD     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define INTERFACE_IS_PHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6PlusBigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)




#define kJDCNMinSysVersion 8.0 // >= this value OK
#define K_SYS_PLATFORM_IOS
#define K_FFS_TYPE_BOTH_FIX

#include <stdio.h>

//#define _JDCN_DEBUG_

#ifdef _JDCN_DEBUG_  //note for release
#define JDCN_DEBUG(...) printf(__VA_ARGS__)
// #define JDCN_DEBUG(format, ...) printf("File: "__FILE__", Line: %05d: "format"\n", __LINE__, ##__VA_ARGS__)
#else
#define JDCN_DEBUG(...)
#endif 

#endif













