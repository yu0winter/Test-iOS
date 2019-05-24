//
//  JDJR_NetManager.m
//  AFNetworking
//
//  Created by 成勇 on 2018/8/13.
//

#import "JDJR_NetManager.h"
#import "JDCNNetworkSessionManager.h"
#import <JDJR_Reachability/JDJR_Reachability.h>

@interface JDJR_NetManager()

@property(nonatomic , strong)JDCNNetworkSessionManager *JDCNNetwork;

@property (nonatomic, copy) JDJR_ResponseFilterBlock responseFilter;
@end

@implementation JDJR_NetManager

+ (void)load {
    [[JDJR_ReachabilityManager sharedManager] startMonitoring];
}

/**
 初始化
 
 @return initWithBaseURL:nil WithSessionConfiguration:nil
 */
+ (instancetype)manager {
    return [[[self class] alloc] initWithBaseURL:nil WithSessionConfiguration:nil];
}

/**
 初始化
 
 @return instance
 */
- (instancetype)init {
    return [self initWithBaseURL:nil WithSessionConfiguration:nil];
}

/**
 初始化会话
 
 @param baseUrl URL地址
 @param configuration 会话配置
 @return instance
 */
- (instancetype)initWithBaseURL:(NSURL *)baseUrl
       WithSessionConfiguration:(nullable NSURLSessionConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.JDCNNetwork = [[JDCNNetworkSessionManager alloc]initWithBaseURL:baseUrl WithSessionConfiguration:configuration];
    }
    return self;
}

/**
 设置返回成功之后的数据筛选即解析最外层
 */
- (void)setResponseFilterWithBlock:(JDJR_ResponseFilterBlock)block {
    self.responseFilter = block;
}


/**
 *    设置请求超时时间，默认为15秒
 *
 *    @param timeout 超时时间
 */
- (void)setTimeout:(NSTimeInterval)timeout {
//    self.JDCNNetwork.timeout = timeout;
}

/**
 是否有网络
 
 @return 是否有网
 */
+ (BOOL)isNetworking {
    return [JDJR_ReachabilityManager sharedManager].reachable;
}

/**
 是否有wan网
 
 @return 是否是wan
 */
+ (BOOL)isWWANNetwork {
    return [JDJR_ReachabilityManager sharedManager].reachableViaWWAN;
}

/**
 是否是wifi
 
 @return 是否wifi
 */
+ (BOOL)isWiFiNetwork {
    return [JDJR_ReachabilityManager sharedManager].reachableViaWiFi;
}

/**
 POST请求
 
 @param URLString 请求地址
 @param parameters 参数
 @param success 成功block
 @param failure 失败block
 */
- (void)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    //🐛 严重问题:block内存泄漏的问题,偶发性问题
    __weak __typeof(self)weakSelf = self;
    [self.JDCNNetwork
     POST:URLString
     parameters:parameters
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         if (strongSelf.responseFilter) {
             NSError *responseError;
             id retResponseObj = strongSelf.responseFilter(responseObject, &responseError);
             if (responseError) {
                 failure(task,responseError);
             } else {
                 success(task,retResponseObj);
             }
         } else {
             success(task,responseObject);
         }
         
     } failure:failure];
}

/**
 GET请求
 
 @param URLString 请求地址
 @param parameters 参数
 @param success 成功block
 @param failure 失败block
 */
- (void)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    //🐛 严重问题:block内存泄漏的问题,偶发性问题
    __weak __typeof(self)weakSelf = self;
    [self.JDCNNetwork
     POST:URLString
     parameters:parameters
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         if (strongSelf.responseFilter) {
             NSError *responseError;
             id retResponseObj = strongSelf.responseFilter(responseObject, &responseError);
             if (responseError) {
                 failure(task,responseError);
             } else {
                 success(task,retResponseObj);
             }
         } else {
             success(task,responseObject);
         }
         
     } failure:failure];
}

#pragma mark - Block
/**
 会话已失效block处理
 
 @param block 闭包
 */
- (void)setSessionDidBecomeInvalidBlock:(void (^)(NSURLSession *session, NSError *error))block {
    [self.JDCNNetwork setSessionDidBecomeInvalidBlock:block];
}

/**
 任务已完成block处理
 
 @param block 闭包
 */
- (void)setTaskDidCompleteBlock:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))block {
    [self.JDCNNetwork setTaskDidCompleteBlock:block];
}

@end
