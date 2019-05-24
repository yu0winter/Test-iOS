//
//  JDTDMobClick.m
//  JDTDAnalyticsDemo
//
//  Created by jd.huaxiaochun on 16/6/28.
//  Copyright © 2016年 jd.slipknot. All rights reserved.
//

#import "JDTDMobClick.h"
#import "JDTDMobClickTrackBaseModel.h"
#import "JDTDMobClickEventTrackModel.h"
#import "JDCNAnalyticsRequest.h"

#define JDTDBundleString(key, comment)  [[[NSBundle mainBundle] infoDictionary] objectForKey:(key)]

/*! @abstract 默认渠道 */
static NSString * const kDefaultChannel = @"App Store";
/*! @abstract App名称 */
static NSString * const kBundleDisplayName = @"CFBundleDisplayName";
/*! @abstract App版本号 */
static NSString * const kBundleVersion = @"CFBundleShortVersionString";

@interface JDTDMobClick ()

/*! @abtract app唯一标识 */
@property (nonatomic, copy, readwrite) NSString *appKey;
/*! @abtract 渠道 */
@property (nonatomic, copy, readwrite) NSString *channel;
/*! @abtract 版本号 */
@property (nonatomic, copy, readwrite) NSString *version;
/*! @abtract 版本名称 */
@property (nonatomic, copy, readwrite) NSString *versionName;
/*! @abstract 事件跟踪Model */
@property (nonatomic, strong, readwrite) JDTDMobClickEventTrackModel *mobClickEventTrackModel;
/*! @abstract 会话id */
@property (nonatomic, copy, readwrite) NSString *sessionId;
/*! @abstract 业务id */
@property (nonatomic, copy, readwrite) NSString *bussinessId;

@end

static JDTDMobClick *mobClickShareInstace;

@implementation JDTDMobClick

#pragma mark - ClassMethod
/*!
 *  @brief 初始化统计实例
 *
 *  @param appKey    应用的唯一标识，统计后台注册得到
 *  @param channelID （可选）渠道名，默认“App Store”
 */
+ (void)sessionStartWithAppKey:(NSString *)appKey ChannelId:(NSString *)channelID{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        mobClickShareInstace = [[JDTDMobClick alloc] initWithAppKey:appKey channel:channelID];
    });
}

/*!
 *  @brief 应用会话、业务标识
 *
 *  @param sessionId    会话id
 *  @param bussinessId  业务id
 */
+ (void)applicationSessionWithSessionId:(NSString *)sessionId bussinessId:(NSString *)bussinessId{
    // 存储会话Id、业务Id
    mobClickShareInstace.sessionId = sessionId;
    mobClickShareInstace.bussinessId = bussinessId;
}

/*!
 *  @brief 统计自定义事件
 *
 *  @param eventId 事件名称(自定义)
 */
+ (void)trackEvent:(NSString *)eventId{
    [mobClickShareInstace trackEventWithId:eventId label:nil attributes:nil];
}

/*!
 *  @brief 统计带标签的自定义事件 可用标签来区别同一个事件的不同应用场景
 *
 *  @param eventId   事件名称(自定义)
 *  @param eventLabel 事件标签(自定义)
 */
+ (void)trackEvent:(NSString *)eventId label:(NSString *)eventLabel{
    [mobClickShareInstace trackEventWithId:eventId label:eventLabel attributes:nil];
}

/*!
 *  @brief 统计带参数的自定义事件
 *
 *  @param eventId    事件名称(自定义)
 *  @param eventLabel 事件标签(自定义)
 *  @param attributes 事件参数(自定义)
 */
+ (void)trackEvent:(NSString *)eventId label:(NSString *)eventLabel attributes:(NSDictionary *)attributes{
    [mobClickShareInstace trackEventWithId:eventId label:eventLabel attributes:attributes];
}

#pragma mark - Init
/*!
 *  @brief 初始化
 *
 *  @param appKey  app唯一标识
 *  @param channel 渠道
 *
 *  @return instance
 */
- (instancetype)initWithAppKey:(NSString *)appKey channel:(NSString *)channel{
    self = [super init];
    if (self) {
        // custom
        self.appKey = appKey;
        self.channel = channel && channel.length ? channel : kDefaultChannel;
        self.version = JDTDBundleString(kBundleVersion, @"app version");
        self.versionName = JDTDBundleString(kBundleDisplayName, @"app name");
    }
    return self;
}

#pragma mark - Track
/*!
 *  @brief 事件跟踪
 *
 *  @param eventId    事件id
 *  @param eventLabel 事件分类
 *  @param attributes 属性
 */
- (void)trackEventWithId:(NSString *)eventId label:(NSString *)eventLabel attributes:(NSDictionary *)attributes{
    JDTDMobClickEventTrackModel *mobClickEventTrackModel = [[JDTDMobClickEventTrackModel alloc] init];
    mobClickEventTrackModel.trackId = [self uuidString];
    mobClickEventTrackModel.sessionId = [self client_bVersion];
    mobClickEventTrackModel.businessId = self.bussinessId;
    mobClickEventTrackModel.eventId = eventId;
    mobClickEventTrackModel.label = eventLabel;
    mobClickEventTrackModel.attributes = attributes;
    mobClickEventTrackModel.eventTrackBeginTime = [self currentDate];
    mobClickEventTrackModel.eventTrackEndTime = mobClickEventTrackModel.eventTrackBeginTime;
    
    [[JDCNAnalyticsRequest sharedInstance] requestAnalyticsWithEventTrackModel:mobClickEventTrackModel];
}

#pragma mark - Private
/*!
 *  @brief  uuid
 *
 *  @return NSString
 */
- (NSString *)uuidString{
    CFUUIDRef ref = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, ref);
    CFRelease(ref);
    uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidString;
}

//应用build版本号
-(NSString*)client_bVersion {
    NSString *clientBuildVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    return  clientBuildVersion == nil ? @"" : clientBuildVersion;
}


/*!
 *  @brief  当前时间
 *
 *  @return NSString
 */
- (NSString *)currentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
