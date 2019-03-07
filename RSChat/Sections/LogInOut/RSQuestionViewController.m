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

@interface RSQuestionViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *questionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) UILabel *alertLabel;

@end

@implementation RSQuestionViewController

#pragma mark - Life Cycle

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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // ...
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideHUD];
}

@end
