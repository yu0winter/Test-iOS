//
//  ViewController.m
//  TestViewLoadAndWillAppear
//
//  Created by niuyulong on 2019/5/14.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "TestViewDidLoadViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)showViewDidLoad:(id)sender {
    
    for (int i=0; i< 10; i++) {
        
    
    TestViewDidLoadViewController *vc1 = [[TestViewDidLoadViewController alloc] init];
//    [self.navigationController pushViewController:vc1 animated:YES];
    }
//    TestViewDidLoadViewController *vc2 = [[TestViewDidLoadViewController alloc] init];
//    [self.navigationController presentViewController:vc2 animated:YES completion:^{
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"‼️‼️%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"‼️‼️%s",__func__);
}

@end
