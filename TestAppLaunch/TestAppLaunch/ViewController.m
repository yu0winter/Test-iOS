//
//  ViewController.m
//  TestAppLaunch
//
//  Created by niuyulong on 2019/4/9.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init");
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"viewDidLoad");
}


@end
