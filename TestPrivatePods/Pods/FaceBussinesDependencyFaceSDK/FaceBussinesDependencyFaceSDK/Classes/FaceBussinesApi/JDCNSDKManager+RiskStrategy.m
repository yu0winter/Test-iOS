//
//  JDCNSDKManager+RiskStrategy.m
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNSDKManager+RiskStrategy.h"
#import "JDCNRiskStrategyRequest.h"
#import "JDCNRiskStrategyJSONParsing.h"
#import "JDCNRiskStrategyResponse.h"
#import "JDCNRiskFaceNetManager.h"

@implementation JDCNSDKManager (RiskStrategy)

/**
 验证sdk是否可用
 
 @param parameter 参数
 @param complete 完成处理
 */
- (void)validateAvailableWithParameter:(NSDictionary *)parameter
                           didComplete:(void (^)(JDCNSDKManagerValidate validate, NSError *error))complete {
    NSParameterAssert(parameter);
    
    __weak typeof(self) weakSelf = self;
    [JDCNRiskStrategyRequest postRiskStrategyWithParameter:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"responseObject = %@", responseObject);
        JDCNRiskStrategyResponse *riskStrategyResponse = [JDCNRiskStrategyJSONParsing jsonParsingWithResponseObject:responseObject];
        JDCNSDKManagerValidate validate = JDCNSDKManagerValidateNotAvailable;
        // 测试代码
//        int x = arc4random() % 3;
//        if (!x) {
//            riskStrategyResponse.data.sdkCmd = @"A";
//        } else if (x == 1) {
//            riskStrategyResponse.data.sdkCmd = @"S";
//        } else if (x == 2) {
//            riskStrategyResponse.data.sdkCmd = @"D";
//        }
        
        if (riskStrategyResponse) {
            if (![riskStrategyResponse.code integerValue]) {
                if ([riskStrategyResponse.data.sdkCmd isEqualToString:@"S"]) {
                    // 静默
                    validate = JDCNSDKManagerValidateAvailableWithSlience;
                    JDCNLiveConfig  *slientConfig = [[JDCNLiveConfig alloc] init];
                    slientConfig.liveMode = JDCNLiveModeSilence;
                    [strongSelf setSDKConfig:slientConfig];
                } else if ([riskStrategyResponse.data.sdkCmd isEqualToString:@"A"]) {
                    // 动作
                    validate = JDCNSDKManagerValidateAvailableWithLiving;
                    JDCNLiveConfig  *actionConfig = [[JDCNLiveConfig alloc] init];
                    actionConfig.liveMode = JDCNLiveModeSilenceAndAction;
                    actionConfig.actionArray = @[@(JDCNActionTypeBlink)].mutableCopy;
                    [strongSelf setSDKConfig:actionConfig];
                } else {
                    // 拒绝
                    validate = JDCNSDKManagerValidateNotAvailable;
                }
            }
        }
        
        if (complete) {
            complete(validate, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (complete) {
            complete(JDCNSDKManagerValidateNotAvailable, error);
        }
    } sessionDidBecomeInvalid:^(NSURLSession *session, NSError *error) {
        if (complete) {
            complete(JDCNSDKManagerValidateNotAvailable, error);
        }
    } taskDidComplete:^(NSURLSession *session, NSURLSessionTask *task, NSError *error) {
        
    }];
}

@end
