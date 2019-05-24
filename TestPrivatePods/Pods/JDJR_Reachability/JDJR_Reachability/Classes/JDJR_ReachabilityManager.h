//
//  JDJR_ReachabilityManager.h
//  JDJR_Reachability
//
//  Created by 成勇 on 2018/8/17.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef NS_ENUM(NSInteger, JDJR_ReachabilityStatus) {
    JDJR_ReachabilityStatusUnknown          = -1,
    JDJR_ReachabilityStatusNotReachable     = 0,
    JDJR_ReachabilityStatusReachableViaWWAN = 1,
    JDJR_ReachabilityStatusReachableViaWiFi = 2,
};

FOUNDATION_EXPORT NSString * const JDJR_ReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString * const JDJR_ReachabilityNotificationStatusItem;


@interface JDJR_ReachabilityManager : NSObject

/**
 当前网络的状态
 */
@property (readonly, nonatomic, assign) JDJR_ReachabilityStatus networkReachabilityStatus;

/**
 当前网络是否可通
 */
@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;

/**
 是否有无线 2g 3g 4g 5g
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWWAN) BOOL reachableViaWWAN;

/**
 是否连接WiFi
 */
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

/**
 网络类型 描述
 */
@property (readonly, nonatomic, strong) NSString * netWorkType;

+ (instancetype)sharedManager;

+ (instancetype)manager;

+ (instancetype)managerForDomain:(NSString *)domain;

+ (instancetype)managerForAddress:(const void *)address;

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability NS_DESIGNATED_INITIALIZER;

/**
 🤪 必须调用，在访问所有功能之前必须首先开启监听
 */
- (void)startMonitoring;

/**
 与上面的相反 停止监听
 */
- (void)stopMonitoring;

/**
 网络类型变化时会触发该block

 @param block 监控网络类型变化
 */
- (void)setReachabilityStatusChangeBlock:(nullable void (^)(JDJR_ReachabilityStatus status))block;

/**
 当前网络类型

 @param block 回调当前网络类型
 */
- (void)setNetTypeChangeBlock:(nullable void (^)(NSString * netWorkType))block;
@end
