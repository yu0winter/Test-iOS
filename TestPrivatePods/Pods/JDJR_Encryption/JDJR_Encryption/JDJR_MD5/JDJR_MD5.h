//
//  JDJR_MD5.h
//  JDJR_Encryption
//
//  Created by ixf on 2018/6/18.
//

#import <Foundation/Foundation.h>

@interface JDJR_MD5 : NSObject


/**
 md5 加密字符串

 @param string 需要加密的字符串
 @return 加密后的字符串
 */
+(NSString*)md5EncryptWithString:(NSString*)string;


/**
 md5 加密nsdata

 @param data 需要加密的data
 @return 加密后的数据
 */
+(NSString*)md5EncryptWithData:(NSData*)data;
@end
