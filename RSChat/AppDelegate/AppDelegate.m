//
//  AppDelegate.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "AppDelegate.h"
#import "RSMainTabBarController.h"
#import "APService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - LifeCycle >> 1

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

#pragma mark - Private Method

- (void)setContentVC {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RSMainTabBarController *mainTabBarController = [[RSMainTabBarController alloc] init];
    
#warning TODO 增加首次打开软件时的登陆/注册页面。。。
    
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];
}

#pragma mark - 配置 JPush

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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken:%@", deviceToken);
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

#pragma mark - LifeCycle >> 2

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

#pragma mark - URL Scheme

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

@end
