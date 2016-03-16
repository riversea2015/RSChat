//
//  UIViewController+RSExts.m
//  RSChat
//
//  Created by hehai on 11/21/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "UIViewController+RSExts.h"
#import <objc/runtime.h>

#warning runtime learning 运行时测试
/**
 仅供测试：运行时
 1.运行时添加属性：用于保存调用此方法的类
 2.运行时交换方法：系统定义的 viewDidLoad 和 自定义的 hehaiViewDidLoad
 */

@implementation UIViewController (RSExts)

// 1.添加属性
- (void)setUserInfor:(NSNumber *)userInfor {
    objc_setAssociatedObject(self, _cmd, userInfor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    objc_setAssociatedObject(self, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
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

//load方法会在类第一次加载的时候被调用
//调用的时间比较靠前，适合在这个方法里做方法交换
/*
+ (void)load{
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(viewWillAppear:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(swiz_viewWillAppear:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}
- (void)swiz_viewWillAppear:(BOOL)animated{
    //这时候调用自己，看起来像是死循环
    //但是其实自己的实现已经被替换了
    [self swiz_viewWillAppear:animated];
    NSLog(@"swizzle");
}
*/

@end
