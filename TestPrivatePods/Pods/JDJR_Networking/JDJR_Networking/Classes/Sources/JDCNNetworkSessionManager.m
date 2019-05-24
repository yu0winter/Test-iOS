//
//  JDCNNetworkSession.m
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/27.
//  Copyright © 2017年 slipknot. All rights reserved.
//

#import "JDCNNetworkSessionManager.h"

// DebugLog宏
#ifdef DEBUG
#define DebugLog(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DebugLog(...) do { } while (0)
#endif

// 版本宏
#ifndef NSFoundationVersionNumber_iOS_8_0
#define NSFoundationVersionNumber_With_Fixed_5871104061079552_bug 1140.11
#else
#define NSFoundationVersionNumber_With_Fixed_5871104061079552_bug NSFoundationVersionNumber_iOS_8_0
#endif


/**
 单例创建串行指定队列

 @return 串行指定队列
 */
static dispatch_queue_t url_session_manager_creation_queue() {
    static dispatch_queue_t jdcn_url_session_manager_creation_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jdcn_url_session_manager_creation_queue = dispatch_queue_create("com.jdcn.networking.session.manager.creation", DISPATCH_QUEUE_SERIAL);
    });
    
    return jdcn_url_session_manager_creation_queue;
}

/**
 创建安全任务队列

 @param block 闭包
 */
static void url_session_manager_create_task_safely(dispatch_block_t block) {
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_With_Fixed_5871104061079552_bug) {
        // Fix of bug
        // Open Radar:http://openradar.appspot.com/radar?id=5871104061079552 (status: Fixed in iOS8)
        // Issue about:https://github.com/AFNetworking/AFNetworking/issues/2093
        dispatch_sync(url_session_manager_creation_queue(), block);
    } else {
        block();
    }
}

/**
 单例创建并行指定队列

 @return 并行指定队列
 */
static dispatch_queue_t url_session_manager_processing_queue() {
    static dispatch_queue_t jdcn_url_session_manager_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jdcn_url_session_manager_processing_queue = dispatch_queue_create("com.jdcn.networking.session.manager.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return jdcn_url_session_manager_processing_queue;
}

/**
 单例创建组块对象关联

 @return 组
 */
static dispatch_group_t url_session_manager_completion_group() {
    static dispatch_group_t jdcn_url_session_manager_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jdcn_url_session_manager_completion_group = dispatch_group_create();
    });
    
    return jdcn_url_session_manager_completion_group;
}

/**
 会话任务完成处理闭包

 @param response 响应
 @param responseObject 响应对象
 @param error 错误
 */
typedef void (^JDCNURLSessionTaskCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);

/**
 会话已无效闭包

 @param session 会话
 @param error 错误
 */
typedef void (^JDCNURLSessionDidBecomeInvalidBlock)(NSURLSession *session, NSError *error);

/**
 会话任务已完成闭包

 @param session 会话
 @param task 任务
 @param error 错误
 */
typedef void (^JDCNURLSessionTaskDidCompleteBlock)(NSURLSession *session, NSURLSessionTask *task, NSError *error);

// URL
static NSString * const kBaseUrl = @"https://identify.jd.com";
// 会话管理锁名称
static NSString * const kJDCNURLSessionManagerLockName = @"com.jdcn.networking.session.manager.lock";

/**
 会话任务代理类
 */
@interface JDCNURLSessionManagerTaskDelegate : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

/**
 会话管理
 */
@property (nonatomic, weak, readwrite) JDCNNetworkSessionManager *sessionManager;

/**
 数据包
 */
@property (nonatomic, strong, readwrite) NSMutableData *mutableData;

/**
 完成处理闭包
 */
@property (nonatomic, copy, readwrite) JDCNURLSessionTaskCompletionHandler completionHandler;

/**
 初始化

 @param task 会话任务
 @return instance
 */
- (instancetype)initWithTask:(NSURLSessionTask *)task;

@end

@implementation JDCNURLSessionManagerTaskDelegate

#pragma mark - Init
/**
 初始化
 
 @param task 会话任务
 @return instance
 */
- (instancetype)initWithTask:(NSURLSessionTask *)task {
    self = [super init];
    if (self) {
        self.mutableData = [NSMutableData data];
    }
    return self;
}

#pragma mark - NSURLSessionTaskDelegate

/**
 接收分发回调处理-会话已完成数据接收

 @param session 会话
 @param task 任务
 @param error 错误
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    // weak 变为strong 保证不被释放
    __unused __strong JDCNNetworkSessionManager *manager = self.sessionManager;
    
    __block id responseObject = nil;
    
    // 数据接收
    NSData *data = nil;
    if (self.mutableData) {
        data = [self.mutableData copy];
        self.mutableData = nil;
    }
    
    if (error) {
        // block执行 failure
        dispatch_group_async(url_session_manager_completion_group(), dispatch_get_main_queue(), ^{
            if (self.completionHandler) {
                self.completionHandler(task.response, responseObject, error);
            }
        });
    } else {
        dispatch_async(url_session_manager_processing_queue(), ^{
            // 数据是否为空
            if (data.length == 0) {
                if (self.completionHandler) {
                    self.completionHandler(task.response, responseObject, nil);
                }
                return;
            }
            // data->jsonobject
            NSError *serializationError = nil;
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializationError];
            // block执行 success
            dispatch_group_async(url_session_manager_completion_group(), dispatch_get_main_queue(), ^{
                if (self.completionHandler) {
                    self.completionHandler(task.response, responseObject, serializationError);
                }
                
            });
        });
    }
}

#pragma mark - NSURLSessionDataDelegate

/**
 接收分发回调处理-接收传输数据

 @param session 会话
 @param dataTask 数据任务
 @param data 数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    // 接收响应数据
    [self.mutableData appendData:data];
}

@end

@interface JDCNNetworkSessionManager () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

/**
 url地址
 */
@property (nonatomic, strong, readwrite) NSURL *baseURL;

/**
 会话配置
 */
@property (nonatomic, strong, readwrite) NSURLSessionConfiguration *sessionConfiguration;

/**
 操作队列
 */
@property (nonatomic, strong, readwrite) NSOperationQueue *operationQueue;

/**
 会话
 */
@property (nonatomic, strong, readwrite) NSURLSession *session;

/**
 任务标识字典
 */
@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableTaskDelegatesKeyedByTaskIdentifier;

/**
 锁对象
 */
@property (nonatomic, copy, readwrite) NSLock *lock;

/**
 任务描述
 */
@property (nonatomic, copy, readonly) NSString *taskDescriptionForSessionTasks;

/**
 会话已失效block
 */
@property (nonatomic, copy, readwrite) JDCNURLSessionDidBecomeInvalidBlock sessionDidBecomeInvalid;

/**
 会话任务已完成闭包
 */
@property (nonatomic, copy, readwrite) JDCNURLSessionTaskDidCompleteBlock taskDidComplete;

@end

@implementation JDCNNetworkSessionManager

#pragma mark - Init

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
        
        if (!baseUrl) {
            baseUrl = [NSURL URLWithString:kBaseUrl];
        }
        // 基请求URL
        _baseURL = baseUrl;
        
        // 会话配置
        if (!configuration) {
            configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
        _sessionConfiguration = configuration;
        // 操作队列
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.maxConcurrentOperationCount = 1;
        _operationQueue = operationQueue;
        // 会话
        NSURLSession *session = [NSURLSession sessionWithConfiguration:_sessionConfiguration
                                                              delegate:self
                                                         delegateQueue:operationQueue];
        _session = session;
        // 锁
        NSLock *lock = [[NSLock alloc] init];
        lock.name = kJDCNURLSessionManagerLockName;
        _lock = lock;
        //默认15秒
//        self.timeout = 5;
        // 任务标识
        NSMutableDictionary *mutableTaskDelegatesKeyedByTaskIdentifier = [[NSMutableDictionary alloc] init];
        _mutableTaskDelegatesKeyedByTaskIdentifier = mutableTaskDelegatesKeyedByTaskIdentifier;
    }
    return self;
}

#pragma mark - CancelTasks

/**
 根据是否取消未完成的任务来设置会话失效
 
 @param cancelPendingTasks 是否取消等待中的任务
 */
- (void)invalidateSessionCancelingTasks:(BOOL)cancelPendingTasks {
    if (self.session) {
        if (cancelPendingTasks) {
            // 立即失效，未完成的任务也将结束
            [self.session invalidateAndCancel];
        } else {
            // 待完成所有的任务后失效
            [self.session finishTasksAndInvalidate];
        }
    }
}

#pragma mark - setBlock

/**
 会话已失效block处理
 
 @param block 闭包
 */
- (void)setSessionDidBecomeInvalidBlock:(void (^)(NSURLSession *session, NSError *error))block {
    self.sessionDidBecomeInvalid = block;
}

/**
 任务已完成block处理
 
 @param block 闭包
 */
- (void)setTaskDidCompleteBlock:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))block {
    self.taskDidComplete = block;
}

#pragma mark - Description

/**
 任务描述

 @return 会话地址
 */
- (NSString *)taskDescriptionForSessionTasks {
    return [NSString stringWithFormat:@"%p", self];
}

#pragma mark - Request
/**
 POST请求
 
 @param URLString 请求地址
 @param parameters 参数
 @param success 成功block
 @param failure 失败block
 @return NSURLSessionDataTask instance
 */
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    NSParameterAssert(URLString);
    
    // request
    NSError *error;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString relativeToURL:_baseURL]];
    // 超时5秒
    request.timeoutInterval = 5;
    // post方式
    request.HTTPMethod = @"POST";
    // json格式
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // nsstring -> nsdata
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error]];
    
    NSLog(@"*****%@",request.URL);
    // Serialization error
    if (error) {
        DebugLog(@"dataTaskWithParamters request Paramters NSJSONWritingPrettyPrinted error = %@",error.localizedDescription);
        // block failure
        if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(nil, error);
            });
        }
        return nil;
    }
    
    // dataTask
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (success) {
                success(dataTask, responseObject);
            }
        } else {
            if (failure) {
                failure(dataTask, error);
            }
        }
    }];
    [dataTask resume];
    
    DebugLog(@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n");
    
    DebugLog(@"API Name: %@ \n",request.URL.absoluteString);
    DebugLog(@"Method : %@ \n",request.HTTPMethod);
    DebugLog(@"HTTPHeader : %@ \n",request.allHTTPHeaderFields);
    DebugLog(@"Request Paramter : %@ \n",parameters);
    
    DebugLog(@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n");
    
    return dataTask;
    
}

/**
 数据任务请求

 @param request 请求对象
 @param completionHandler 完成处理
 @return NSURLSessionDataTask instance
 */
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    
    __block NSURLSessionDataTask *dataTask = nil;
    url_session_manager_create_task_safely(^{
        dataTask = [self.session dataTaskWithRequest:request];
    });
    // dataTask&completionHandler绑定委托对象
    [self addDelegateForDataTask:dataTask completionHandler:completionHandler];
    
    return dataTask;
}

#pragma mark - JDCNURLSessionManagerTaskDelegate

/**
 根据会话任务获取委托

 @param task 会话
 @return JDCNURLSessionManagerTaskDelegate instance
 */
- (JDCNURLSessionManagerTaskDelegate *)delegateForTask:(NSURLSessionTask *)task {
    NSParameterAssert(task);
    
    // 根据会话标识获取字典中存储的委托对象
    JDCNURLSessionManagerTaskDelegate *delegate = nil;
    [self.lock lock];
    delegate = self.mutableTaskDelegatesKeyedByTaskIdentifier[@(task.taskIdentifier)];
    [self.lock unlock];
    
    return delegate;
}

/**
 设置委托对象

 @param delegate 委托对象
 @param task 会话
 */
- (void)setDelegate:(JDCNURLSessionManagerTaskDelegate *)delegate
            forTask:(NSURLSessionTask *)task
{
    NSParameterAssert(task);
    NSParameterAssert(delegate);
    
    // 在字典中设置委托对象 key为会话标识 value为委托对象
    [self.lock lock];
    self.mutableTaskDelegatesKeyedByTaskIdentifier[@(task.taskIdentifier)] = delegate;
    [self.lock unlock];
}

/**
 添加委托对象根据数据任务

 @param dataTask 数据任务
 @param completionHandler 完成处理
 */
- (void)addDelegateForDataTask:(NSURLSessionDataTask *)dataTask
             completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler
{
    // 初始化委托对象
    JDCNURLSessionManagerTaskDelegate *delegate = [[JDCNURLSessionManagerTaskDelegate alloc] initWithTask:dataTask];
    delegate.sessionManager = self;
    delegate.completionHandler = completionHandler;
    dataTask.taskDescription = self.taskDescriptionForSessionTasks;
    // 保存委托对象
    [self setDelegate:delegate forTask:dataTask];
}

/**
 移除委托对象根据会话

 @param task 会话
 */
- (void)removeDelegateForTask:(NSURLSessionTask *)task {
    NSParameterAssert(task);
    
    // 根据会话标识移除字典中委托对象
    [self.lock lock];
    [self.mutableTaskDelegatesKeyedByTaskIdentifier removeObjectForKey:@(task.taskIdentifier)];
    [self.lock unlock];
}

#pragma mark - NSURLSessionDelegate

/**
 会话已失效回调

 @param session 会话
 @param error 错误
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    DebugLog(@"error = %@", error.localizedDescription);
    // 无效会话block
    if (self.sessionDidBecomeInvalid) {
        self.sessionDidBecomeInvalid(session, error);
    }
}

/**
 已接收挑战回调

 @param session 会话
 @param challenge 挑战
 @param completionHandler 完成处理
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    // 第一次握手client端验证server端
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        // 获取服务器保护空间信任管理
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        // 信任结果枚举
        SecTrustResultType trustResult;
        // 验证证书有效性 先验证之前锚点设置的证书或者系统默认提供的证书 对trust进行验证
        OSStatus status = SecTrustEvaluate(trust, &trustResult);
        if (status == errSecSuccess &&
            (trustResult == kSecTrustResultProceed ||
             trustResult == kSecTrustResultUnspecified)) {
                // 验证成功 生成凭证告知challenge的sender使用这个凭证来继续连接
                credential = [NSURLCredential credentialForTrust:trust];
                if (credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                // 验证失败取消验证流程 断开链路
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    // 完成处理block
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

#pragma mark - NSURLSessionTaskDelegate

/**
 已接收挑战回调

 @param session 会话
 @param task 任务
 @param challenge 挑战
 @param completionHandler 完成处理
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    // 第一次握手client端验证server端
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        // 获取服务器保护空间信任管理
        SecTrustRef trust = challenge.protectionSpace.serverTrust;
        // 信任结果枚举
        SecTrustResultType trustResult;
        // 验证证书有效性 先验证之前锚点设置的证书或者系统默认提供的证书 对trust进行验证
        OSStatus status = SecTrustEvaluate(trust, &trustResult);
        if (status == errSecSuccess &&
            (trustResult == kSecTrustResultProceed ||
             trustResult == kSecTrustResultUnspecified)) {
                // 验证成功 生成凭证告知challenge的sender使用这个凭证来继续连接
                credential = [NSURLCredential credentialForTrust:trust];
                if (credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                // 验证失败取消验证流程 断开链路
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    // 完成处理block
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

/**
 已完成数据传输回调

 @param session 会话
 @param task 任务
 @param error 错误
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    DebugLog(@"error = %@", error.localizedDescription);
    
    
    // 获取委托对象 分发处理
    JDCNURLSessionManagerTaskDelegate *delegate = [self delegateForTask:task];
    if (delegate) {
        // 分发 数据任务完成回调
        [delegate URLSession:session task:task didCompleteWithError:error];
        // 完成后 移除委托对象
        [self removeDelegateForTask:task];
    }
    if (self.taskDidComplete) {
        self.taskDidComplete(session, task, error);
    }
}

#pragma mark - NSURLSessionDataDelegate

/**
 接收服务器应答回调

 @param session 会话
 @param dataTask 任务
 @param response 响应
 @param completionHandler 完成处理
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    // 允许会话响应
    if (completionHandler) {
        completionHandler(NSURLSessionResponseAllow);
    }
}

/**
 接收服务器数据回调

 @param session 会话
 @param dataTask 任务
 @param data 数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    // 获取委托对象 分发处理
    JDCNURLSessionManagerTaskDelegate *delegate = [self delegateForTask:dataTask];
    // 分发 数据接收回调
    [delegate URLSession:session dataTask:dataTask didReceiveData:data];
}

@end
