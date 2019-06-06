//
//  ViewController.m
//  TestWebView_CostTime
//
//  Created by niuyulong on 2019/5/27.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test_webViewInitWithFrame];
    [self test_webViewInitWithCGRectZero];
    [self test_webViewInit];
}

- (void)test_webViewInitWithFrame {
    UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
}

- (void)test_webViewInitWithCGRectZero {
    
    
    UIWebView *view = [[UIWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
}

- (void)test_webViewInit {
    UIWebView *view = [[UIWebView alloc] init];
    [self.view addSubview:view];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor orangeColor];
}
@end
