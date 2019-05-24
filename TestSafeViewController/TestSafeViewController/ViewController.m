//
//  ViewController.m
//  TestSafeViewController
//
//  Created by NiuYulong on 2018/4/27.
//  Copyright © 2018年 NiuYulong. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#import "WebViewController.h"


@interface ViewController ()
@property(nonatomic,strong) NSURL *url;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = [NSURL URLWithString:@"https://yu0winter.github.io"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)firstBtnOnClick:(id)sender {
    
    WebViewController *vc = [[WebViewController alloc] initWithURL:self.url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnOnClick:(id)sender {
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:self.url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
