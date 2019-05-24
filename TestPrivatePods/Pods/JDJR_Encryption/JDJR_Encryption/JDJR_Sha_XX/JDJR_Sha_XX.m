//
//  JDJR_Sha_XX.m
//  Pods
//
//  Created by 刘豆 on 2018/9/4.
//

#import "JDJR_Sha_XX.h"
#import <CommonCrypto/CommonDigest.h>
@implementation JDJR_Sha_XX


static inline NSString *NSStringCCHashFunction(unsigned char *(function)(const void *data, CC_LONG len, unsigned char *md), CC_LONG digestLength, NSString *string)
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[digestLength];
    
    function(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:digestLength * 2];
    
    for (int i = 0; i < digestLength; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)sha1:(NSString*)string
{
    return NSStringCCHashFunction(CC_SHA1, CC_SHA1_DIGEST_LENGTH, string);
}

+ (NSString *)sha224:(NSString*)string
{
    return NSStringCCHashFunction(CC_SHA224, CC_SHA224_DIGEST_LENGTH, string);
}

+ (NSString *)sha256:(NSString*)string
{
    return NSStringCCHashFunction(CC_SHA256, CC_SHA256_DIGEST_LENGTH, string);
}

+ (NSString *)sha384:(NSString*)string
{
    return NSStringCCHashFunction(CC_SHA384, CC_SHA384_DIGEST_LENGTH, string);
}
+ (NSString *)sha512:(NSString*)string
{
    return NSStringCCHashFunction(CC_SHA512, CC_SHA512_DIGEST_LENGTH, string);
}
@end
