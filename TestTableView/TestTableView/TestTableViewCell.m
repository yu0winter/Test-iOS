//
//  TestTableViewCell.m
//  TestTableView
//
//  Created by niuyulong on 2019/6/6.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell
#pragma mark - Life Cycle 生命周期
#pragma mark └ Dealloc
// - (void)dealloc { }
#pragma mark └ Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%s",__func__);
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"%s, \n object:%@",__func__,self);
    }
    return self;
}
- (void)commonInit {
    NSLog(@"%s",__func__);
}
#pragma mark - Public Method 公用方法
- (void)configureWithInfo:(id)info {
    NSLog(@"%s",__func__);
}
#pragma mark - Event Response 事件响应
#pragma mark - Delegate Realization 委托实现
#pragma mark - Helper Method 帮助方法
#pragma mark - Custom Accessors 自定义属性
@end
