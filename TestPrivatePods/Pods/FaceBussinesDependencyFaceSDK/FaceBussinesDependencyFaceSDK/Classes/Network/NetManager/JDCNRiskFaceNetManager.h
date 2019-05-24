//
//  JDCNRiskFaceNetManager.h
//  Pods
//
//  Created by 刘豆 on 2018/9/10.
//

#import <Foundation/Foundation.h>
#import <JDJR_Networking/JDJR_NetManager.h>
// URL
static NSString * const kJDCNSessionHttpBaseUrl = @"https://identify.jd.com";
//timeOut
static NSInteger  const kJDCNSessionHttpTimeOut = 5;

@interface JDCNRiskFaceNetManager : NSObject

+ (JDCNRiskFaceNetManager*)riskFaceNetManager;

@property(nonatomic , strong)JDJR_NetManager *jdjrNetManager;
@end
