//
//  ViewController.m
//  TestImage
//
//  Created by niuyulong on 2019/7/10.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageWithContentsOfFile:@"/Users/niuyulong/Desktop/Code/Test/TestImage/TestImage/HC_centerSlider_Refresh@2x.png"];
    
    self.imageView1.image = image;
    self.imageView2.image = image;
    self.imageView3.image = image;
    
}


@end
