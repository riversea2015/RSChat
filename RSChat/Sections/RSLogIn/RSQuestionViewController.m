//
//  RSQuestionViewController.m
//  RSChat
//
//  Created by hehai on 15/12/23.
//  Copyright © 2015年 hehai. All rights reserved.
//

#import "RSQuestionViewController.h"

@interface RSQuestionViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *questionView;

@end

@implementation RSQuestionViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    
    if (url == nil) {
        NSLog(@"域名有误");
        return;
    }
    self.questionView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.questionView loadRequest:request];
}

#pragma mark - Action

- (IBAction)goback:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - webView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {

}

@end
