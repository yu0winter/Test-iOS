//
//  JDJR_FileUtil.h
//  JDJR_Utils
//
//  Created by ixf on 2018/6/26.
//

#import <Foundation/Foundation.h>

@interface JDJR_FileUtil : NSObject
#pragma mark - 沙盒目录相关
// 沙盒的主目录路径
+ (NSString *)homeDir;
// 沙盒中Documents的目录路径
+ (NSString *)documentsDir;

@end
