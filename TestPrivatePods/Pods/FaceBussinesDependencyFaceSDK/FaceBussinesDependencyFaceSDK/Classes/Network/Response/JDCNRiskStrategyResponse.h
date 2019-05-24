//
//  JDCNRiskStrategyResponse.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCNRiskStrategyDataResponse.h"

@interface JDCNRiskStrategyResponse : NSObject

/**
 响应码
 */
@property (nonatomic, strong, readwrite) NSString *code;

/**
 响应消息
 */
@property (nonatomic, strong, readwrite) NSString *msg;

/**
 风控策略对象
 */
@property (nonatomic, strong, readwrite) JDCNRiskStrategyDataResponse *data;

@end
