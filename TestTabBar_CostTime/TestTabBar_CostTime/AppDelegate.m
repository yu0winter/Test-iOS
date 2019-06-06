//
//  AppDelegate.m
//  TestTabBar_CostTime
//
//  Created by niuyulong on 2019/5/24.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    nyl.TestTabBar-CostTime
    UITabBarController *tabController = [[UITabBarController alloc] init];

    for (int i = 0; i < 3 ; i++) {
        ViewController *vc = [[ViewController alloc] init];
        vc.title = @(i).stringValue;
        vc.view.backgroundColor = [UIColor colorWithWhite:0  alpha:(i/5)];
        [tabController addChildViewController:vc];
    }
    
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:tabController];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = naviController;
    [self.window makeKeyAndVisible];
    
    
    for (int i = 0; i < tabController.viewControllers.count ; i++) {
        UIViewController * viewCon = [tabController.viewControllers objectAtIndex:i];
        
        viewCon.tabBarItem.title =  @(i).stringValue;
        
        viewCon.tabBarItem.image =  [[UIImage imageNamed:[NSString stringWithFormat:@"%@",@(i).stringValue]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewCon.tabBarItem.selectedImage =  [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",@(i).stringValue]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [viewCon.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
        [viewCon.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
        
        if (i%2==0)
        {
            viewCon.tabBarItem.imageInsets = UIEdgeInsetsMake(-2,0,2,0);
            viewCon.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
        }
        else
        {
            viewCon.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0);
            viewCon.tabBarItem.titlePositionAdjustment  = UIOffsetZero;
        }
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
