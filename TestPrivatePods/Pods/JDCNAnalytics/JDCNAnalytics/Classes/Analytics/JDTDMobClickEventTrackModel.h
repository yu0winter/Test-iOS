//
//  JDTDMobClickEventTrackModel.h
//  JDTDAnalytics
//
//  Created by jd.huaxiaochun on 16/7/8.
//  Copyright © 2016年 jd.slipknot. All rights reserved.
//  事件统计跟踪类

#import "JDTDMobClickTrackBaseModel.h"

@interface JDTDMobClickEventTrackModel : JDTDMobClickTrackBaseModel

/*! @abstract 事件标识 */
@property (nonatomic, copy, readwrite) NSString *eventId;
/*! @abstract 分类标签 */
@property (nonatomic, copy, readwrite) NSString *label;
/*! @abstract 属性列表 */
@property (nonatomic, strong, readwrite) NSDictionary *attributes;
/*! @abstract 事件跟踪开始事件 */
@property (nonatomic, copy, readwrite) NSString *eventTrackBeginTime;
/*! @abstract 事件跟踪结束时间 */
@property (nonatomic, copy, readwrite) NSString *eventTrackEndTime;
/*! @abstract 事件停留时长 */
@property (nonatomic, copy, readwrite) NSString *eventStayTime;

@end
