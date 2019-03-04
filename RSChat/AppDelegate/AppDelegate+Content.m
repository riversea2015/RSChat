//
//  AppDelegate+Content.m
//  RSChat
//
//  Created by hehai on 2019/3/3.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//

#import "AppDelegate+Content.h"
#import "RSMainTabBarController.h"
#import "RSWelcomeViewController.h"

#import <MLTransition/MLTransition.h>

@implementation AppDelegate (Content)

- (void)setupContentVC {
    
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger runCount = [ud integerForKey:@"runCount"];
    if (runCount == 0) {
    
        [ud setInteger:++runCount forKey:@"runCount"];
        [ud synchronize];
        
        RSWelcomeViewController *welcomeController = [[RSWelcomeViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:welcomeController];
        self.window.rootViewController = navi;
        [self.window makeKeyAndVisible];
        return;
    }
    
    RSMainTabBarController *mainTabBarController = [[RSMainTabBarController alloc] init];
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];
}


@end
