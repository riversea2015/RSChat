//
//  RSBuyViewController.m
//  RSChat
//
//  Created by hehai on 12/8/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSBuyViewController.h"
#import "MBProgressHUD.h"

@interface RSBuyViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation RSBuyViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    [self startProgressAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%s", __func__);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"购物页面加载失败:%@", error.userInfo);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - Private method

- (void)startProgressAnimation {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    hud.labelColor = [UIColor whiteColor];
    hud.xOffset = 0;
    hud.yOffset = 0;
    hud.color = [UIColor grayColor];
}

@end
