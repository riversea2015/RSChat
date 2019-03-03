//
//  AppDelegate+IM.m
//  RSChat
//
//  Created by hehai on 2019/3/3.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//

#import "AppDelegate+IM.h"

@implementation AppDelegate (IM)

- (void)handleIMLogicWithApplication:(UIApplication *)application options:(NSDictionary *)launchOptions {
    
    // 1.IM Key
    if (NSClassFromString(@"RSIMMacro")) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id appKeyForIM = [NSClassFromString(@"RSIMMacro") performSelector:NSSelectorFromString(@"appKeyForIM")];
        NSLog(@"%@", appKeyForIM);
#pragma clang diagnostic pop
    }
    
    // 2.
}

@end
