//
//  JDJR_NetManager.h
//  AFNetworking
//
//  Created by 成勇 on 2018/8/13.
//

#import <Foundation/Foundation.h>
#import "JDJR_NetConst.h"

@interface JDJR_NetManager : NSObject

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
- (instancetype)initWithBaseURL:(NSURL *)baseUrl
       WithSessionConfiguration:(nullable NSURLSessionConfiguration *)configuration;

/**
 设置返回成功之后的数据筛选即解析最外层
 */
- (void)setResponseFilterWithBlock:(JDJR_ResponseFilterBlock)block;

/**
 *    设置请求超时时间，默认为15秒
 *
 *    @param timeout 超时时间
 */
- (void)setTimeout:(NSTimeInterval)timeout;

/**
 是否有网络
 
 @return 是否有网
 */
+ (BOOL)isNetworking;

/**
 是否有wan网
 
 @return 是否是wan
 */
+ (BOOL)isWWANNetwork;

/**
 是否是wifi
 
 @return 是否wifi
 */
+ (BOOL)isWiFiNetwork;

#pragma mark - Request

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
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
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

@end
