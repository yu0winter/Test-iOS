//
//  ViewController.m
//  TestFontSizeAnimation
//
//  Created by niuyulong on 2018/10/12.
//  Copyright © 2018年 nyl. All rights reserved.
//

#import "ViewController.h"

/*
 
 文字位置及字体大小发生变化。
 需要手动核心动画 CABasicAnimation
 不能嵌套使用[UIView animateWithDuration:0 animations:nil]方法
 操纵的是Layer。
 需要手动计算动画后位置
 
 存在问题。如何读取动画后layer的位置信息。
 */
@interface ViewController () <CAAnimationDelegate>
{
    UILabel *testLabel;
    UIButton *button;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 20, 100, 40);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self addResult];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 40)];
    label.font = [UIFont systemFontOfSize:10];
    label.text = @"动画已经准备好";
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    testLabel = label;
    
 
}

- (void)buttonClick
{
    [self changeScaleAndPosition];
}

- (void)addResult {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 80)];
    
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"1231231";
    label.backgroundColor = [UIColor blueColor];
    label.textColor = [UIColor redColor];
    
    label.center = CGPointMake(300, 300);
    [self.view addSubview:label];
}
- (void)changeScaleAndPosition {

    CGFloat scale = 2;
    //相当与两个动画  合成
    //位置改变
    CABasicAnimation * aniMove = [CABasicAnimation animationWithKeyPath:@"position"];
    aniMove.fromValue = [NSValue valueWithCGPoint:testLabel.layer.position];
    aniMove.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    //大小改变
    CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    aniScale.fromValue = [NSNumber numberWithFloat:1.0];
    aniScale.toValue = [NSNumber numberWithFloat:scale];
    
    CAAnimationGroup * aniGroup = [CAAnimationGroup animation];
    aniGroup.duration = 3.0;//设置动画持续时间
    aniGroup.repeatCount = 1;//设置动画执行次数
    aniGroup.delegate = self;
    aniGroup.animations = @[aniMove,aniScale];
    aniGroup.removedOnCompletion = NO;
    aniGroup.fillMode = kCAFillModeForwards;  //防止动画结束后回到原位
    [testLabel.layer addAnimation:aniGroup forKey:@"aniMove_aniScale_groupAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [testLabel.layer removeAllAnimations];
    testLabel.font = [UIFont systemFontOfSize:20];
    testLabel.frame = CGRectMake(0, 0, 200, 80);
    testLabel.center = CGPointMake(300, 300);
    
}
@end
