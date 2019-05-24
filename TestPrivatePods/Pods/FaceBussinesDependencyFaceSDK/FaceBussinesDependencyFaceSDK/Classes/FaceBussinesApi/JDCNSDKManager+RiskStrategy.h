//
//  JDCNSDKManager+RiskStrategy.h
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 JDJR. All rights reserved.
//  风控策略分类

#import <jdcnFaceSDK/JDCNSDKManager.h>

/**
 SDK验证枚举

 - JDCNSDKManagerValidateNotAvailable: 不可用
 - JDCNSDKManagerValidateAvailableWithSlience: 静默
 - JDCNSDKManagerValidateAvailableWithLiving: 动作
 */
typedef NS_OPTIONS(NSInteger, JDCNSDKManagerValidate) {
    JDCNSDKManagerValidateNotAvailable,
    JDCNSDKManagerValidateAvailableWithSlience,
    JDCNSDKManagerValidateAvailableWithLiving
};

@interface JDCNSDKManager (RiskStrategy)

/**
 验证sdk是否可用

 @param parameter 参数
 @param complete 完成处理
 */
- (void)validateAvailableWithParameter:(NSDictionary *)parameter
                           didComplete:(void (^)(JDCNSDKManagerValidate validate, NSError *error))complete;

@end
