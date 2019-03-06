//
//  UIButton+RSExts.m
//  RSChat
//
//  Created by hehai on 2019/3/1.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UIButton+RSExts.h"

@implementation UIButton (RSExts)

+ (UIButton *)createBtnWithTitle:(NSString *)title
                      titleColor:(UIColor *)titleColor
                            font:(UIFont *)font
                         bgColor:(nullable UIColor *)bgColor
                          target:(id)target
                          action:(SEL)action {
    
    UIButton *oneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [oneBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [oneBtn setTitle:title forState:UIControlStateNormal];
    oneBtn.titleLabel.font = font;
    oneBtn.layer.cornerRadius = 5;
    if (bgColor) {
        oneBtn.backgroundColor = bgColor;
    }
    [oneBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return oneBtn;
}

@end
