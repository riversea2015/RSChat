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

@end

@implementation RSScanResultViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    // 测试：暂时指定为百度
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];//self.openStr];
#warning TODO 实际跳转时，用下边的，但需要进行设置。。。
//    NSURL *url = [NSURL URLWithString:self.openStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

#pragma mark - UIWebViewDelegate

    // 设置Auth授权是使用此方法
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    return YES;
//}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"开始加载。。。");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载失败：%@", error.userInfo);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"加载成功！！！");
}


@end
