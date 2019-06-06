//
//  ViewController.m
//  TestAppLifeCycle
//
//  Created by niuyulong on 2019/6/5.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [switchBtn addTarget:self action:@selector(turn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchBtn];
    
}


- (void)turn:(UISwitch *)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    if (sender.on)
    {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication]registerUserNotificationSettings:
             [UIUserNotificationSettings settingsForTypes:
              UIUserNotificationTypeAlert |
              UIUserNotificationTypeBadge |
              UIUserNotificationTypeSound categories:nil]];
        }
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = kCFCalendarUnitDay;
        notification.soundName = @".mp3";
        notification.alertTitle = @"镇魂街";
        notification.alertBody = @"好几天没登陆了";
        notification.applicationIconBadgeNumber = 1;
        
        NSDictionary *info = @{@"lz":@"key"};
        notification.userInfo = info;
        
        [app scheduleLocalNotification:notification];
    }
    else
    {
        NSArray *localArray = [app scheduledLocalNotifications];
        if (localArray)
        {
            for (UILocalNotification *noti in localArray)
            {
                NSDictionary *dict = noti.userInfo;
                if (dict)
                {
                    // 如果找到要取消的通知
                    NSString *inKey = [dict objectForKey:@"lz"];
                    if ([inKey isEqualToString:@"lz"])
                    {
                        // 取消调度该通知
                        [app cancelLocalNotification:noti];  // ②
                    }
                }
            }
        }
    }
}

@end
