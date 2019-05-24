//
//  JDTDMobClickTrackBaseModel.m
//  JDTDAnalytics
//
//  Created by jd.huaxiaochun on 16/7/8.
//  Copyright © 2016年 jd.slipknot. All rights reserved.
//

#import "JDTDMobClickTrackBaseModel.h"

/*! @abstract 跟踪Key */
static NSString * const kTrackIdKey = @"trackIdKey";
/*! @abstract 会话id */
static NSString * const kSessionId = @"sessionId";
/*! @abstract 业务id */
static NSString * const kBusinessId = @"businessId";

@interface JDTDMobClickTrackBaseModel ()

@end

@implementation JDTDMobClickTrackBaseModel

#pragma mark - NSCoding
/*!
 *  @brief 编码
 *
 *  @param aCoder 编码
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.trackId forKey:kTrackIdKey];
    [aCoder encodeObject:self.sessionId forKey:kSessionId];
    [aCoder encodeObject:self.businessId forKey:kBusinessId];
}

/*!
 *  @brief 解码
 *
 *  @param aDecoder 解码
 *
 *  @return instance
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.trackId = [aDecoder decodeObjectForKey:kTrackIdKey];
        self.sessionId = [aDecoder decodeObjectForKey:kSessionId];
        self.businessId = [aDecoder decodeObjectForKey:kBusinessId];
    }
    return self;
}

@end
