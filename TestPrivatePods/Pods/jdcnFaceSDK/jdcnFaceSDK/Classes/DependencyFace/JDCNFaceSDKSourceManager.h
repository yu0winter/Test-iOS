//
//  JDCNFaceSDKSourceManager.h
//  Pods
//
//  Created by 刘豆 on 2018/9/5.
//

#import <Foundation/Foundation.h>

#define JDCNSDKDependencyFace_BUNDLE_NAME @"JDCNSDKDependencyFace.bundle"
#define JDCNSDKDependencyFace_PATH [[[NSBundle bundleForClass:[JDCNFaceSDKSourceManager class]] resourcePath] stringByAppendingPathComponent:JDCNSDKDependencyFace_BUNDLE_NAME]
#define JDCNSDKDependencyFace_BUNDLE [NSBundle bundleWithPath:JDCNSDKDependencyFace_PATH]

@interface JDCNFaceSDKSourceManager : NSObject
/**
 获取本sdk资源。
 
 @param sourceName 资源名称
 @param sourceType 资源类型
 @return 返回资源路径
 */
+ (NSString *)JDCNSDKDependencyFace_GtePathForResource:(NSString *)sourceName ofType:(NSString *)sourceType;
@end
