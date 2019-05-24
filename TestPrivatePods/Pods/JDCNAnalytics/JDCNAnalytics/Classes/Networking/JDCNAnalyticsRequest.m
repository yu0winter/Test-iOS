//
//  JDCNAnalyticsRequest.m
//  Pods
//
//  Created by huaxiaochun on 2018/7/12.
//

#import "JDCNAnalyticsRequest.h"
#import <JDJR_Networking/JDJR_Networking.h>

static NSString * const kRequestJDCNAnalyticsAction = @"/mlog.html";

static NSString * const kRequestJDCNAnalyticsAppIdKey = @"appId";
static NSString * const kRequestJDCNAnalyticsSdkIdKey = @"sdkId";
static NSString * const kRequestJDCNAnalyticsSdkVersionKey = @"sdkVersion";
static NSString * const kRequestJDCNAnalyticsOsKey = @"os";
static NSString * const kRequestJDCNAnalyticsOsversionKey = @"osversion";
static NSString * const kRequestJDCNAnalyticsTimeKey = @"time";
static NSString * const kRequestJDCNAnalyticsTrackIdKey = @"trackId";
static NSString * const kRequestJDCNAnalyticsBusinessIdKey = @"businessId";
static NSString * const kRequestJDCNAnalyticsEventIdKey = @"eventId";
static NSString * const kRequestJDCNAnalyticsKvsKey = @"kvs";

@interface JDCNAnalyticsRequest ()

@property(nonatomic , strong)JDJR_NetManager *jdjrNetManager;

@end


@implementation JDCNAnalyticsRequest

// 请求url地址
// 测试
//NSString * const kJDCNAnalyticsHttpSessionURL = @"https://jrtdeidcert.jd.com";
// 线上
NSString * const kJDCNAnalyticsHttpSessionURL = @"https://jrtdcert.jd.com";

+ (JDCNAnalyticsRequest *)sharedInstance {
    static JDCNAnalyticsRequest *analyticsRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        analyticsRequest = [[JDCNAnalyticsRequest alloc] init];
    });
    return analyticsRequest;
}

- (JDJR_NetManager*)jdjrNetManager{
    if (!_jdjrNetManager) {
        _jdjrNetManager = [[JDJR_NetManager alloc]initWithBaseURL:[NSURL URLWithString:kJDCNAnalyticsHttpSessionURL] WithSessionConfiguration:nil];
        //[_jdjrNetManager setTimeout:5];
    }
    return _jdjrNetManager;
}


- (void)requestAnalyticsWithEventTrackModel:(JDTDMobClickEventTrackModel *)eventModel {
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time= [date timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *osName = [[UIDevice currentDevice] systemName];
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    
    NSError *error;
    NSString *jsonDictKey;
    if (eventModel.attributes && eventModel.attributes.count) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:eventModel.attributes
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (!error) {
            jsonDictKey = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    NSDictionary *dictParameters = @{kRequestJDCNAnalyticsAppIdKey : bundleId ? : @"",
                                     kRequestJDCNAnalyticsSdkIdKey : @"iospay",
                                     kRequestJDCNAnalyticsSdkVersionKey: @"1.0",
                                     kRequestJDCNAnalyticsOsKey : osName ? : @"",
                                     kRequestJDCNAnalyticsOsversionKey : osVersion ? : @"",
                                     kRequestJDCNAnalyticsTimeKey : timeString ? : @"",
                                     kRequestJDCNAnalyticsTrackIdKey : eventModel.trackId ? : @"",
                                     kRequestJDCNAnalyticsBusinessIdKey : eventModel.businessId ? : @"",
                                     kRequestJDCNAnalyticsEventIdKey : eventModel.eventId ? : @"",
                                     kRequestJDCNAnalyticsKvsKey : jsonDictKey ? : @""
                                     };
    
    [self.jdjrNetManager POST:kRequestJDCNAnalyticsAction parameters:dictParameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictResponse = responseObject;
        if ([dictResponse valueForKey:@"code"] && [dictResponse valueForKey:@"msg"]) {
            NSInteger code = [[dictResponse valueForKey:@"code"] integerValue];
            NSString *msg = [dictResponse valueForKey:@"msg"];
            if (code) {
                NSLog(@"track event upload success msg = %@",msg);
            } else {
                NSLog(@"track event upload fail msg = %@",msg);
            }
        } else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"task failure error = %@", error.localizedDescription);
    }];
}


@end
