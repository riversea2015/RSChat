//
//  RSCountryListViewController.m
//  RSChat
//
//  Created by hehai on 2019/3/4.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSCountryListViewController.h"
#import "RSChatMacro.h"
#import "UIButton+RSExts.h"
#import "UIColor+RSExts.h"

@interface RSCountryListViewController ()

@end

@implementation RSCountryListViewController

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
    titleLab.text = NSLocalizedString(@"Region", nil);
    [navView addSubview:titleLab];
}

- (void)initMainViews {
    
    
}

- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
