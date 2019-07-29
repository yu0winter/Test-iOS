//
//  UIColor+Extend.h
//  Pods
//
//  Created by zhongyafeng on 2019/6/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extend)

/*
 hexColor: (!7/!9:blackColor)
 */
+ (UIColor *)jrColorWithHex:(NSString *)hexColor;//7 9(argb)
+ (UIColor *)jrColorWithHex:(NSString *)hexColor withAlpha:(CGFloat)alpha_;//7
+ (UIColor *)jrColor:(UIColor *)color_ withAlpha:(CGFloat)alpha_;

//混合颜色,ratio 0~1
+ (UIColor *)jrMixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio;

// 根据Hex设置颜色
+ (UIColor *)colorWithRGBHex:(uint32_t)rgbValue;
+ (UIColor *)colorWithRGBHex:(uint32_t)rgbValue alpha:(CGFloat)alpha;

//随机色
+ (UIColor *)jrRandomColor;

//判断颜色字符串是否有效
+ (BOOL)isValidColor:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
