//
//  JDCNRiskFaceNetManager.m
//  Pods
//
//  Created by 刘豆 on 2018/9/10.
//

#import "JDCNRiskFaceNetManager.h"


@implementation JDCNRiskFaceNetManager

+ (JDCNRiskFaceNetManager*)riskFaceNetManager{
    
    static JDCNRiskFaceNetManager *riskFaceNetManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        riskFaceNetManager = [[JDCNRiskFaceNetManager alloc] init];
    });
    return riskFaceNetManager;
    
}
- (JDJR_NetManager*)jdjrNetManager{
    if (!_jdjrNetManager) {
        _jdjrNetManager = [[JDJR_NetManager alloc]initWithBaseURL:[NSURL URLWithString:kJDCNSessionHttpBaseUrl] WithSessionConfiguration:nil];
        [_jdjrNetManager setTimeout:kJDCNSessionHttpTimeOut];
    }
    return _jdjrNetManager;
}
@end
