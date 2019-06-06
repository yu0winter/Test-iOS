//
//  ViewController.m
//  TestViewShowArea
//
//  Created by niuyulong on 2018/10/11.
//  Copyright © 2018年 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 40)];
    view.backgroundColor= [UIColor redColor];
    self.textField.inputAccessoryView = view;
    return;
}

@end
