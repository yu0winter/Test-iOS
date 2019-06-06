//
//  TestTableViewController.m
//  TestViewShowArea
//
//  Created by niuyulong on 2018/10/15.
//  Copyright © 2018年 nyl. All rights reserved.
//

#import "TestTableViewController.h"
#import "UIView+YuDisplay.h"

@interface TestTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *btn;
@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

- (void)btnOnClick :(id)sender {
    for (UITableViewCell *cell in [self.tableView visibleCells]) {
        CGFloat precent = [cell yu_displayedPrecentInView:self.tableView];
        NSLog(@"cell:%@ display Precnet:%.2f",cell.textLabel.text,precent);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        CGFloat precent = [cell yu_displayedPrecentInView:self.tableView];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",precent];
        [self.view yu_isDisplayedInKeyWindow];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (UITableView *)tableView
{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 675-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}
@end
