//
//  RSBuyViewController.m
//  RSChat
//
//  Created by hehai on 12/8/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSBuyViewController.h"

@interface RSBuyViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation RSBuyViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"京东购物";
    
    NSString *urlStr = @"http://wq.jd.com/";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:request];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

#pragma mark - webView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%s", __func__);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
    [self showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
    [self hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%s - 购物页面加载失败:%@", __func__, error.userInfo);
    [self hideHUD];
}

@end
