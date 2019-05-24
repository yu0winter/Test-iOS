//
//  JDCNRiskStrategyDataResponse.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCNRiskStrategyDataResponse : NSObject

/**
 验证流水
 */
@property (nonatomic, strong, readwrite) NSString *verifyId;

/**
 sdkcmd S:静默活体, A:动作活体, D:禁用自研
 */
@property (nonatomic, strong, readwrite) NSString *sdkCmd;

/**
 服务端响应时间
 */
@property (nonatomic, strong, readwrite) NSString *resptime;

@end
