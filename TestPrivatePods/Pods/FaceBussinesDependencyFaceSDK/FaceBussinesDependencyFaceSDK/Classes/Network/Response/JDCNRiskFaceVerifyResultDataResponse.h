//
//  JDCNRiskFaceVerifyResultDataResponse.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCNRiskFaceVerifyDataResponse.h"

@interface JDCNRiskFaceVerifyResultDataResponse : NSObject

@property (nonatomic, assign, readwrite) BOOL isSuccess;
@property (nonatomic, strong, readwrite) NSString *errorType;
@property (nonatomic, strong, readwrite) NSString *info;
@property (nonatomic, strong, readwrite) JDCNRiskFaceVerifyDataResponse *data;

@end
