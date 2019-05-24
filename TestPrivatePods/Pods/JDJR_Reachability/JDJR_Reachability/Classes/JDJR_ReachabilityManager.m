//
//  JDJR_ReachabilityManager.m
//  JDJR_Reachability
//
//  Created by 成勇 on 2018/8/17.
//

#import "JDJR_ReachabilityManager.h"
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

NSString * const JDJR_ReachabilityDidChangeNotification = @"com.jdjr.networking.reachability.change";
NSString * const JDJR_ReachabilityNotificationStatusItem = @"JDJR_ReachabilityNotificationStatusItem";

typedef void (^JDJR_ReachabilityStatusBlock)(JDJR_ReachabilityStatus status);

NSString * JDJR_StringFromNetworkReachabilityStatus(JDJR_ReachabilityStatus status) {
    switch (status) {
        case JDJR_ReachabilityStatusNotReachable:
            return @"NotConnected";
        case JDJR_ReachabilityStatusReachableViaWWAN:
            //😜 默认为4g 网络吧
            return @"4G";
        case JDJR_ReachabilityStatusReachableViaWiFi:
            return @"WiFi";
        case JDJR_ReachabilityStatusUnknown:
        default:
            return @"unown";
    }
}

static JDJR_ReachabilityStatus JDJR_ReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    
    JDJR_ReachabilityStatus status = JDJR_ReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = JDJR_ReachabilityStatusNotReachable;
    }
#if    TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        status = JDJR_ReachabilityStatusReachableViaWWAN;
    }
#endif
    else {
        status = JDJR_ReachabilityStatusReachableViaWiFi;
    }
    
    return status;
}

/**
 * Queue a status change notification for the main thread.
 *
 * This is done to ensure that the notifications are received in the same order
 * as they are sent. If notifications are sent directly, it is possible that
 * a queued notification (for an earlier status condition) is processed after
 * the later update, resulting in the listener being left in the wrong state.
 */
static void JDJR_PostReachabilityStatusChange(SCNetworkReachabilityFlags flags, JDJR_ReachabilityStatusBlock block) {
    JDJR_ReachabilityStatus status = JDJR_ReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) {
            block(status);
        }
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSDictionary *userInfo = @{ JDJR_ReachabilityNotificationStatusItem: @(status) };
        [notificationCenter postNotificationName:JDJR_ReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}

static void JDJR_ReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    JDJR_PostReachabilityStatusChange(flags, (__bridge JDJR_ReachabilityStatusBlock)info);
}


static const void * JDJR_ReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}

static void JDJR_ReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}

@interface JDJR_ReachabilityManager ()
@property (readwrite, nonatomic, strong) id networkReachability;
@property (readwrite, nonatomic, assign) JDJR_ReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) JDJR_ReachabilityStatusBlock networkReachabilityStatusBlock;
@end

@implementation JDJR_ReachabilityManager

+ (instancetype)sharedManager {
    static JDJR_ReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });
    
    return _sharedManager;
}

#ifndef __clang_analyzer__
+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    
    JDJR_ReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    
    return manager;
}
#endif

#ifndef __clang_analyzer__
+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    JDJR_ReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    
    return manager;
}
#endif

+ (instancetype)manager {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.networkReachability = CFBridgingRelease(reachability);
    self.networkReachabilityStatus = JDJR_ReachabilityStatusUnknown;
    
    return self;
}

- (instancetype)init NS_UNAVAILABLE
{
    return nil;
}

- (void)dealloc {
    [self stopMonitoring];
}

#pragma mark -

- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    return self.networkReachabilityStatus == JDJR_ReachabilityStatusReachableViaWWAN;
}

- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == JDJR_ReachabilityStatusReachableViaWiFi;
}

- (NSString *)netWorkType {
//    //访问类型之前先触发下 开启监听
//    [self startMonitoring];
    //😱 确实必须得在调用该库之前触发下 startMonitoring
    return [self localizedNetworkReachabilityStatusString];
}
#pragma mark -

- (void)startMonitoring {
    [self stopMonitoring];
    
    if (!self.networkReachability) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    JDJR_ReachabilityStatusBlock callback = ^(JDJR_ReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }
    };
    
    id networkReachability = self.networkReachability;
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, JDJR_ReachabilityRetainCallback, JDJR_ReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback((__bridge SCNetworkReachabilityRef)networkReachability, JDJR_ReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop((__bridge SCNetworkReachabilityRef)networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags((__bridge SCNetworkReachabilityRef)networkReachability, &flags)) {
            JDJR_PostReachabilityStatusChange(flags, callback);
        }
    });
}

- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    SCNetworkReachabilityUnscheduleFromRunLoop((__bridge SCNetworkReachabilityRef)self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

#pragma mark -

- (NSString *)localizedNetworkReachabilityStatusString {
    return JDJR_StringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}

#pragma mark -

- (void)setReachabilityStatusChangeBlock:(void (^)(JDJR_ReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}

- (void)setNetTypeChangeBlock:(void (^)(NSString * netWorkType))block {
    self.networkReachabilityStatusBlock = ^(JDJR_ReachabilityStatus status){
        block(JDJR_StringFromNetworkReachabilityStatus(status));
    };
}

#pragma mark - NSKeyValueObserving

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }
    
    return [super keyPathsForValuesAffectingValueForKey:key];
}

@end

