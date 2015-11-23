//
//  UIImage+RSSet.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "UIImage+RSSet.h"

@implementation UIImage (RSSet)

+ (UIImage *)imageName:(NSString *)name {
    if (!name) {
        return nil;
    }
    return [UIImage imageNamed:name];
}

@end
