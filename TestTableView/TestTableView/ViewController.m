//
//  ViewController.m
//  TestTableView
//
//  Created by niuyulong on 2019/5/20.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, assign) BOOL displayedCells;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 64, 320, 450);
    [self.view addSubview:self.tableView];
    
    //添加观察者
//    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//
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

    
    [self.tableView reloadData];

    //添加观察者
    // [p addObserver:self forKeyPath:@"dog" options:NSKeyValueObservingOptionNew context:nil];

    // 所观察的对象的keyPath 发生改变的时候, 会触发

        
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    NSLog(@"%@",keyPath);
//    NSLog(@"%@",change);
//}

- (void)viewWillLayoutSubviews {
//    self.tableView.frame = self.view.bounds;
}
#pragma mark └ UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%s",__func__);
}

#pragma mark └ UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
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
}
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView = tableView;
    }
    return _tableView;
    
}


@end
