//
//  JDCNRiskFaceVerifyJSONParsing.h
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/29.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDCNRiskFaceVerifyResponse.h"

@interface JDCNRiskFaceVerifyJSONParsing : NSObject

/**
 解析响应数据
 
 @param responseObject 响应数据
 @return JDCNRiskFaceVerifyResponse instance
 */
+ (JDCNRiskFaceVerifyResponse *)jsonParsingWithResponseObject:(id)responseObject;

@end
