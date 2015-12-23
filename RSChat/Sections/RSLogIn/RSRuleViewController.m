//
//  RSRuleViewController.m
//  RSChat
//
//  Created by hehai on 15/12/23.
//  Copyright © 2015年 hehai. All rights reserved.
//

#import "RSRuleViewController.h"

@interface RSRuleViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation RSRuleViewController

#pragma mark - delegate

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://weixin.qq.com/cgi-bin/readtemplate?uin=&stype=&promote=&fr=&lang=zh_CN&ADTAG=&check=false&nav=faq&t=weixin_agreement&s=default"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - N
- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
