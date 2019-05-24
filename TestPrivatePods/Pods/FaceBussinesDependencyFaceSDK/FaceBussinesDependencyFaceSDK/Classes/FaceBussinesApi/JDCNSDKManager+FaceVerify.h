//
//  JDCNSDKManager+FaceVerify.h
//  JDCNSDK
//
//  Created by jd.huaxiaochun on 2017/7/28.
//  Copyright © 2017年 JDJR. All rights reserved.
//  刷脸验证分类

#import <jdcnFaceSDK/JDCNSDKManager.h>

typedef NS_OPTIONS(NSInteger, JDCNSDKManagerFaceDataType) {
    JDCNSDKManagerFaceDataTypeFF,
    JDCNSDKManagerFaceDataTypeSFF,
    JDCNSDKManagerFaceDataTypeAP
};

@interface JDCNSDKManager (FaceVerify)

/**
 刷脸验证

 @param parameter 参数
 @param complete 完成处理
 */
- (void)faceVerifyWithParameter:(NSDictionary *)parameter
                    didComplete:(void (^)(BOOL isSuccess, NSString *verifyToken, NSString *errorType, NSString *info, id responseObject,NSError *error))complete;


/**
 刷脸数据格式化

 @param identifier 标识
 @param faceType 刷脸数据类型
 @param faceStr faceStr
 @return 格式化后的字符串
 */
- (NSString *)faceEncryptFormatWithFaceType:(JDCNSDKManagerFaceDataType)faceType
                                 Identifier:(NSString *)identifier
                             withFaceString:(NSString *)faceStr;

@end
