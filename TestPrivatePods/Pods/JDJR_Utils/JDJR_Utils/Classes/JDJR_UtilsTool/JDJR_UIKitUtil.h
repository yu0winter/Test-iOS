//
//  JDJR_UIKitUtil.h
//  JDJR_Utils
//
//  Created by ixf on 2018/6/20.
//

#import <UIKit/UIKit.h>


@interface JDJR_UIKitUtil : NSObject

/**
 获取当前最上层的控制器
 
 @return 返当前最上层的控制器
 */
+(UIViewController *) getTopVc;

/**
 返回当前 Normal windows
 
 @return  返回当前 Normal windows
 */
+(UIWindow *) returnWindowWithWindowLevelNormal;

@end
