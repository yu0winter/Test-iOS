//
//  JDCNRiskFaceVerifyDataResponse.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDCNRiskFaceVerifyDataResponse : NSObject

@property (nonatomic, strong, readwrite) NSString *verifyId;
@property (nonatomic, strong, readwrite) NSString *result;
@property (nonatomic, strong, readwrite) NSString *verifyToken;
@property (nonatomic, strong, readwrite) NSString *verityDate;
@property (nonatomic, strong, readwrite) NSString *message;
@property (nonatomic, strong, readwrite) NSString *code;

@end
