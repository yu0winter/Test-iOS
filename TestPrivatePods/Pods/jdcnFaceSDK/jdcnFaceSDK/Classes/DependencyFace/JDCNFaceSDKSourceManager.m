//
//  JDCNFaceSDKSourceManager.m
//  Pods
//
//  Created by 刘豆 on 2018/9/5.
//

#import "JDCNFaceSDKSourceManager.h"

@implementation JDCNFaceSDKSourceManager

+ (NSString *)JDCNSDKDependencyFace_GtePathForResource:(NSString *)sourceName ofType:(NSString *)sourceType{
    
    return [JDCNSDKDependencyFace_BUNDLE pathForResource:sourceName ofType:sourceType];
}

@end
