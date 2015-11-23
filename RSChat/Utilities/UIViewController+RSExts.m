//
//  UIViewController+RSExts.m
//  RSChat
//
//  Created by hehai on 11/21/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "UIViewController+RSExts.h"
#import <objc/runtime.h>

/**
 仅供测试：运行时
 1.运行时添加属性：用于保存调用此方法的类
 2.运行时交换方法：系统定义的 viewDidLoad 和 自定义的 hehaiViewDidLoad
 */

@implementation UIViewController (RSExts)

// 1.添加属性
- (void)setUserInfor:(NSNumber *)userInfor {
    objc_setAssociatedObject(self, _cmd, userInfor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)userInfor {
    NSNumber *userInfor = objc_getAssociatedObject(self, @selector(setUserInfor:));
    return userInfor;
}

// 2.交换方法
+ (void)load {
    Method orgin = class_getInstanceMethod([UIViewController class], @selector(viewDidLoad));
    Method target = class_getInstanceMethod([UIViewController class], @selector(hehaiViewDidLoad));
    method_exchangeImplementations(target, orgin);
}

- (void)hehaiViewDidLoad {
    NSLog(@"hehaiViewDidLoad get called");
    
    [self hehaiViewDidLoad];
    
    NSLog(@"%@",NSStringFromClass([self class]));
}

@end
