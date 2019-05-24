//
//  UIImage+JDCNImage.m
//  JDCNSDK
//
//  Created by zhengxuexing on 2017/7/24.
//  Copyright © 2017年 JDJR. All rights reserved.
//

#import "UIImage+JDCNImage.h"


@implementation UIImage (JDCNImage)

+ (UIImage*)imageFromCMSampleBuffer:(CMSampleBufferRef)frameBuffer {
    UIImage * tmpImage = nil;
//    @autoreleasepool  // to avoid memory increasing caused by memory delay release
//    {
        CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(frameBuffer);
        CVPixelBufferLockBaseAddress(imageBuffer, 0);
        uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
        size_t width = CVPixelBufferGetWidth(imageBuffer);
        size_t height = CVPixelBufferGetHeight(imageBuffer);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace,
                                                     kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        CGImageRef newImage =  CGBitmapContextCreateImage(context);
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
/*
         UIImage * image = nil;
         
         if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
         image = [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationLeftMirrored];
         } else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
         image = [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationDownMirrored];
         } else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
         image = [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationUpMirrored];
         } else {
         image = [UIImage imageWithCGImage:newImage scale:1 orientation:UIImageOrientationRightMirrored];
         }
*/
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        
        tmpImage = [UIImage imageWithCGImage:newImage];
        CGImageRelease(newImage);
        
        //tmpImage = [UIImage fixOrientation:image]; // change image orientation
//    }
    CMSampleBufferInvalidate(frameBuffer);
    return tmpImage;
}



/**
 *  cut sub-image with rect from srcImage
 */
+ (UIImage *) getSubImage:(UIImage *) srcImage rect:(CGRect)rect {
    //    printf("func: %s called!\n", __func__);
    UIImage* smallImage = nil;
    
    @autoreleasepool {
        CGImageRef subImageRef = CGImageCreateWithImageInRect(srcImage.CGImage, rect);
        CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
        
        UIGraphicsBeginImageContext(smallBounds.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, smallBounds, subImageRef);
        UIGraphicsEndImageContext();
        
        smallImage = [UIImage imageWithCGImage:subImageRef];
        //        CGContextRelease(context);
        CGImageRelease(subImageRef);
    }
    
    return smallImage;
}

+ (UIImage *)jdcnReSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

- (UIImage *)jdcnFixOrientationRight {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformTranslate(transform, 0, self.size.width);
    transform = CGAffineTransformRotate(transform, -M_PI_2);

    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.height, self.size.width,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);

    CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);

    UIImage *img = [UIImage imageWithCGImage:cgimg];
    
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    //Mirror
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height); //创建矩形框
    UIGraphicsBeginImageContext(rect.size); //根据size大小创建一个基于位图的图形上下文
    CGContextRef newCtx = UIGraphicsGetCurrentContext(); //获取当前quartz 2d绘图环境
    CGContextClipToRect(newCtx, rect); //设置当前绘图环境到矩形框
    
    CGContextRotateCTM(newCtx, M_PI); //旋转180度
    CGContextTranslateCTM(newCtx, -rect.size.width, -rect.size.height); //平移, 这里是平移坐标系,跟平移图形是一个道理
    
    CGContextDrawImage(newCtx, rect, img.CGImage); //绘图
    
    UIImage *flip = UIGraphicsGetImageFromCurrentImageContext(); //获得图片
    
    UIGraphicsEndImageContext();

    return flip;
}

@end
