//
//  JDCNsdkDnsAksManager.h
//  Pods
//
//  Created by 刘豆 on 2018/9/4.
//

#import <Foundation/Foundation.h>

#define JDCNFaceBuss_BUNDLE_NAME @ "FaceBussinesDependencyFaceSDK.bundle"
#define JDCNFaceBuss_PATH [[[NSBundle bundleForClass:[JDCNsdkDnsAksManager class]] resourcePath] stringByAppendingPathComponent: JDCNFaceBuss_BUNDLE_NAME]
#define JDFaceBuss_BUNDLE [NSBundle bundleWithPath:JDCNFaceBuss_PATH]

@interface JDCNsdkDnsAksManager : NSObject
/**
 aks加密
 
 @param sourceData 元数据
 @return 加密数据
 */
+ (NSMutableData *)jdcnFaceDataAksEncryptWithSourceData:(NSData *)sourceData;
@end
