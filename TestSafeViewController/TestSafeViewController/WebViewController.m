//
//  WebViewController.m
//  TestSafeViewController
//
//  Created by NiuYulong on 2018/4/27.
//  Copyright © 2018年 NiuYulong. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()
@property(strong,nonatomic) NSURL *url;
@property(strong,nonatomic) WKWebView *webView;
@end

@implementation WebViewController
- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WKWebView *wkview = [[WKWebView alloc] init];
    [self.view addSubview:wkview];
    self.webView = wkview;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.url];
    [self.webView loadRequest:request];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
    
}
@end
