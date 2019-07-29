//
//  ViewController.m
//  TestFontCostTime
//
//  Created by niuyulong on 2019/6/25.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIFont *font  =  [UIFont fontWithName:@"SFUIDisplay-Thin" size:12];
    font  =  [UIFont fontWithName:@"SFUIDisplay-Thin" size:15];
    font  =  [UIFont fontWithName:@"SFUIDisplay-Thin" size:13];
    
    self.label.font = font;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.label];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIFont *font  =  [UIFont fontWithName:@"SFUIDisplay-Thin" size:20];
    self.label.font = font;
}


- (UILabel *)label {
    return _label = _label?:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 100)];
        label.textColor = [UIColor orangeColor];
        label.text = @"建档立卡计算宽度1213aaa";
        label;
    });
}

/*
 
 空白应用
 Total pre-main time:  69.31 milliseconds (100.0%)
 dylib loading time:  20.17 milliseconds (29.1%)
 rebase/binding time:  14.46 milliseconds (20.8%)
 ObjC setup time:   6.81 milliseconds (9.8%)
 initializer time:  27.75 milliseconds (40.0%)
 slowest intializers :
 libSystem.B.dylib :  13.65 milliseconds (19.6%)
 libBacktraceRecording.dylib :  10.58 milliseconds (15.2%)

 加载所有字体
 Total pre-main time: 164.60 milliseconds (100.0%)
 dylib loading time: 124.44 milliseconds (75.6%)
 rebase/binding time:   9.46 milliseconds (5.7%)
 ObjC setup time:   7.06 milliseconds (4.2%)
 initializer time:  23.52 milliseconds (14.2%)
 slowest intializers :
 libSystem.B.dylib :  10.04 milliseconds (6.0%)
 libBacktraceRecording.dylib :  10.15 milliseconds (6.1%)
 
 
 加载字体——兰亭黑简
 Total pre-main time: 164.60 milliseconds (100.0%)
 dylib loading time: 124.44 milliseconds (75.6%)
 rebase/binding time:   9.46 milliseconds (5.7%)
 ObjC setup time:   7.06 milliseconds (4.2%)
 initializer time:  23.52 milliseconds (14.2%)
 slowest intializers :
 libSystem.B.dylib :  10.04 milliseconds (6.0%)
 libBacktraceRecording.dylib :  10.15 milliseconds (6.1%)
 
 */

@end
