//
//  JDCNSDKManager+JDCNEncryptedData.m
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/11/23.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "JDCNSDKManager+JDCNEncryptedData.h"
#import "JDJR_Base64.h"
#import "JDJR_Sha_XX.h"
#import "JDCNsdkDnsAksManager.h"
#import "JDCNSDKManager+FaceVerify.h"

@implementation JDCNSDKManager (JDCNEncryptedData)

/**
 加密刷脸数据
 
 @param faceData 刷脸数据集合
 @return 加密后的数据集合
 */
- (NSArray *)jdcnEncryptedWithFaceData:(NSArray *)faceData {
    if (!faceData || !faceData.count) {
        return nil;
    }
    
    // 刷脸数据加密
    NSMutableData *mutableEncryptFaceData = [JDCNsdkDnsAksManager jdcnFaceDataAksEncryptWithSourceData:faceData[0]];
    // 动作图数据
    NSString *base64FaceStrAction = nil;
    // 动作活体图
    if (faceData.count > 2) {
        // 动作活体
        NSMutableData *mutableEncryptActionData = [JDCNsdkDnsAksManager jdcnFaceDataAksEncryptWithSourceData:faceData[2]];
        
        base64FaceStrAction = [self faceEncryptFormatWithFaceType:JDCNSDKManagerFaceDataTypeAP
                                                       Identifier:[JDJR_Sha_XX sha384:[JDJR_Base64 stringByEncodingData:mutableEncryptActionData]]
                                                   withFaceString:[JDJR_Base64 stringByEncodingData:mutableEncryptActionData]];
    }
    // 小图
    NSString *base64FaceStr = [[JDCNSDKManager sharedInstance] faceEncryptFormatWithFaceType:JDCNSDKManagerFaceDataTypeSFF
                                                                                  Identifier:[JDJR_Sha_XX sha384:[JDJR_Base64 stringByEncodingData:mutableEncryptFaceData]]
                                                                              withFaceString:[JDJR_Base64 stringByEncodingData:mutableEncryptFaceData]];
    // 返回加密后的facedata集合
    NSMutableArray *arrayFaceData = base64FaceStrAction ? [[NSMutableArray alloc] initWithObjects:base64FaceStr, base64FaceStrAction, nil] : [[NSMutableArray alloc] initWithObjects:base64FaceStr, nil];
    
    return arrayFaceData;
}

@end
