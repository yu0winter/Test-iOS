//
//  JDTDMobClick.h
//
//  Created by jd.huaxiaochun on 18/7/12.
//  Copyright © 2018年 jd.slipknot. All rights reserved.
//  埋点统计

#import <Foundation/Foundation.h>

@interface JDTDMobClick : NSObject

/*!
 *  @brief 初始化统计实例
 *
 *  @param appKey    应用的唯一标识，统计后台注册得到
 *  @param channelID （可选）渠道名，默认“App Store”
 */
+ (void)sessionStartWithAppKey:(NSString *)appKey ChannelId:(NSString *)channelID;

/*!
 *  @brief 应用会话、业务标识
 *
 *  @param sessionId    会话id
 *  @param bussinessId  业务id
 */
+ (void)applicationSessionWithSessionId:(NSString *)sessionId bussinessId:(NSString *)bussinessId;

/*!
 *  @brief 统计自定义事件
 *
 *  @param eventId 事件名称(自定义)
 */
+ (void)trackEvent:(NSString *)eventId;

/*!
 *  @brief 统计带标签的自定义事件 可用标签来区别同一个事件的不同应用场景
 *
 *  @param eventId   事件名称(自定义)
 *  @param eventLabel 事件标签(自定义)
 */
+ (void)trackEvent:(NSString *)eventId label:(NSString *)eventLabel;

/*!
 *  @brief 统计带参数的自定义事件
 *
 *  @param eventId    事件名称(自定义)
 *  @param eventLabel 事件标签(自定义)
 *  @param attributes 事件参数(自定义)
 */
+ (void)trackEvent:(NSString *)eventId label:(NSString *)eventLabel attributes:(NSDictionary *)attributes;

@end
