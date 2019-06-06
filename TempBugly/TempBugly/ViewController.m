//
//  ViewController.m
//  TempBugly
//
//  Created by niuyulong on 2019/5/9.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSArray *creditCardList;
@property(nonatomic, strong) UITableView *tableView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"0";
    NSArray *array = @[str,@1,@2];
    
    NSMutableArray *m = [NSMutableArray arrayWithArray:array];
    
    NSArray *aa = [[NSArray alloc] initWithObjects:nil ,@2, nil];
    
    str = nil;
    
    NSMutableArray *m2 = [NSMutableArray arrayWithArray:array];
    
    for (NSObject *object in m2) {
        NSLog(@"%@",object);
    }
    
    
    NSArray *aa2 = @[str ];
    self.creditCardList = @[@1];
    
    if(!self.creditCardList || !self.creditCardList.count){
        return;
    }
    
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.creditCardList];
//    if(mArray.count > indexPath.row){
        [mArray removeObjectAtIndex:0];
        self.creditCardList = mArray;
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
}


@end
