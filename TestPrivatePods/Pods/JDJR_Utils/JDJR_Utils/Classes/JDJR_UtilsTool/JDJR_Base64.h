//
//  JDJR_Base64.h
//  JDJR_Utils
//
//  Created by ixf on 2018/6/18.
//

#import <Foundation/Foundation.h>

@interface JDJR_Base64 : NSObject

+(NSData *)encodeData:(NSData *)data;

+(NSData *)decodeData:(NSData *)data;

+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSString *)stringByEncodingData:(NSData *)data;

+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;

+(NSData *)decodeString:(NSString *)string;

+(NSData *)webSafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;

+(NSData *)webSafeDecodeData:(NSData *)data;

+(NSData *)webSafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;

+(NSData *)webSafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;

// stringByWebSafeEncodingBytes:length:padded:
//
/// WebSafe Base64 encodes the data pointed at by |bytes|.  If |padded| is YES
/// then padding characters are added so the result length is a multiple of 4.
//
/// Returns:
///   A new autoreleased NSString with the encoded payload.  nil for any error.
//
+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;

// webSafeDecodeString:
//
/// WebSafe Base64 decodes contents of the NSString.
//
/// Returns:
///   A new autoreleased NSData with the decoded payload.  nil for any error.
//
+(NSData *)webSafeDecodeString:(NSString *)string;
@end
