//
//  ViewController.m
//  TestTableView
//
//  Created by niuyulong on 2019/5/20.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"
#import "UIView+YuViewDisplayArea.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) BOOL displayedCells;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 100, 320, 450);
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    //添加观察者
    
     [self.tableView.tableFooterView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
//    [self.tableView addObserver:self forKeyPath:@"visibleCells" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
////
//
//    [self.tableView performBatchUpdates:^{
//
//        [self.tableView reloadData];
//
//        NSLog(@"reloadData");
//    } completion:^(BOOL finished) {
//        NSLog(@"visibleCells");
//        NSArray *array = [self.tableView visibleCells];
//
//        NSLog(@"");
//    }];
    self.dataArray = @[@1,@2,@3,@4,@5,@1,@2,@3,@4,@5];
    [self.tableView reloadData];
    

    //添加观察者
    // [p addObserver:self forKeyPath:@"dog" options:NSKeyValueObservingOptionNew context:nil];

    // 所观察的对象的keyPath 发生改变的时候, 会触发

        
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
    NSLog(@"%s %@",__func__,keyPath);
    if ([self.tableView.tableFooterView yu_isDisplayedInView:self.tableView]) {
        NSLog(@"***footerView 展示了");
    }
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
    if ([self.tableView.tableFooterView yu_isDisplayedInView:self.tableView]) {
        NSLog(@"footerView 展示了");
    }
}
- (void)viewWillLayoutSubviews {
//    self.tableView.frame = self.view.bounds;
}
#pragma mark └ UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%s",__func__);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"%s",__func__);
}

#pragma mark - Event

- (IBAction)btn1OnClick:(id)sender {
    // 不崩溃
    self.dataArray = @[];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        NSLog(@"reloadData 执行完成");
    }];
    [self.tableView reloadData];
    [CATransaction commit];
}

- (IBAction)btn2OnClick:(id)sender {
    // 不崩溃
    self.dataArray = @[@1,@2,@3,@4,@5,@6,@7,@8];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        NSLog(@"btn2OnClick");
    }];
    [self.tableView reloadData];
    [CATransaction commit];
}

- (IBAction)btn3OnClick:(id)sender {
    // numberOfSection，要求执行前执行后保持一致，否则崩溃
    self.dataArray = @[];
    [self.tableView performBatchUpdates:^{
        
    } completion:^(BOOL finished) {
        NSLog(@"btn3OnClick");
    }];
}

- (IBAction)btn4OnClick:(id)sender {
    // numberOfSection，要求执行前执行后保持一致，否则崩溃
    self.dataArray = @[@1,@2];
    [self.tableView performBatchUpdates:^{
    } completion:^(BOOL finished) {
        NSLog(@"btn4OnClick");
    }];
}

#pragma mark └ UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    if(indexPath.row == 19) {
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
}


/**
 该方法，影响了。cellForRowAtIndexPath 需要渲染的个数。可以放大cell高度，但尽量不要减小。

 
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.displayedCells = YES;
    if ([self.tableView.tableFooterView yu_isDisplayedInView:self.tableView]) {
        NSLog(@" %s footerView 展示了",__func__);
    }
    NSLog(@" %s footerView 展示了",__func__);
}
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        tableView.tableFooterView.backgroundColor = [UIColor orangeColor];
        [tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView = tableView;
    }
    return _tableView;
    
}


@end
