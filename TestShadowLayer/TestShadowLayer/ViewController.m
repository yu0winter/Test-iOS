//
//  ViewController.m
//  TestShadowLayer
//
//  Created by niuyulong on 2019/7/16.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Extend.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 200, 54)];
    [self.view addSubview:view];
    
    
    view.backgroundColor = [UIColor orangeColor];
    view.layer.shadowColor = [UIColor jrColorWithHex:@"#0F4B2815"].CGColor;
    view.layer.shadowRadius = 3;
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowOpacity = 1;
    
}


@end
