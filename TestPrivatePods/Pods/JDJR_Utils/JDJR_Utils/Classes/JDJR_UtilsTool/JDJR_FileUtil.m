//
//  JDJR_FileUtil.m
//  JDJR_Utils
//
//  Created by ixf on 2018/6/26.
//

#import "JDJR_FileUtil.h"

@interface JDJR_FileUtil ()

@property (strong, nonatomic) NSFileManager *manager;

@end

@implementation JDJR_FileUtil

#pragma mark - 沙盒目录相关
+ (NSString *)homeDir {
    return NSHomeDirectory();
}

+ (NSString *)documentsDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryDir {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];;
}

@end

