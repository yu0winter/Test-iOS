//
//  ViewController.m
//  CheckContentInsetAdjustmentBehavior
//
//  Created by niuyulong on 2019/8/5.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"



#define ViewWidth floor(self.view.frame.size.width / 5.0)
#define ViewHeight (self.view.frame.size.height)
@interface ViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UIView *emptyView;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSArray *viewArray;
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

/*
 
 iOS11.0以下。
 
 -[UIViewController automaticallyAdjustsScrollViewInsets] (iOS7.0引入，11.0废除）
 作用：UINavigationBar与UITabBar默认都是半透明模糊效果，在这种情况下系统会对视图控制器的UI布局进行优化：当视图控制器里面【第一个】被添加进去的视图是UIScrollView或其子类时，系统会自动调整其内边距属性contentInset，以保证滑动视图里的内容不被UINavigationBar与UITabBar遮挡。
 
 备注：可通过修改self.viewArray中视图顺序，并查看contentOffset变化结果来验证。

 */


/*
 
 iOS11.0 以上
 
 1.枚举解读
 UIScrollViewContentInsetAdjustmentBehavior 是一个枚举类型,值有以下几种:
 * automatic 和scrollableAxes一样,scrollView会自动计算和适应顶部和底部的内边距并且在scrollView 不可滚动时,也会设置内边距.
 * scrollableAxes 自动计算内边距.
 * never不计算内边距
 * always 根据safeAreaInsets 计算内边距
 很显然,我们这里要设置为 never
 https://www.jianshu.com/p/1601bd885f83
 
 2.验证结论
 UITableView/UICollectionView 无论是否为Viewd第一个视图。都会响应ContentInsetAdjustmentBehavior配置。
 
 UITextView/UIScrollView 只有为第一个添加的视图时(第一个通过addSubView到VC.view上)时，才会响应ContentInsetAdjustmentBehavior配置。
 
 3.其他
 无Home键的手机，底部会计算34pt的安全间距
 
 */


- (NSArray *)viewArray {
    if (!_viewArray) {
        
        _viewArray = @[
                          self.tableView,
                       self.emptyView,
                       self.scrollView,
                       self.textView,
                       
                    
                       self.collectionView,
                       ];
    }
    return _viewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Title";
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

    [self testHiddenNaviBar];
    
    
    
    NSArray *array = self.viewArray;
    
    for (int i = 0; i < array.count; i++) {
        UIView *view = [array objectAtIndex:i];
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:(i *2 + 1)/10.0];
        // iOS11 以上。使第一个添加的视图，不位于左上角。发现和位置无关。只和第一次添加有关
//        if (i == 0) {
//            view.frame = CGRectMake(ViewWidth * 1, 0, ViewWidth, ViewHeight);
//        }
//        else if (i == 1) {
//            view.frame = CGRectMake(ViewWidth * 0, 0, ViewWidth, ViewHeight);
//        }else {
//            view.frame = CGRectMake(ViewWidth * i, 0, ViewWidth, ViewHeight);
//        }
        
        view.frame = CGRectMake(ViewWidth * i, 0, ViewWidth, ViewHeight);
        [self.view addSubview:view];
    }
    self.viewArray = array;
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSMutableString *result = [NSMutableString string];
    
    NSArray *array = self.viewArray;
    for (int i = 0; i < array.count; i++) {
        UIScrollView *view = [array objectAtIndex:i];
        
        if ([view isKindOfClass:[UIScrollView class]] == NO) {
            continue;
        }
        if (@available(iOS 11.0, *)) {
            [result appendFormat:@"%@.adjustedContentInset = %@\n",[view class],NSStringFromUIEdgeInsets(view.adjustedContentInset)];
        } else {
            [result appendFormat:@"%@.contentOffset = %@\n",[view class],NSStringFromCGPoint(view.contentOffset)];
        }
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:result preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                          }];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)testHiddenNaviBar {
    // 导航栏隐藏时
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // UITableView、UITextView 遮挡状态栏。会被自动向下移动。
//    if (@available(iOS 11.0,*)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
//    }
}

- (void)testHUD {
    
    self.navigationController.navigationBarHidden = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    // ToDo: 测试项1
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.navigationController.navigationBar.translucent = NO;
    
    
}


- (void)test3 {
     self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - TextView
- (UITextView *)textView {
    if (!_textView) {
        UITextView *textView = [[UITextView alloc] init];
        textView.text = @"离得近埃里克森多了付拉克丝江东父老；阿可接受的；法拉跨境电商；法拉会计师；砥砺奋进啊；乐山大佛就看；商量的会计法；阿拉山口戴假发；拉克丝戴假发；了";
        _textView = textView;
    }
    return _textView;
}

#pragma mark - View

- (UIView *)emptyView {
    if (!_emptyView) {
        UIView *view = [[UIView alloc] init];
        _emptyView = view;
    }
    return _emptyView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *view = [[UIScrollView alloc] init];
        _scrollView = view;
    }
    return _scrollView;
}

#pragma mark - UITableView
#pragma mark └ UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = @(indexPath.row).stringValue;
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
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


#pragma mark - UICollectionView
#pragma mark └ UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];//[self consistentRandomColorForObject:self.dataArray[indexPath.row]];
    return cell;
    
}
#pragma mark └ UICollectionViewDelegate


#pragma mark - Custom Method    自定义方法
- (UIColor *)consistentRandomColorForObject:(id)object
{
    CGFloat hue = (((NSUInteger)object >> 4) % 256) / 255.0;
    return [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
}

#pragma mark - Custom Accessors 自定义属性
- (UICollectionView *)collectionView
{
    if(!_collectionView){
        CGFloat width = ViewWidth;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(width-20 ,75);//20 为两侧加中间间隔 共四个 75 包括15的顶部距离+60的方框
        flowLayout.minimumInteritemSpacing = 20.0f;//间隔
        flowLayout.minimumLineSpacing = 5.0f;
        flowLayout.sectionInset = UIEdgeInsetsMake(0.f, 20, 0, 20);
        //        flowLayout.headerReferenceSize = CGSizeMake(UIScreen_W, 43.f);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, width,75) collectionViewLayout:flowLayout];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    
    return _collectionView;
}
@end
