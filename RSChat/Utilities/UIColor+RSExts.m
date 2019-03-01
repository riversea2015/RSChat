//
//  UIColor+RSExts.m
//  RSChat
//
//  Created by hehai on 2019/3/1.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UIColor+RSExts.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation UIColor (RSExts)

+ (UIColor *)colorWithRGB:(NSUInteger)rgb {
    return [UIColor colorWithRGB:rgb alpha:1.0f];
}

+ (UIColor*)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha {
    NSUInteger red = (rgb>>16) & 0xFF;
    NSUInteger green = (rgb>>8) & 0xFF;
    NSUInteger blue = rgb&0xFF;
    return RGBA(red, green, blue, alpha);
}

@end
