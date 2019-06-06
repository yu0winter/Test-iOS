//
//  TestViewController.m
//  TestViewShowArea
//
//  Created by niuyulong on 2018/10/15.
//  Copyright © 2018年 nyl. All rights reserved.
//

#import "TestViewController.h"
#import "UIView+YuDisplay.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width;
#define screenHeight [UIScreen mainScreen].bounds.size.height;

//打印日志
#ifndef __OPTIMIZE__

#define NSLog(format, ...) {\
NSString *file = [[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent];\
NSString *printString = [NSString stringWithFormat:@"%s【--%@：%d--】 %@",__TIME__, file, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__]];\
printf("%s\n", [printString UTF8String]);\
}

#else
#define NSLog(format, ...)
#endif


@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *hiddenLabel;
@property (weak, nonatomic) IBOutlet UILabel *nosuperViewLabel;
@property(nonatomic, strong) NSArray *views;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.hiddenLabel.hidden = YES;
    [self.nosuperViewLabel removeFromSuperview];
    
    self.views = @[self.label1,self.label2,self.label3,self.hiddenLabel,self.nosuperViewLabel];
//    CGRect rect = [self.view convertRect:self.label1.bounds fromView:self.label1];
////    CGRect rect2 = [self.label1 convertRect:self.label1.frame toView:self.view];
//    CGRect rect3 = [self.label1 convertRect:self.label1.bounds toView:self.view];
    
//    CGRect rect = [view convertRect:self.bounds fromView:self];
//    CGRect rect2 = [self convertRect:self.frame toView:view];
    
//    [self testWindowOfSubView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self testWindowOfSubView];
}

- (void)testWindowOfSubView {
    for ( int i = 0; i < self.views.count; i++) {
        UIView *view = self.views[i];
//        NSLog(@"判断View是否显示在屏幕上%@",@([view isDisplayedInScreen]));
        NSLog(@"是否展示：%d，是否展示:%d,展示比例:%.2f",[view yu_isDisplayedInKeyWindow]
              ,[view yu_isDisplayedInView:self.view],[view yu_displayedPrecentInView:self.view]);
        NSLog(@"view.window=%@",view.window);
    }
    
    NSLog(@"[self.label1 locationInView:self.label2]:%@",NSStringFromCGRect([self.label1 yu_locationInView:self.label2]));
    
    NSLog(@"[self.label1 locationInView:self.label3]:%@",NSStringFromCGRect([self.label1 yu_locationInView:self.label3]));
    
    NSLog(@"[self.label1 locationInView:self.hiddenLabel]:%@",NSStringFromCGRect([self.label1 yu_locationInView:self.hiddenLabel]));
    NSLog(@"[self.label1 locationInView:self.nosuperViewLabel]:%@",NSStringFromCGRect([self.label1 yu_locationInView:self.nosuperViewLabel]));
    
}

- (void)testNosuperViewLabel {
    
    UIView *view = [UIView new];
    
    UILabel *label = self.nosuperViewLabel;
    [view addSubview:label];
    [label yu_isDisplayedInView:nil];
//    NSLog(@"nosuperViewLabel:是否展示：%d",[label isDisplayedInView:nil]);
    NSLog(@"nosuperViewLabel:是否展示：%d，是否展示:%d",[label yu_isDisplayedInView:nil]
          ,[label yu_isDisplayedInView:nil]);
}
    
//
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//
//    // 无父视图
//    //    BOOL b1 = [v isDisplayedInScreen];
//    //    NSLog(@"b1: %d", b1);
//    //
//    [self.view addSubview:v];
//    //
//    //    BOOL b2 = [v isDisplayedInScreen];
//    //    NSLog(@"b2: %d", b2);
//    //
//    //
//    //    v.frame = CGRectZero;
//    //    BOOL b3 = [v isDisplayedInScreen];
//    //    NSLog(@"b3: %d", b3);
//    //
//
//
//    v.frame = CGRectMake(0, 0, 40, 40);
//
//    NSLog(@"b4:是否展示：%d，展示比例:%.2f",[v isDisplayedInView:nil],[v displayedPrecentInView:nil]);
//
//    NSLog(@"b4:是否展示：%d，展示比例:%.2f",[v isDisplayedInView:self.view],[v displayedPrecentInView:self.view]);
//
//        BOOL b4 = [v isDisplayedInScreen];
//        NSLog(@"b4: %d", b4);
@end
