//
//  ViewController.m
//  TestDispatchAfter
//
//  Created by niuyulong on 2019/3/15.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "YYFPSLabel.h"


@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) YYFPSLabel *fpsLabel;


@end

@implementation ViewController
#pragma mark - Life Cycle 生命周期
#pragma mark └ Dealloc
// - (void)dealloc {}
#pragma mark └ Init
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
}
#pragma mark - Event Response 事件响应
- (IBAction)refreshBtnOnClick:(id)sender {
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

- (IBAction)buttonOnClick:(id)sender {
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i<100*5; i++) {
            NSLog(@"dddddd");
        }
    });
    
    
}

- (IBAction)after3s:(id)sender {
    
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i<100*5; i++) {
            NSLog(@"dddddd");
        }
    });
}
#pragma mark - Delegate Realization 委托方法
#pragma mark └ UITableViewDelegate

#pragma mark └ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.contentView.backgroundColor = [UIColor grayColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    
    // 60帧。1帧约等于 0.017s,一屏幕显示13行。即 13帧
    for (int i = 0; i<100; i++) {
        NSLog(@"dddddd");
    }
    
    return cell;
}
#pragma mark - Custom Method    自定义方法
#pragma mark - Custom Accessors 自定义属性

@end
