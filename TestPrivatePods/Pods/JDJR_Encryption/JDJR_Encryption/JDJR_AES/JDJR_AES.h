//
//  JDJR_AES.h
//  JDJR_Encryption
//
//  Created by ixf on 2018/6/18.
//

#import <Foundation/Foundation.h>

@interface JDJR_AES : NSObject


/**
 aes加密字符串
 
 @param jsonData 需要加密的Json字符串
 @param key 加密使用的key
 @param iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 加密后的字符串
 */

+(NSString*)AES128EncryptJsonData:(NSString*)jsonData Key:(NSString *)key iv:(NSString *)iv;


/**
 aes解密
 
 @param strData 需要解密的字符串
 @param key 加密使用的key
 @param iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 解密后的字符串
 */
+(NSString*)AES128DecryptStrData:(NSString*)strData Key:(NSString *)key iv:(NSString *)iv;

@end
