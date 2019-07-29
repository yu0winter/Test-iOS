//
//  ViewController.m
//  TestOpenUDID
//
//  Created by niuyulong on 2019/4/22.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import "OpenUDID.h"
#import <AdSupport/AdSupport.h>
#import "UIDevice+FCUUID.h"
#import "BLStopwatch.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //  A1B2E7B4-30D3-4C7A-B429-A886BD23F5AF
    // 同一App开发者在同一台手机上所有App共享的唯一标志
    

}

- (void)viewDidAppear:(BOOL)animated {
    [self testUDID];
}
- (void)testUDID {
    
    BLStopwatch *watch = [BLStopwatch sharedStopwatch];
    [watch start];
    
    NSUUID *idForVendor = [[UIDevice currentDevice] identifierForVendor];
    [watch splitWithDescription:[NSString stringWithFormat:@"identifierForVendor:%@",[idForVendor UUIDString]]];
//    NSLog(@"identifierForVendor:%@",[idForVendor UUIDString]);
    
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    [watch splitWithDescription:[NSString stringWithFormat:@"CFUUID:%@",cfuuidString]];
//    NSLog(@"CFUUID:%@",cfuuidString);
    
    NSString *nsuuid = [[NSUUID UUID] UUIDString];
    [watch splitWithDescription:[NSString stringWithFormat:@"NSUUID:%@",nsuuid]];
//    NSLog(@"NSUUID:%@",nsuuid);
    
    // 同一设备不同程序间，通过粘贴板共用一份。但当所有包含OpenUDID的程序删除后。下次得到的是新的值
    NSString *openUDID = [OpenUDID value];
    [watch splitWithDescription:[NSString stringWithFormat:@"OpenUDID:%@\n同一Team开发的App，通过粘贴板共享唯一标志",openUDID]];
//    NSLog(@"OpenUDID:%@",openUDID);
    
    // 设备固定，重置手机会重置
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [watch splitWithDescription:[NSString stringWithFormat:@"IDFA:%@",adId]];
//    NSLog(@"IDFA:%@",adId);
    
    NSString *fcUUID = [[UIDevice currentDevice] uuid];
    [watch splitWithDescription:[NSString stringWithFormat:@"FFUUID:%@",fcUUID]];
//    NSLog(@"FFUUID:%@",fcUUID);
    
    
    [watch stop];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *allTime =  [NSString stringWithFormat:@"%@\n%@  \n持续时间：%.3fs",[NSBundle mainBundle].bundleIdentifier,watch.prettyPrintedSplits,watch.elapseTimeInterval];
        self.textView.text =allTime;
    });
    
    
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:allTime preferredStyle:UIAlertControllerStyleAlert];
//    [self presentViewController:alertC animated:YES completion:nil];

}

@end
