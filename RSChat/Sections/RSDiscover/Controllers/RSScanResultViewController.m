//
//  RSScanResultViewController.m
//  RSChat
//
//  Created by hehai on 12/4/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSScanResultViewController.h"

@interface RSScanResultViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation RSScanResultViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    NSLog(@"扫描的链接是：%@", self.openStr);
    
    // 测试用例：https://www.baidu.com/
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    
#warning TODO 实际用例：如下，实际跳转时，还需要进行设置。。。
//    NSURL *url = [NSURL URLWithString:self.openStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate

/*
 Sent before a web view begins loading a frame.
 Return YES if the web view should begin loading content; otherwise, NO.
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 此处添加过滤条件。。。
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载。。。");
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:view.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:self.activityIndicator];
    
    [self.activityIndicator startAnimating];
}

// 加载完成或加载失败时都会退出加载页面

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载失败：%@", error.userInfo);
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载成功！！！");
    
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

#pragma mark - setter getter


@end
