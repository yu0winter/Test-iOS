//
//  JDJR_Sha_XX.h
//  Pods
//
//  Created by 刘豆 on 2018/9/4.
//

#import <Foundation/Foundation.h>

@interface JDJR_Sha_XX : NSObject
+ (NSString*)sha1:(NSString*)string;
+ (NSString*)sha224:(NSString*)string;
+ (NSString*)sha256:(NSString*)string;
+ (NSString*)sha384:(NSString*)string;
+ (NSString*)sha512:(NSString*)string;
@end
