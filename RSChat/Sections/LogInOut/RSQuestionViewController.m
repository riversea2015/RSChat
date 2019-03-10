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
#import <WebKit/WebKit.h>
#import "RSChatMacro.h"

@interface RSQuestionViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *alertLab;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation RSQuestionViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavView];
    [self setupMainView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [_webView stopLoading];
}

#pragma mark - UI

- (void)setupNavView {
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, RSStatusBarH, RSScreenW, 44)];
    _titleLab.text = @"placeholder";
    _titleLab.font = [UIFont systemFontOfSize:18];
    _titleLab.textColor = [UIColor greenColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLab];
    
    if (self.titleText.length != 0) {
        self.titleLab.text = self.titleText;
    } else {
        self.titleLab.text = @"登录问题";
    }
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, RSStatusBarH, 80, 44);
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_backBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
}

- (void)setupMainView {
    
    if (self.url == nil) {
        self.url = [NSURL URLWithString:@"https://support.weixin.qq.com/security/readtemplate?t=page/login_optimized__w_index&lang=zh_CN"];
    }
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, RSNavBarH, RSScreenW, RSScreenH-RSNavBarH)];
    [self.view addSubview:_webView];
    
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

#pragma mark - Action

- (void)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - WKUIDelegate

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    return [[WKWebView alloc] init];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    completionHandler(YES);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    completionHandler(@"http");
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@",navigationAction.request.URL.absoluteString);

    decisionHandler(WKNavigationActionPolicyAllow);
    //decisionHandler(WKNavigationActionPolicyCancel);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);

    decisionHandler(WKNavigationResponsePolicyAllow);
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

@end
