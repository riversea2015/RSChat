//
//  AppDelegate.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "AppDelegate.h"
#import <MLTransition/MLTransition.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#import "RSMainTabBarController.h"
#import "APService.h"

#import "RSWelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Entrance

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 启用手势滑屏(必须写在 添加VC 之前，否则没有效果)
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    
    [self setContentVC];
    
    // JPush注册
    [self registerJPushWithOptions:launchOptions];
    
    NSInteger badgeNum = application.applicationIconBadgeNumber;
    badgeNum--;
    if (badgeNum > 0) {
        [application setApplicationIconBadgeNumber:0];
        [application setApplicationIconBadgeNumber:badgeNum];
    }
    
    // 打开网络监测
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未识别的网络
                NSLog(@"网络状态未知");
                //
                break;
            case AFNetworkReachabilityStatusNotReachable: // 不可达网络
                NSLog(@"网络未连接");
                // alertView 提示网络无法连接，停止发送请求
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 2G, 3G, 4G...的网络
                NSLog(@"2G, 3G, 4G...的网络");
                // alertView 提示当前网络，询问是否同意使用：是，继续发送请求；否，终止请求。
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // wifi打开 或 WiFi和移动网络同时打开
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkDidChange" object:nil userInfo:@{}];
        
    }];
    
    [manager startMonitoring];
    
    return YES;
}

/**
 typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown          = -1,
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2,
 };
 */

#pragma mark - 构造Crash

- (void)crash{
    NSArray *arr = [NSArray array];
    [arr objectAtIndex:1000];
}

#pragma mark - Private Method

- (void)setContentVC {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSInteger runCount = [ud integerForKey:@"runCount"];
//    if (runCount == 0) {
//
//        [ud setInteger:++runCount forKey:@"runCount"];
//        [ud synchronize];
    
        RSWelcomeViewController *welcomeController = [[RSWelcomeViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:welcomeController];
        self.window.rootViewController = navi;
        [self.window makeKeyAndVisible];
        return;
//    }

    RSMainTabBarController *mainTabBarController = [[RSMainTabBarController alloc] init];
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];
}

- (void)setWelcomeController {
    // liuyong
}

#pragma mark - 配置 JPush

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

#pragma mark -

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
