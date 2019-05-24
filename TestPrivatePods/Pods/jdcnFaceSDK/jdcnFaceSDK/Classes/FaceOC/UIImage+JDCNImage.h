//
//  UIImage+JDCNImage.h
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/24.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>

@interface UIImage (JDCNImage)

+ (UIImage*)imageFromCMSampleBuffer:(CMSampleBufferRef)frameBuffer;

/**
 *  cut sub-image with rect from srcImage
 */
+ (UIImage *) getSubImage:(UIImage *) srcImage rect:(CGRect)rect;

+ (UIImage *)jdcnReSizeImage:(UIImage *)image toSize:(CGSize)reSize;

- (UIImage *)jdcnFixOrientationRight;
@end
