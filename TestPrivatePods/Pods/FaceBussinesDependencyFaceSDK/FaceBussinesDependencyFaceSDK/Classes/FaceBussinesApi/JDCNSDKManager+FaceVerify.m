//
//  JDCNSDKManager+FaceVerify.m
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNSDKManager+FaceVerify.h"
#import "JDCNRiskFaceVerifyRequest.h"
#import "JDCNRiskFaceNetManager.h"
#import "JDCNRiskFaceVerifyResponse.h"
#import "JDCNRiskFaceVerifyJSONParsing.h"

@implementation JDCNSDKManager (FaceVerify)

/**
 刷脸验证
 
 @param parameter 参数
 @param complete 完成处理
 */
- (void)faceVerifyWithParameter:(NSDictionary *)parameter
                    didComplete:(void (^)(BOOL isSuccess, NSString *verifyToken, NSString *errorType, NSString *info, id responseObject,NSError *error))complete {
    
    NSParameterAssert(parameter);
    
    [JDCNRiskFaceVerifyRequest postRiskFaceVerifyWithParameter:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@", responseObject);
        
        BOOL isSuccess = NO;
        NSString *verifyToken;
        NSString *errorType;
        NSString *info;
        
        JDCNRiskFaceVerifyResponse *riskFaceVerifyResponse = [JDCNRiskFaceVerifyJSONParsing jsonParsingWithResponseObject:responseObject];
        if (riskFaceVerifyResponse) {
            if (![riskFaceVerifyResponse.resultCode integerValue]) {
                if (riskFaceVerifyResponse.resultData) {
                    errorType = riskFaceVerifyResponse.resultData.errorType;
                    info = riskFaceVerifyResponse.resultData.info;
                    isSuccess = riskFaceVerifyResponse.resultData.isSuccess;
                    if (riskFaceVerifyResponse.resultData.data) {
                        verifyToken = riskFaceVerifyResponse.resultData.data.verifyToken;
                    }
                }
            }
        }
        
        if (complete) {
            complete(isSuccess, verifyToken, errorType, info, responseObject, nil);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (complete) {
            complete(NO, nil, nil, nil, nil, error);
        }
    } sessionDidBecomeInvalid:^(NSURLSession *session, NSError *error) {
        if (complete) {
            complete(NO, nil, nil, nil, nil, error);
        }
    } taskDidComplete:^(NSURLSession *session, NSURLSessionTask *task, NSError *error) {
        
    }];
    
}

/**
 刷脸数据格式化
 
 @param identifier 标识
 @param faceType 刷脸数据类型
 @param faceStr faceStr
 @return 格式化后的字符串
 */
- (NSString *)faceEncryptFormatWithFaceType:(JDCNSDKManagerFaceDataType)faceType
                                 Identifier:(NSString *)identifier
                             withFaceString:(NSString *)faceStr {
    // 服务端版本兼容区分ios平台 后续待下沉SDK采用自研加密 下掉该后缀(:ios)
    switch (faceType) {
        case JDCNSDKManagerFaceDataTypeFF:
        {
            NSString *base64FaceStr = [NSString stringWithFormat:@"FF#%@:%@:%@:%@:ios", identifier, [JDCNSDKManager sdkName], [JDCNSDKManager sdkVersion], faceStr];
            return base64FaceStr;
        }
            break;
        case JDCNSDKManagerFaceDataTypeSFF:
        {
            NSString *base64FaceStr = [NSString stringWithFormat:@"SFF#%@:%@:%@:%@:ios", identifier, [JDCNSDKManager sdkName], [JDCNSDKManager sdkVersion], faceStr];
            return base64FaceStr;
        }
            break;
        case JDCNSDKManagerFaceDataTypeAP:
        {
            NSString *base64FaceStr = [NSString stringWithFormat:@"AP#%@:%@:%@:%@:ios", identifier, [JDCNSDKManager sdkName], [JDCNSDKManager sdkVersion], faceStr];
            return base64FaceStr;
        }
            break;
            
        default:
            break;
    }
}

@end
