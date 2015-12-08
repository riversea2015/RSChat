//
//  AppDelegate.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "AppDelegate.h"
#import "RSHomeViewController.h"
#import "RSContactsViewController.h"
#import "RSDiscoverViewController.h"
#import "RSMeViewController.h"

#import "APService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setContentVC];

    [self registerJPushWithOptions:launchOptions];
    
    NSInteger badgeNum = application.applicationIconBadgeNumber;
    badgeNum--;
    if (badgeNum > 0) {
        [application setApplicationIconBadgeNumber:0];
        [application setApplicationIconBadgeNumber:badgeNum];
    }
    
    return YES;
}

/**
 * 配置JPush
 */
- (void)registerJPushWithOptions:(NSDictionary *)launchOptions {
    // 设置JPush
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    [APService setupWithOption:launchOptions];
}

- (void)setContentVC {
    // 设置导航栏文字、左右按钮颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 设置 tabbarItem 的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0x09/255.0 green:0xbb/255.0 blue:0x07/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RSHomeViewController *homeController = [[RSHomeViewController alloc] init];
    RSContactsViewController *contactsController = [[RSContactsViewController alloc] init];
    RSDiscoverViewController *discoverController = [[RSDiscoverViewController alloc] init];
    RSMeViewController *meController = [[RSMeViewController alloc] init];
    
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeController];
    UINavigationController *contactsNavi = [[UINavigationController alloc] initWithRootViewController:contactsController];
    UINavigationController *discoverNavi = [[UINavigationController alloc] initWithRootViewController:discoverController];
    UINavigationController *meNavi = [[UINavigationController alloc] initWithRootViewController:meController];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"微信" image:[UIImage imageNamed:@"tabbar_mainframe"] tag:0];
    // 选中时为图片本身颜色 : UIImageRenderingModeAlwaysOriginal
    homeItem.selectedImage = [[UIImage imageNamed:@"tabbar_mainframeHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *contactsItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@"tabbar_contacts"] tag:1];
    contactsItem.selectedImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *discoverItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] tag:2];
    discoverItem.selectedImage = [[UIImage imageNamed:@"tabbar_discoverHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *meItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_me"] tag:3];
    meItem.selectedImage = [[UIImage imageNamed:@"tabbar_meHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    homeNavi.tabBarItem = homeItem;
    contactsNavi.tabBarItem = contactsItem;
    discoverNavi.tabBarItem = discoverItem;
    meNavi.tabBarItem = meItem;

    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    [tabbarController setViewControllers:@[homeNavi, contactsNavi, discoverNavi, meNavi]];
    
    [tabbarController setSelectedIndex:0];
    
    NSInteger badgeNum0 = 32;
    UITabBarItem * item=[tabbarController.tabBar.items objectAtIndex:0];
    item.badgeValue=[NSString stringWithFormat:@"%ld",badgeNum0];
    
    self.window.rootViewController = tabbarController;
    
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 验证URL Scheme的方法

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // 1.所有知道我URL Scheme的应用都可以访问我的这个应用
    NSLog(@"Calling Application Bundle ID:%@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query:%@", [url query]);
    return YES;
    
    // 2.只有我指定的应用（用Bundle ID区分）可以访问我的这个应用，
    // Check the calling application Bundle ID
//        if ([sourceApplication isEqualToString:@"com.hehai.Demo-URL-Scheme"]) {
//            NSLog(@"Calling Application Bundle ID:%@", sourceApplication);
//            NSLog(@"URL scheme:%@", [url scheme]);
//            NSLog(@"URL query:%@", [url query]);
//            return YES;
//        }
//        return NO;
    
}

#pragma mark - 以下为JPush必须

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    [APService handleRemoteNotification:userInfo];
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSInteger badgeNum = application.applicationIconBadgeNumber;
    badgeNum--;
    if (badgeNum > 0) {
        [application setApplicationIconBadgeNumber:0];
        [application setApplicationIconBadgeNumber:badgeNum];
    }
}

@end
