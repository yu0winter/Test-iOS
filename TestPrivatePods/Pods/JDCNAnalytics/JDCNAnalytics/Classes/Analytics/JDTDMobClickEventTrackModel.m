//
//  JDTDMobClickEventTrackModel.m
//  JDTDAnalytics
//
//  Created by jd.huaxiaochun on 16/7/8.
//  Copyright © 2016年 jd.slipknot. All rights reserved.
//

#import "JDTDMobClickEventTrackModel.h"

/*! @abstract 事件Id key */
static NSString * const kEventIdKey = @"eventIdKey";
/*! @abstract 事件标签 key */
static NSString * const kLabelKey = @"labelKey";
/*! @abstract 事件属性 key */
static NSString * const kAttributesKey = @"attributesKey";
/*! @abstract 事件跟踪起始时间 key */
static NSString * const kEventTrackBeginTimeKey = @"eventTrackBeginTimeKey";
/*! @abstract 事件跟踪结束时间 key */
static NSString * const kEventTrackEndTimeKey = @"eventTrackEndTimeKey";
/*! @abstract 事件跟踪停留时间 key */
static NSString * const kEventStayTimeKey = @"eventStayTimeKey";

@interface JDTDMobClickEventTrackModel ()

@end

@implementation JDTDMobClickEventTrackModel

#pragma mark - NSCoding
/*!
 *  @brief 编码
 *
 *  @param aCoder 编码
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.eventId forKey:kEventIdKey];
    [aCoder encodeObject:self.label forKey:kLabelKey];
    [aCoder encodeObject:self.attributes forKey:kAttributesKey];
    [aCoder encodeObject:self.eventTrackBeginTime forKey:kEventTrackBeginTimeKey];
    [aCoder encodeObject:self.eventTrackEndTime forKey:kEventTrackEndTimeKey];
    [aCoder encodeObject:self.eventStayTime forKey:kEventStayTimeKey];
}

/*!
 *  @brief 解码
 *
 *  @param aDecoder 解码
 *
 *  @return instance
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.eventId = [aDecoder decodeObjectForKey:kEventIdKey];
        self.label = [aDecoder decodeObjectForKey:kLabelKey];
        self.attributes = [aDecoder decodeObjectForKey:kAttributesKey];
        self.eventTrackBeginTime = [aDecoder decodeObjectForKey:kEventTrackBeginTimeKey];
        self.eventTrackEndTime = [aDecoder decodeObjectForKey:kEventTrackEndTimeKey];
        self.eventStayTime = [aDecoder decodeObjectForKey:kEventStayTimeKey];
    }
    return self;
}

/*!
 *  @brief 描述
 *
 *  @return str
 */
- (NSString *)description{
    return [NSString stringWithFormat:@"trackId = %@ sessionId = %@ businessId = %@ eventId = %@ eventTrackBeginTime = %@ eventTrackEndTime = %@ eventStayTime = %@",self.trackId, self.sessionId, self.businessId, self.eventId, self.eventTrackBeginTime, self.eventTrackEndTime, self.eventStayTime];
}
@end
