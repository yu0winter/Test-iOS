//
//  ViewController.m
//  TestCollectionView
//
//  Created by niuyulong on 2019/7/22.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

#define UIScreen_W CGRectGetWidth([[UIScreen mainScreen] bounds])
#define UIScreen_H CGRectGetHeight([[UIScreen mainScreen] bounds])


static NSString const *kCellReuseId = @"Cell";
@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *dataArray;
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
    self.collectionView.frame = CGRectMake(0, 150, 320, 450);
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    
    self.dataArray = @[@1,@2,@3,@4,@5,@1,@2,@3,@4,@5];
    [self.collectionView reloadData];
    
}
#pragma mark - Event Response 事件响应

- (IBAction)btn1OnClick:(id)sender {
    // 不崩溃
    self.dataArray = @[];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        NSLog(@"reloadData 执行完成");
    }];
    [self.collectionView reloadData];
    [CATransaction commit];
}

- (IBAction)btn2OnClick:(id)sender {
    // 不崩溃
    self.dataArray = @[@1,@2,@3,@4,@5,@6,@7,@8];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        NSLog(@"btn2OnClick");
    }];
    [self.collectionView reloadData];
    [CATransaction commit];
}

- (IBAction)btn3OnClick:(id)sender {
    // numberOfSection，要求执行前执行后保持一致，否则崩溃
    self.dataArray = @[];

    [self.collectionView performBatchUpdates:^{
        NSLog(@"");
    } completion:^(BOOL finished) {
        NSLog(@"btn3OnClick");
    }];
}

- (IBAction)btn4OnClick:(id)sender {
    // 不崩溃
    self.dataArray = @[@1,@2];
    [self.collectionView reloadData];
    [self.collectionView performBatchUpdates:^{
        NSLog(@"");
    } completion:^(BOOL finished) {
        NSLog(@"btn4OnClick");
    }];
}

#pragma mark - Delegate Realization 委托方法
#pragma mark └ UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseId forIndexPath:indexPath];
    
    cell.backgroundColor = [self consistentRandomColorForObject:self.dataArray[indexPath.row]];
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
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(floor((UIScreen_W - 20*4)/3.f) ,75);//20 为两侧加中间间隔 共四个 75 包括15的顶部距离+60的方框
        flowLayout.minimumInteritemSpacing = 20.0f;//间隔
        flowLayout.minimumLineSpacing = 5.0f;
        flowLayout.sectionInset = UIEdgeInsetsMake(0.f, 20, 0, 20);
        flowLayout.headerReferenceSize = CGSizeMake(UIScreen_W, 43.f);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,88.f, UIScreen_W,75) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellReuseId];
    }
    
    return _collectionView;
}


@end
