//
//  AppDelegate+Weex.m
//  RSChat
//
//  Created by hehai on 2019/3/11.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "AppDelegate+Weex.h"
#import <WeexSDK/WeexSDK.h>
#import "RSWeexImgLoader.h"

@implementation AppDelegate (Weex)

- (void)registerWeex {
    // App configuration
    [WXAppConfiguration setAppGroup:@"Your app group"];
    [WXAppConfiguration setAppName:@"RSChat"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //Initialize WeexSDK
    [WXSDKEngine initSDKEnvironment];
    
    //Register custom modules and components, optional.
//    [WXSDKEngine registerComponent:@"myview" withClass:[MyViewComponent class]];
//    [WXSDKEngine registerModule:@"mymodule" withClass:[MyWeexModule class]];
    
    //Register the implementation of protocol, optional.
//    [WXSDKEngine registerHandler:[WXAppNavigationImpl new] withProtocol:@protocol(WXNavigationProtocol)];
    
    //Set the log level, optional
    [WXLog setLogLevel: WXLogLevelWarning];
    
    [WXSDKEngine registerHandler:[RSWeexImgLoader new] withProtocol:@protocol(WXImgLoaderProtocol)];
}

@end
