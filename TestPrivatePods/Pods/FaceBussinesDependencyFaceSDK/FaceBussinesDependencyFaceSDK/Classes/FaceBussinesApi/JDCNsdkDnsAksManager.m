//
//  JDCNsdkDnsAksManager.m
//  Pods
//
//  Created by 刘豆 on 2018/9/4.
//

#import "JDCNsdkDnsAksManager.h"
#import "JDJR_Base64.h"
#import <jdcnFaceSDK/JDCNSDKManager.h>
#import <JDJR_Encryption/JDJR_AKSAdapter.h>
@implementation JDCNsdkDnsAksManager
/**
 aks加密
 
 @param sourceData 元数据
 @return 加密数据
 */
+ (NSMutableData *)jdcnFaceDataAksEncryptWithSourceData:(NSData *)sourceData {
    
    NSString *cerPath = [JDFaceBuss_BUNDLE pathForResource:@"jrc_12_001-der" ofType:@"cer"];
    NSData* caCert = [NSData dataWithContentsOfFile:cerPath];
    NSString *cert = [JDJR_Base64 stringByEncodingData:caCert];
    NSMutableData * ret = [[JDJR_AKSAdapter sharedInstance] runTimeP7Envelope:cert sourceData:sourceData];
    if (ret) {
        return ret;
    } else {
        return nil;
    }
    
}
@end
