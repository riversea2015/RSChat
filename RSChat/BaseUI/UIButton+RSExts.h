//
//  UIButton+RSExts.h
//  RSChat
//
//  Created by hehai on 2019/3/1.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (RSExts)

+ (UIButton *)createBtnWithTitle:(NSString *)title
                      titleColor:(UIColor *)titleColor
                            font:(UIFont *)font
                         bgColor:(nullable UIColor *)bgColor
                          target:(id)target
                          action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
