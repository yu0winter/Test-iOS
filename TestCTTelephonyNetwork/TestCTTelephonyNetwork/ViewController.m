//
//  ViewController.m
//  TestCTTelephonyNetwork
//
//  Created by niuyulong on 2019/4/11.
//  Copyright © 2019 nyl. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import "OpenUDID.h"
#import <AdSupport/AdSupport.h>
#import "UIDevice+FCUUID.h"


@interface ViewController ()
@property(nonatomic, strong) CTTelephonyNetworkInfo *info;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testUDID];
    [self testA];
    [self testA1];
    [self testA2];
    [self testA3];
    [self testB];
    [self testB1];
    [self testB2];
    [self testB3];
}
- (void)testUDID {
// 同一App开发者在同一台手机上所有App共享的唯一标志
NSUUID *idForVendor = [[UIDevice currentDevice] identifierForVendor];
NSLog(@"identifierForVendor:%@",[idForVendor UUIDString]);

CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
NSLog(@"CFUUID:%@",cfuuidString);

NSString *nsuuid = [[NSUUID UUID] UUIDString];
NSLog(@"NSUUID:%@",nsuuid);

// 同一设备不同程序间，通过粘贴板共用一份。但当所有包含OpenUDID的程序删除后。下次得到的是新的值
NSString *openUDID = [OpenUDID value];
NSLog(@"OpenUDID:%@",openUDID);

// 设备固定，重置手机会重置
NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
NSLog(@"IDFA:%@",adId);
}

- (void)testA {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    info = nil;
    carrier = nil;
}

- (void)testA1 {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    info = nil;
    carrier = nil;
}
- (void)testA2 {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    info = nil;
    carrier = nil;
}

- (void)testA3 {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    info = nil;
    carrier = nil;
}

- (void)testB {
    CTTelephonyNetworkInfo *info = self.info?:[[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    self.info = info;
    carrier = nil;
}
- (void)testB1 {
    CTTelephonyNetworkInfo *info = self.info?:[[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    self.info = info;
    carrier = nil;
}
- (void)testB2 {
    CTTelephonyNetworkInfo *info = self.info?:[[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    self.info = info;
    carrier = nil;
}
- (void)testB3 {
    CTTelephonyNetworkInfo *info = self.info?:[[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    self.info = info;
    carrier = nil;
}

@end
