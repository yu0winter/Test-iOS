//
//  JDCNNetworkSession.h
//  JDCNNetworkSample
//
//  Created by jd.huaxiaochun on 2017/7/27.
//  Copyright © 2017年 slipknot. All rights reserved.
//  网络会话管理类

#import <Foundation/Foundation.h>

/**
 响应码

 - JDCNNetworkSessionManagerResponseCodeSuccess: 成功
 - JDCNNetworkSessionManagerResponseCodeLimitedAccess: 权限受限
 - JDCNNetworkSessionManagerResponseCodeSystemError: 系统错误
 - JDCNNetworkSessionManagerResponseCodeParameterIsNotValid: 请求参数无效
 - JDCNNetworkSessionManagerResponseCodeOperationFail: 操作失败
 */
typedef NS_OPTIONS(NSInteger, JDCNNetworkSessionManagerResponseCode) {
    JDCNNetworkSessionManagerResponseCodeSuccess = 0,
    JDCNNetworkSessionManagerResponseCodeLimitedAccess = 10,
    JDCNNetworkSessionManagerResponseCodeSystemError = 50,
    JDCNNetworkSessionManagerResponseCodeParameterIsNotValid = 100,
    JDCNNetworkSessionManagerResponseCodeOperationFail = 101
};

NS_ASSUME_NONNULL_BEGIN

@interface JDCNNetworkSessionManager : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

/**
 url地址
 */
@property (nonatomic, strong, readonly) NSURL *baseURL;

/**
 会话
 */
@property (nonatomic, strong, readonly) NSURLSession *session;

/**
 操作队列
 */
@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark - Init

/**
 初始化
 
 @return initWithBaseURL:nil WithSessionConfiguration:nil
 */
+ (instancetype)manager;

/**
 初始化会话

 @param baseUrl URL地址
 @param configuration 会话配置
 @return instance
 */
- (instancetype)initWithBaseURL:(nullable NSURL *)baseUrl
       WithSessionConfiguration:(nullable NSURLSessionConfiguration *)configuration;

#pragma mark - CancelTasks

/**
 根据是否取消未完成的任务来设置会话失效

 @param cancelPendingTasks 是否取消等待中的任务
 */
- (void)invalidateSessionCancelingTasks:(BOOL)cancelPendingTasks;

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
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

#pragma mark - Block
/**
 会话已失效block处理

 @param block 闭包
 */
- (void)setSessionDidBecomeInvalidBlock:(void (^)(NSURLSession *session, NSError *error))block;

/**
 任务已完成block处理

 @param block 闭包
 */
- (void)setTaskDidCompleteBlock:(void (^)(NSURLSession *session, NSURLSessionTask *task, NSError *error))block;

NS_ASSUME_NONNULL_END
@end
