//
//  ViewController.m
//  TestLoadMethod
//
//  Created by niuyulong on 2019/5/10.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "ObjectA.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ObjectA *object =  [[ObjectA alloc] init];
    
    [object reloadData];
 
    self.view.backgroundColor = [UIColor redColor];
}


@end
