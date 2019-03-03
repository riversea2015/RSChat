//
//  RSSignUpViewController.m
//  RSChat
//
//  Created by hehai on 15/12/22.
//  Copyright © 2015年 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSSignUpViewController.h"
#import "RSConformViewController.h"
#import "RSQuestionViewController.h"

@interface RSSignUpViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countryCode;
@property (weak, nonatomic) IBOutlet UITextField *telNumber;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@end


@implementation RSSignUpViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.telNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.telNumber.clearButtonMode = UITextFieldViewModeAlways;
}

#pragma mark - Private Method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)didInputTelNumber:(UITextField *)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}

- (IBAction)signUp:(UIButton *)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}

- (IBAction)cancel:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)checkInfo {
    if (self.telNumber.text.length == 0) {
        self.errorLabel.text = @"电话号码不能为空";
        return;
    }
    
    if (self.telNumber.text.length != 11) {
        self.errorLabel.text = @"请输入正确的电话号码";
        return;
    }
    
    self.errorLabel.text = nil;
    NSString *messageStr = [NSString stringWithFormat:@"我们将发送验证码短信到这个号码：+86 %@", self.telNumber.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    [alertView show];
}

- (IBAction)showRules:(id)sender {

    RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
    questionVC.url = [NSURL URLWithString:@"http://weixin.qq.com/cgi-bin/readtemplate?uin=&stype=&promote=&fr=&lang=zh_CN&ADTAG=&check=false&nav=faq&t=weixin_agreement&s=default"];
    questionVC.titleText = @"使用条款和隐私政策";
    
    [self presentViewController:questionVC animated:YES completion:nil];
}

#pragma mark - alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.view endEditing:YES];
    
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex == 0) {
        return;
    }
    
    RSConformViewController *conformVC = [[RSConformViewController alloc] init];
    conformVC.countryCode = self.countryCode.text;
    conformVC.telNum = self.telNumber.text;
    
    [self presentViewController:conformVC animated:YES completion:nil];
}

@end
