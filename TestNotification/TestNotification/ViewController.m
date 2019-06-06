//
//  ViewController.m
//  TestNotification
//
//  Created by niuyulong on 2019/5/24.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"当前线程为%@", [NSThread currentThread]);
    
    // 监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"Test_Notification" object:nil];
    // 主线程监听
    [[NSNotificationCenter defaultCenter] addObserverForName:@"Test_Notification" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [self handleNotificationOnMainQueue:note];
    }];
//    addObserver:self selector:@selector(handleNotificationOnMainQueue:) name:@"Test_Notification" object:nil
    
    
    // 异步线程，发送通知
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"发送通知的线程为%@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Test_Notification" object:nil userInfo:nil];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"sleep1");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"sleep2");
        [NSThread sleepForTimeInterval:1];
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"sleep3");
        [NSThread sleepForTimeInterval:1];
    });
}

- (void)handleNotification: (NSNotification *)notification {
    NSLog(@"转发通知的线程%@\n%s ", [NSThread currentThread],__func__);
}

- (void)handleNotificationOnMainQueue: (NSNotification *)notification {
    NSLog(@"转发通知的线程%@\n%s ", [NSThread currentThread],__func__);
}

@end
