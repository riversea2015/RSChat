//
//  UIImage+RSOriginImage.m
//  RSChat
//
//  Created by hehai on 12/20/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "UIImage+RSOriginImage.h"

@implementation UIImage (RSOriginImage)
+ (instancetype)imageWithOriginalName:(NSString *)imageName {
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
