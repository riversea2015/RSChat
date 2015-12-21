//
//  RSMainTabBarController.m
//  RSChat
//
//  Created by hehai on 12/20/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMainTabBarController.h"

#import "RSHomeViewController.h"
#import "RSContactsViewController.h"
#import "RSDiscoverViewController.h"
#import "RSMeViewController.h"

#import "UIImage+RSOriginImage.h"

@interface RSMainTabBarController ()

@end

@implementation RSMainTabBarController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarAppearence];
    [self setAllChildViewControllers];
}

#pragma mark - Private Method

- (void)setBarAppearence {
    // 设置导航栏文字、左右按钮颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 设置 tabbarItem 的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0x09/255.0 green:0xbb/255.0 blue:0x07/255.0 alpha:1.0]} forState:UIControlStateSelected];
}

- (void)setAllChildViewControllers {
    RSHomeViewController *homeVC = [[RSHomeViewController alloc] init];
    [self setOneChildViewController:homeVC
                              image:[UIImage imageNamed:@"tabbar_mainframe"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_mainframeHL"]
                              title:@"我信"];
    
    RSContactsViewController *contactsVC = [[RSContactsViewController alloc] init];
    [self setOneChildViewController:contactsVC
                              image:[UIImage imageNamed:@"tabbar_contacts"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_contactsHL"]
                              title:@"通讯录"];
    
    RSDiscoverViewController *discoverVC = [[RSDiscoverViewController alloc] init];
    [self setOneChildViewController:discoverVC
                              image:[UIImage imageNamed:@"tabbar_discover"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_discoverHL"]
                              title:@"发现"];
    
    RSMeViewController *meVC = [[RSMeViewController alloc] init];
    [self setOneChildViewController:meVC
                              image:[UIImage imageNamed:@"tabbar_me"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_meHL"]
                              title:@"我"];
    
//    [self setSelectedIndex:0];
}

// 编码规范：有汉字的放最后边，如此处的 title
- (void)setOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {

    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    navi.tabBarItem.image = image;
    navi.tabBarItem.selectedImage = selectedImage;
    navi.title = title;
    navi.tabBarItem.badgeValue = nil;
    
    if ([viewController isKindOfClass:[RSHomeViewController class]]) {
        navi.tabBarItem.badgeValue = @"32";
    }
    
    [self addChildViewController:navi];
}

@end
