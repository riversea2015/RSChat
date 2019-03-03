//
//  AppDelegate+Temp.m
//  RSChat
//
//  Created by hehai on 2019/3/3.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//

#import "AppDelegate+Temp.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@implementation AppDelegate (Temp)

/**
 临时放这里，之后会移除
 
 typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown          = -1,
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2,
 };
 */
- (void)beginMonitorNetStatus {
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
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NetWorkDidChange"
                                                            object:nil
                                                          userInfo:@{}];
        
    }];
    
    [manager startMonitoring];
}

@end
