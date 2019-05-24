//
//  JDJR_AKSAdapter.h
//  JDJR_Encryption
//
//  Created by 成勇 on 2018/8/29.
//

#import <Foundation/Foundation.h>

@interface JDJR_AKSAdapter : NSObject

/**
 AKS 适配器
 
 @return AKS实例类
 */
+ (instancetype)sharedInstance;

/**
 AKS P7Envelope加密适配器

 @param block 回调数据
 */
- (void)setAKSP7EnvelopeBlock:(nullable NSMutableData * _Nullable  (^)(NSString *certData, NSData *sourceData, NSError * __autoreleasing *error))block;

/**
 AKS P7Envelope加密适配器
 
 */
- (NSMutableData *)p7Envelope:(NSString *)certData
                   sourceData:(NSData *)sourceData;

/**
 AKS P7Envelope 使用运行时去加载
 
 */
- (NSMutableData *)runTimeP7Envelope:(NSString *)certData
                   sourceData:(NSData *)sourceData;


@end
