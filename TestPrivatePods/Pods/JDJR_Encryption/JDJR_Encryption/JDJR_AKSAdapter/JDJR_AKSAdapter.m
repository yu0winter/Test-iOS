//
//  JDJR_AKSAdapter.m
//  JDJR_Encryption
//
//  Created by 成勇 on 2018/8/29.
//

#import "JDJR_AKSAdapter.h"

typedef  NSMutableData * (^AKSP7EnvelopeBlock)(NSString *certData, NSData *sourceData, NSError * __autoreleasing *error);

@interface JDJR_AKSAdapter()
@property (readwrite, nonatomic, copy) AKSP7EnvelopeBlock p7Envelope;
@end

@implementation JDJR_AKSAdapter

/**
 AKS 适配器
 
 @return AKS实例类
 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static JDJR_AKSAdapter *instance;
    dispatch_once(&onceToken, ^{
        instance =  [[self alloc] init];
    });
    return instance;
}

/**
 AKS P7Envelope加密适配器
 
 @param block 回调数据
 */
- (void)setAKSP7EnvelopeBlock:( nullable NSMutableData * (^)(NSString *certData, NSData *sourceData, NSError * __autoreleasing *error))block {
    self.p7Envelope = block;
}

/**
 AKS P7Envelope加密适配器
 
 */
- (NSMutableData *)p7Envelope:(NSString *)certData
                   sourceData:(NSData *)sourceData {
    if (self.p7Envelope) {
        NSError *adapterError;
        NSMutableData *retData = self.p7Envelope(certData,sourceData,&adapterError);
        NSLog(@"error:%@",adapterError);
        return retData;
    }else {
        return nil;
    }
}

/**
 AKS P7Envelope 使用运行时去加载
 
 */
- (NSMutableData *)runTimeP7Envelope:(NSString *)certData
                          sourceData:(NSData *)sourceData {
    NSMutableData * ret;
    Class class = NSClassFromString(@"IOSCryptolib");
    if (class) {
        id myldld = [class performSelector:@selector(sharedInstance) withObject:nil];
        ret = [myldld performSelector:@selector(p7Envelope:sourceData:) withObject:certData withObject:sourceData];
        NSData *p7Ret = [ret subdataWithRange:NSMakeRange(5, ret.length -5)];
        return [NSMutableData dataWithData:p7Ret];
    } else {
        return [self p7Envelope:certData sourceData:sourceData];
    }
}

@end
