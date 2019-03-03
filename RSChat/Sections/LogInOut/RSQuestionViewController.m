//
//  RSQuestionViewController.m
//  RSChat
//
//  Created by hehai on 15/12/23.
//  Copyright © 2015年 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSQuestionViewController.h"
#import "MBProgressHUD.h"

@interface RSQuestionViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *questionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UILabel *alertLabel;

@end

@implementation RSQuestionViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.titleText.length != 0) {
        self.titleLabel.text = self.titleText;
    } else {
        self.titleLabel.text = @"登录问题";
    }
    
    if (self.url == nil) {
        self.url = [NSURL URLWithString:@"https://support.weixin.qq.com/security/readtemplate?t=page/login_optimized__w_index&lang=zh_CN"];
    }

    self.questionView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.questionView loadRequest:request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.questionView stopLoading];
}

#pragma mark - Action

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - webView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 开始加载动画，设置一个超时，如果超时会弹出警告，同时停止加载
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    hud.color = [UIColor lightGrayColor];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 移除动画
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 移除动画
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end
