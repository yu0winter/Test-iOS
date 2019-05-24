//
//  JDTDMobClickTrackBaseModel.h
//  JDTDAnalytics
//
//  Created by jd.huaxiaochun on 16/7/8.
//  Copyright © 2016年 jd.slipknot. All rights reserved.
//  统计跟踪基类

#import <Foundation/Foundation.h>

@interface JDTDMobClickTrackBaseModel : NSObject <NSCoding>

/*! @abstract 跟踪唯一标识*/
@property (nonatomic, copy, readwrite) NSString *trackId;
/*! @abstract 会话唯一标识 */
@property (nonatomic, copy, readwrite) NSString *sessionId;
/*! @abstract 业务唯一标识 */
@property (nonatomic, copy, readwrite) NSString *businessId;

@end
