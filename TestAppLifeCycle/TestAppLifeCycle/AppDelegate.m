//
//  AppDelegate.m
//  TestAppLifeCycle
//
//  Created by niuyulong on 2019/6/5.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "AppDelegate.h"
#import "BLStopwatch.h"
#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>
@property(nonatomic, strong) BLStopwatch *timer;
@end

@implementation AppDelegate
- (BLStopwatch *)timer {
    if (!_timer) {
        _timer = [BLStopwatch sharedStopwatch];
    }
    return _timer;
}


- (void)operateImgAnimation {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timer splitWithDescription:@"冷启动优化结束"];
        [self.timer stop];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"冷启动优化" message:self.timer.prettyPrintedSplits preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancleAction];
        [self.window.rootViewController presentViewController:alert animated:NO
                                                   completion:nil];
    });
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    self.window.rootViewController = vc;
//    [vc.view layoutIfNeeded];
    
    [self.timer splitWithDescription:@"冷启动优化 didFinishLaunchingWithOptions"];
    [self operateImgAnimation];
//    [self.window makeKeyAndVisible];
    
    
    
    [self registerNotification];
    return YES;
}


- (void)registerNotification {
    
    //1.创建消息上面要添加的动作(按钮的形式显示出来)
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"action";//按钮的标示
    action.title = @"Accept";//按钮的标题
    action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"action2";
    action2.title = @"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action.destructive = YES;
    //2.创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";//这组动作的唯一标示,推送通知的时候也是根据这个来区分
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    //向用户请求打开权限
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //返回通知权限状态
            //                NSLog(@"注册成功");
            
            if ([NSThread currentThread]!=[NSThread mainThread]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    //注册远端消息通知获取device token
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            }];
        } else {
            // 点击不允许
            NSLog(@"注册失败");
        }
    }];
        
        [center setNotificationCategories:[NSSet setWithObjects:categorys, nil]];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [self.timer splitWithDescription:@"冷启动优化 openURL"];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
    [self.timer splitWithDescription:@"冷启动优化 applicationDidBecomeActive"];
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
    NSLog(@"%s",__func__);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber = 0;
    [self.timer splitWithDescription:@"冷启动优化 didReceiveLocalNotification"];
    [[[UIAlertView alloc] initWithTitle:@"收到通知"
                                message:notification.alertBody
                               delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}


#pragma mark - UNUserNotificationCenterDelegate
//App处于前台接收通知时  下面这个代理方法，只会是app处于前台状态 前台状态 and 前台状态下才会走，后台模式下是不会走这里的
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
     NSLog(@"%s",__func__);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//App通知的点击事件 下面这个代理方法，只会是用户点击消息才会触发，如果使用户长按（3DTouch）、Action等并不会触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSLog(@"%s",__func__);
    completionHandler(); // 系统要求执行这个方法
}
@end
