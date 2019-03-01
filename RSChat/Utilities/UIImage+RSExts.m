//
//  UIImage+RSExts.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UIImage+RSExts.h"

@implementation UIImage (RSExts)

+ (UIImage *)imageName:(NSString *)name {
    if (!name) {
        return nil;
    }
    return [UIImage imageNamed:name];
}

+ (instancetype)originalImageWithName:(NSString *)imageName {
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
