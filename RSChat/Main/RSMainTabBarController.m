//
//  RSMainTabBarController.m
//  RSChat
//
//  Created by hehai on 12/20/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSMainTabBarController.h"
#import "RSNavigationController.h"
#import "RSChatsViewController.h"
#import "RSContactsViewController.h"
#import "RSDiscoverViewController.h"
#import "RSMeViewController.h"

#import "UIImage+RSExts.h"
#import "RSChatMacro.h"

@interface RSMainTabBarController ()

@end


@implementation RSMainTabBarController

#pragma mark - Life Cycle

+ (void)initialize {
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:0x09/255.0 green:0xbb/255.0 blue:0x07/255.0 alpha:1.0];
    [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
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
                      selectedImage:[UIImage originalImageWithName:@"tabbar_mainframeHL"]
                              title:ChatsTitle];
    
    RSContactsViewController *contactsVC = [[RSContactsViewController alloc] init];
    [self setOneChildViewController:contactsVC
                              image:[UIImage imageNamed:@"tabbar_contacts"]
                      selectedImage:[UIImage originalImageWithName:@"tabbar_contactsHL"]
                              title:ContactsTitle];
    
    RSDiscoverViewController *discoverVC = [[RSDiscoverViewController alloc] init];
    [self setOneChildViewController:discoverVC
                              image:[UIImage imageNamed:@"tabbar_discover"]
                      selectedImage:[UIImage originalImageWithName:@"tabbar_discoverHL"]
                              title:DiscoverTitle];
    
    RSMeViewController *meVC = [[RSMeViewController alloc] init];
    [self setOneChildViewController:meVC
                              image:[UIImage imageNamed:@"tabbar_mine"]
                      selectedImage:[UIImage originalImageWithName:@"tabbar_mineHL"]
                              title:MineTitle];
    
    [self setSelectedIndex:0];
}

- (void)setOneChildViewController:(UIViewController *)viewController
                            image:(UIImage *)image
                    selectedImage:(UIImage *)selectedImage
                            title:(NSString *)title {

    viewController.navigationItem.title = title;
    
    RSNavigationController *navi = [[RSNavigationController alloc] initWithRootViewController:viewController];
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
