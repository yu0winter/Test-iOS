//
//  UIDevice+JDJR_Category.h
//  JDJR_Utils
//
//  Created by ixf on 2018/6/18.
//

#import <UIKit/UIKit.h>

@interface UIDevice (JDJR_Category)

/**
 获取局域网的Ip 地址
 
 @return 返回局域网ip地址
 */
- (NSString *)jdjr_localIP;

/**
 获取MAC地址
 
 @return mac地址
 */
- (NSString *)jdjr_getMacAddress;

/**
 获取子网掩码
 
 @return netmask
 */
-(NSString *)jdjr_getNetmask;

/**
 获取网关地址
 
 @return 网关地址
 */
- (NSString *)jdjr_getGatewayIPAddress;


@end
