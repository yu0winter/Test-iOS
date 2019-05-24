//
//  JDCNAnalyticsRequest.h
//  Pods
//
//  Created by huaxiaochun on 2018/7/12.
//

#import "JDTDMobClickEventTrackModel.h"

@interface JDCNAnalyticsRequest : NSObject

+ (JDCNAnalyticsRequest *)sharedInstance;
- (void)requestAnalyticsWithEventTrackModel:(JDTDMobClickEventTrackModel *)eventModel;

@end
