//
//  RSNavigationController.m
//  RSChat
//
//  Created by hehai on 2019/3/6.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//

#import "RSNavigationController.h"

@interface RSNavigationController ()

@end

@implementation RSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navigationBar = self.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBarBackground"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
}

@end
