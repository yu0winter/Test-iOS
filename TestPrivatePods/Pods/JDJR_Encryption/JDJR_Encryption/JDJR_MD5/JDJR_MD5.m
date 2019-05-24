//
//  JDJR_MD5.m
//  JDJR_Encryption
//
//  Created by ixf on 2018/6/18.
//

#import "JDJR_MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JDJR_MD5

/**
 md5 加密字符串
 
 @param string 需要加密的字符串
 @return 加密后的字符串
 */
+(NSString*)md5EncryptWithString:(NSString*)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return [result lowercaseString];
}

/**
 md5 加密nsdata
 
 @param data 需要加密的data
 @return 加密后的数据
 */
+(NSString*)md5EncryptWithData:(NSData*)data{
    //1: 创建一个MD5对象
    CC_MD5_CTX md5;
    //2: 初始化MD5
    CC_MD5_Init(&md5);
    //3: 准备MD5加密
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)data.length);
    //4: 准备一个字符串数组, 存储MD5加密之后的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //5: 结束MD5加密
    CC_MD5_Final(result, &md5);
    NSMutableString *resultString = [NSMutableString string];
    //6:从result数组中获取最终结果
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02X", result[i]];
    }
    return [resultString lowercaseString];
}
@end
