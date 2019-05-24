//
//  JDCNRiskFaceVerifyResponse.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCNRiskFaceVerifyResultDataResponse.h"

@interface JDCNRiskFaceVerifyResponse : NSObject

@property (nonatomic, strong, readwrite) NSString *resultCode;
@property (nonatomic, strong, readwrite) NSString *resultMsg;
@property (nonatomic, strong, readwrite) JDCNRiskFaceVerifyResultDataResponse *resultData;

@end
