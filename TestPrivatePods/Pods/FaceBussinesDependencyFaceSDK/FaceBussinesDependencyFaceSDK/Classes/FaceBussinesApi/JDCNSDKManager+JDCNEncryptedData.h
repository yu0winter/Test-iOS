//
//  JDCNSDKManager+JDCNEncryptedData.h
//  JDCNSDK1.5
//
//  Created by jd.huaxiaochun on 2017/11/23.
//  Copyright © 2017年 JDJR. All rights reserved.
//  加密刷脸数据

#import <jdcnFaceSDK/JDCNSDKManager.h>

@interface JDCNSDKManager (JDCNEncryptedData)

/**
 加密刷脸数据

 @param faceData 刷脸数据集合
 @return 加密后的刷脸数据集合
 */
- (NSArray *)jdcnEncryptedWithFaceData:(NSArray *)faceData;

@end
