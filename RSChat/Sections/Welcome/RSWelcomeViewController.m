//
//  RSWelcomeViewController.m
//  RSChat
//
//  Created by hehai on 15/12/22.
//  Copyright © 2015年 hehai. All rights reserved.
//  Github: https://github.com/riversea2015
//

#import "RSWelcomeViewController.h"
#import "RSLoginViewController.h"
#import "RSSignUpViewController.h"

@interface RSWelcomeViewController ()

@end

@implementation RSWelcomeViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - Action

- (IBAction)changeLanguage:(UIButton *)sender {
    
}

- (IBAction)login:(UIButton *)sender {
    RSLoginViewController *loginVC = [[RSLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)signUp:(UIButton *)sender {
    RSSignUpViewController *signUpVC = [[RSSignUpViewController alloc] init];
    [self presentViewController:signUpVC animated:YES completion:nil];
}

@end
