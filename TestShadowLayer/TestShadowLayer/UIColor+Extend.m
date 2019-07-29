//
//  UIColor+Extend.m
//  Pods
//
//  Created by zhongyafeng on 2019/6/5.
//

#import "UIColor+Extend.h"

@implementation UIColor (Extend)

+ (UIColor *)jrColorWithHex:(NSString *)hexColor
{
    if (hexColor.length == 7)
    {
        return [self jrColorWithHex:hexColor withAlpha:1.0f];
    }
    else if (hexColor.length == 9)
    {
        unsigned int red, green, blue, al;
        NSRange range;
        range.length = 2;
        
        range.location = 1;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&al];
        range.location = 3;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 5;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 7;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        return [self colorWithRed:(CGFloat)(red/255.0f) green:(CGFloat)(green/255.0f) blue:(CGFloat)(blue/255.0f) alpha:(CGFloat)al/255.0f];
    }
    else
    {
        return [UIColor blackColor];
    }
    
}

+ (UIColor *)jrColor:(UIColor *)color_ withAlpha:(CGFloat)alpha_
{
    UIColor *uicolor = color_;
    CGColorRef colorRef = [uicolor CGColor];
    
    size_t numComponents = CGColorGetNumberOfComponents(colorRef);
    
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(colorRef);
        red = components[0];
        green = components[1];
        blue = components[2];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha_];
}

+ (UIColor *)jrColorWithHex:(NSString *)hexColor withAlpha:(CGFloat)alpha_
{
    if (hexColor.length != 7){
        return [UIColor blackColor];
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(CGFloat)(red/255.0f) green:(CGFloat)(green/255.0f) blue:(CGFloat)(blue/255.0f) alpha:alpha_];
}

//混合颜色,ratio 0~1
+ (UIColor *)jrMixColor1:(UIColor*)color1 color2:(UIColor *)color2 ratio:(CGFloat)ratio{
    
    if(ratio > 1){
        ratio = 1;
    }
    const CGFloat *components1 = CGColorGetComponents(color1.CGColor);
    const CGFloat *components2 = CGColorGetComponents(color2.CGColor);
    CGFloat r = components1[0]*ratio + components2[0]*(1-ratio);
    CGFloat g = components1[1]*ratio + components2[1]*(1-ratio);
    CGFloat b = components1[2]*ratio + components2[2]*(1-ratio);
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

+ (UIColor *)jrRandomColor{
    return [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1.0f];
}

+ (BOOL)isValidColor:(NSString *)color {
    if (color&&[color isKindOfClass:[NSString class]]){
        if (color.length==7||color.length==9) {
            return YES;
        }
    }
    return NO;
}

+ (UIColor *)colorWithRGBHex:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)colorWithRGBHex:(uint32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:alpha];
}

@end
