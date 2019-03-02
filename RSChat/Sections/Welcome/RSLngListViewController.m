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
#import "RSChatMacro.h"
#import "UIButton+RSExts.h"
#import "UIColor+RSExts.h"

@interface RSLngListViewController ()

@end

@implementation RSLngListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initMainViews];
}

- (void)initNavBar {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RSScreenW, RSNavBarH)];
    navView.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.05];
    [self.view addSubview:navView];
    
    UIButton *cancelBtn = [UIButton createBtnWithTitle:NSLocalizedString(@"Cancel", nil)
                                            titleColor:[UIColor colorWithRGB:0x000000]
                                                  font:[UIFont systemFontOfSize:17]
                                               bgColor:nil
                                                target:self
                                                action:@selector(goBack)];
    cancelBtn.frame = CGRectMake(0, RSStatusBarH, 67, 44);
    [navView addSubview:cancelBtn];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((RSScreenW - 100)*0.5, RSStatusBarH + 4, 100, 36)];
    titleLab.font = [UIFont boldSystemFontOfSize:17];
    titleLab.text = NSLocalizedString(@"Language", nil);
    [navView addSubview:titleLab];
    
    UIButton *comfirmBtn = [UIButton createBtnWithTitle:NSLocalizedString(@"Done", nil)
                                            titleColor:[UIColor whiteColor]
                                                  font:[UIFont systemFontOfSize:16]
                                               bgColor:[UIColor colorWithRGB:0x07c160]
                                                target:self
                                                action:@selector(finishAction)];
    comfirmBtn.frame = CGRectMake(RSScreenW - 73, RSStatusBarH + 6, 57, 32);
    [navView addSubview:comfirmBtn];
}

- (void)initMainViews {
    
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishAction {
    // 保存并更新 UI 后
    
    [self goBack];
}

@end
