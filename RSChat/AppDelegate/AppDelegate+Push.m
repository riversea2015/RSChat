//
//  AppDelegate+Push.m
//  RSChat
//
//  Created by hehai on 2019/3/3.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//

#import "AppDelegate+Push.h"
#import "APService.h"

@implementation AppDelegate (Push)

#pragma mark - Public Method

- (void)handleAPNsWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    
    // 1.Register JPush
    [self registerJPushWithOptions:launchOptions];
    
    // 2.Handle badgeNum
    NSInteger badgeNum = application.applicationIconBadgeNumber;
    badgeNum--;
    if (badgeNum > 0) {
        [application setApplicationIconBadgeNumber:0];
        [application setApplicationIconBadgeNumber:badgeNum];
    }
}

#pragma mark - Private Method

- (void)registerJPushWithOptions:(NSDictionary *)launchOptions {
    // 设置JPush
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
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

@end
