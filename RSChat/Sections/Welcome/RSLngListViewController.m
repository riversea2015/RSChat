//
//  RSLngListViewController.m
//  RSChat
//
//  Created by hehai on 2019/3/1.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSLngListViewController.h"

@interface RSLngListViewController ()

@end

@implementation RSLngListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor yellowColor];
    cancelBtn.frame = CGRectMake(0, 100, 100, 50);
    [cancelBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
