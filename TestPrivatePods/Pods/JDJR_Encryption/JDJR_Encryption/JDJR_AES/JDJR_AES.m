//
//  JDJR_AES.m
//  JDJR_Encryption
//
//  Created by ixf on 2018/6/18.
//

#import "JDJR_AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "JDJR_Base64.h"

@implementation JDJR_AES
/**
 aes加密字符串
 
 @param jsonData 需要加密的Json字符串
 @param key 加密使用的key
 @param iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 加密后的字符串
 */

+(NSString*)AES128EncryptJsonData:(NSString*)jsonData Key:(NSString *)key iv:(NSString *)iv{
    NSData * selfData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [selfData length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptorStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [selfData bytes], [selfData length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        NSLog(@"Success");
        
        return  [[NSString alloc] initWithData:[JDJR_Base64 encodeData:[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted]] encoding:NSUTF8StringEncoding];
        
    }else{
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}


/**
 aes解密
 
 @param strData 需要解密的字符串
 @param key 加密使用的key
 @param iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 解密后的字符串
 */
+(NSString*)AES128DecryptStrData:(NSString*)strData Key:(NSString *)key iv:(NSString *)iv{
    NSData * selfData =   [[NSData alloc]initWithBase64EncodedString:strData options:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [selfData length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptorStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [selfData bytes], [selfData length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        return    [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted] encoding:NSUTF8StringEncoding];
        
    }else{
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}


/**
 aes加解密算法
 
 @param operation 加解密区别
 @param data 需要加解密的数据
 @param key key 加解密使用的key
 @param iv iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 加解密后的字符串
 */
+(NSString*)AES128operation:(CCOperation)operation Data:(NSString*)data Key:(NSString *)key iv:(NSString *)iv{
    NSData * selfData = [data dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES128 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [selfData length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [selfData bytes], [selfData length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        return  [[NSString alloc] initWithData:[JDJR_Base64 encodeData:[NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted]] encoding:NSUTF8StringEncoding];
        
    }else{
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}
@end
