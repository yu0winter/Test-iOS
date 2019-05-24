//
//  JDJR_UIKitUtil.m
//  JDJR_Utils
//
//  Created by ixf on 2018/6/20.
//

#import "JDJR_UIKitUtil.h"

@implementation JDJR_UIKitUtil

/**
 获取当前最上层的控制器
 
 @return 返当前最上层的控制器
 */
+(UIViewController *) getTopVc
{
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        topWindow = [self returnWindowWithWindowLevelNormal];
    }
    
    UIViewController *topController = topWindow.rootViewController;
    if(topController == nil)
    {
        topWindow = [UIApplication sharedApplication].delegate.window;
        if (topWindow.windowLevel != UIWindowLevelNormal)
        {
            topWindow = [self returnWindowWithWindowLevelNormal];
        }
        topController = topWindow.rootViewController;
    }
    
    while(topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    if([topController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController*)topController;
        topController = [nav.viewControllers lastObject];
        
        while(topController.presentedViewController)
        {
            topController = topController.presentedViewController;
        }
    }
    
    return topController;
}


/**
 返回当前 Normal windows
 
 @return  返回当前 Normal windows
 */
+(UIWindow *) returnWindowWithWindowLevelNormal
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *topWindow in windows)
    {
        if (topWindow.windowLevel == UIWindowLevelNormal)
            return topWindow;
    }
    return [UIApplication sharedApplication].keyWindow;
}
@end
