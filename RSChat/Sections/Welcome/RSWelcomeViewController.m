//
//  RSWelcomeViewController.m
//  RSChat
//
//  Created by hehai on 15/12/22.
//  Copyright © 2015年 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSWelcomeViewController.h"
#import "RSLoginViewController.h"
#import "RSSignUpViewController.h"
#import "RSLngListViewController.h"

#import <Masonry/Masonry.h>

#import "RSChatMacro.h"
#import "UIColor+RSExts.h"
#import "UIButton+RSExts.h"

@interface RSWelcomeViewController ()

@end

@implementation RSWelcomeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
}

#pragma mark - UI

- (void)setupMainView {
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *bgImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getLaunchImageName]]];
    bgImgV.frame = self.view.bounds;
    [self.view addSubview:bgImgV];
    
    UIButton *lngBtn = [UIButton createBtnWithTitle:NSLocalizedString(@"LNG", nil)
                                         titleColor:[UIColor lightGrayColor]
                                               font:[UIFont systemFontOfSize:16]
                                            bgColor:nil
                                             target:self
                                             action:@selector(changeLanguage:)];
    [self.view addSubview:lngBtn];
    [lngBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(40);
    }];
    
    UIButton *logInBtn = [UIButton createBtnWithTitle:NSLocalizedString(@"Log In", nil)
                                           titleColor:[UIColor colorWithRGB:0x07c160]
                                                 font:[UIFont boldSystemFontOfSize:18]
                                              bgColor:[UIColor whiteColor]
                                               target:self
                                               action:@selector(logIn:)];
    [self.view addSubview:logInBtn];
    [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake((RSScreenW - 60)*0.5, 47));
        make.bottom.equalTo(self.view).offset(-20-kBottomH);
    }];
    
    UIButton *registerBtn = [UIButton createBtnWithTitle:NSLocalizedString(@"Sign Up", nil)
                                              titleColor:[UIColor whiteColor]
                                                    font:[UIFont boldSystemFontOfSize:18]
                                                 bgColor:[UIColor colorWithRGB:0x07c160]
                                                  target:self
                                                  action:@selector(signUp:)];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake((RSScreenW - 60)*0.5, 47));
        make.bottom.equalTo(self.view).offset(-20-kBottomH);
    }];
}

#pragma mark - Action

- (void)changeLanguage:(UIButton *)sender {
    RSLngListViewController *lngVC = [[RSLngListViewController alloc] init];
    [self presentViewController:lngVC animated:YES completion:nil];
}

- (void)logIn:(UIButton *)sender {
    RSLoginViewController *loginVC = [[RSLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)signUp:(UIButton *)sender {
    RSSignUpViewController *signUpVC = [[RSSignUpViewController alloc] init];
    [self presentViewController:signUpVC animated:YES completion:nil];
}

#pragma mark - Tools

- (NSString *)getLaunchImageName {
    
    CGSize viewSize = [UIApplication sharedApplication].keyWindow.bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

@end
