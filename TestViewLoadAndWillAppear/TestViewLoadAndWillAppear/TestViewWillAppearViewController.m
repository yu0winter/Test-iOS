//
//  TestViewWillAppearViewController.m
//  TestViewLoadAndWillAppear
//
//  Created by niuyulong on 2019/5/14.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "TestViewWillAppearViewController.h"

@interface TestViewWillAppearViewController ()

@end

@implementation TestViewWillAppearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i=0; i<5000; i++) {
            NSLog(@"viewWillAppear");
        }
    });
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    for (int i=0; i<5000; i++) {
//        NSLog(@"viewDidAppear");
//    }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
