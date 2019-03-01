//
//  RSMainTabBarController.m
//  RSChat
//
//  Created by hehai on 12/20/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMainTabBarController.h"

#import "RSChatsViewController.h"
#import "RSContactsViewController.h"
#import "RSDiscoverViewController.h"
#import "RSMeViewController.h"

#import "UIImage+RSOriginImage.h"

#define ChatsTitle      NSLocalizedString(@"Chats", @"The title of the first tabbarItem.")
#define ContactsTitle   NSLocalizedString(@"Contacts", @"The title of the second tabbarItem.")
#define DiscoverTitle   NSLocalizedString(@"Discover", @"The title of the third tabbarItem.")
#define MineTitle       NSLocalizedString(@"Mine", @"The title of the fourth tabbarItem.")

@interface RSMainTabBarController ()

@end

@implementation RSMainTabBarController

#pragma mark - Life Cycle

/**
 初始化类：
    1.appearance：只要一个类遵守UIAppearance协议，就能获取全局的外观，如：UIView。
    2.获取项目中所有的tabBarItem外观标识（推荐，不会改变别人的）：
 UITabBarItem *item = [UITabBarItem appearance];
    3.获取当前类下面的所有tabBarItem外观标识：
 UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
 */
+ (void)initialize {
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:0x09/255.0 green:0xbb/255.0 blue:0x07/255.0 alpha:1.0];
    [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setAllChildViewControllers];
}

#pragma mark - Private Method

- (void)setAllChildViewControllers {
    RSChatsViewController *homeVC = [[RSChatsViewController alloc] init];
    [self setOneChildViewController:homeVC
                              image:[UIImage imageNamed:@"tabbar_mainframe"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_mainframeHL"]
                              title:ChatsTitle];
    
    RSContactsViewController *contactsVC = [[RSContactsViewController alloc] init];
    [self setOneChildViewController:contactsVC
                              image:[UIImage imageNamed:@"tabbar_contacts"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_contactsHL"]
                              title:ContactsTitle];
    
    RSDiscoverViewController *discoverVC = [[RSDiscoverViewController alloc] init];
    [self setOneChildViewController:discoverVC
                              image:[UIImage imageNamed:@"tabbar_discover"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_discoverHL"]
                              title:DiscoverTitle];
    
    RSMeViewController *meVC = [[RSMeViewController alloc] init];
    [self setOneChildViewController:meVC
                              image:[UIImage imageNamed:@"tabbar_mine"]
                      selectedImage:[UIImage imageWithOriginalName:@"tabbar_mineHL"]
                              title:MineTitle];
    
    [self setSelectedIndex:0];
}

/**
 * 编码规范：有汉字的放最后边，如此处的"title"（自定义方法时）
 */
- (void)setOneChildViewController:(UIViewController *)viewController
                            image:(UIImage *)image
                    selectedImage:(UIImage *)selectedImage
                            title:(NSString *)title {

    viewController.navigationItem.title = title;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    navi.tabBarItem.image = image;
    navi.tabBarItem.selectedImage = selectedImage;
    navi.title = title;
    navi.tabBarItem.badgeValue = nil;
    
    if ([viewController isKindOfClass:[RSChatsViewController class]]) {
        navi.tabBarItem.badgeValue = @"32";
    }
    
    [self addChildViewController:navi];
}

@end
