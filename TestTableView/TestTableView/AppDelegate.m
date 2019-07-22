//
//  AppDelegate.m
//  TestTableView
//
//  Created by niuyulong on 2019/5/20.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)lod {
     NSLog(@"%s",__func__);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    for (NSBundle* bundle in [NSBundle allBundles]) {
//        NSString* bundlePath = [bundle pathForResource:podName ofType:@"bundle"];
//        if (bundlePath) { return bundlePath; }
        
        
    }
    
    
    //  // search all frameworks
    for (NSBundle* bundle in [NSBundle allFrameworks]) {
//        NSString* bundlePath = [bundle pathForResource:podName ofType:@"bundle"];
//        if (bundlePath) { return bundlePath; }
    }
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self performSelectorOnMainThread:@selector(lod) withObject:nil waitUntilDone:NO];
//        
//        for (int i = 0; i<1000; i++) {
//            NSLog(@"并发队列 %@",@(i));
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"异步切换到主队列");
//        });
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"同步切换到主队列");
//        });
//    });
//  
//    
//    for (int i = 0; i<10000; i++) {
//        NSLog(@"主线程 %@",@(i));
//    }
    
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
