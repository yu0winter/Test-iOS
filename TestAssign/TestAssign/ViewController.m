//
//  ViewController.m
//  TestSharedInstance
//
//  Created by niuyulong on 2019/9/11.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "TestManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
TestManager *ss =    [[TestManager alloc] init];
    for (int i =0;i < 3; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            TestManager *manger = [TestManager sharedInstance];
        });
    }
  // 此处打断点。后主动触发内存警告。可以观察到由于assign修饰对象引发的崩溃
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",ss.shownHistory.count);
    });
}


@end
