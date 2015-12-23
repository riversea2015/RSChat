//
//  RSSignUpViewController.m
//  RSChat
//
//  Created by hehai on 15/12/22.
//  Copyright © 2015年 hehai. All rights reserved.
//

#import "RSSignUpViewController.h"
#import "RSConformViewController.h"
#import "RSRuleViewController.h"

@interface RSSignUpViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation RSSignUpViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    // 以上可以确保到这里的一定是11位数字（键盘已经固定为 数字键盘）
    
    self.errorLabel.text = nil;
    NSString *messageStr = [NSString stringWithFormat:@"我们将发送验证码短信到这个号码：+86 %@", self.telNumber.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认手机号码" message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    [alertView show];
}

- (IBAction)showRules:(id)sender {
    RSRuleViewController *ruleVC = [[RSRuleViewController alloc] init];
    [self presentViewController:ruleVC animated:YES completion:nil];
}

#pragma mark - alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.view endEditing:YES];
    
    NSLog(@"%ld", buttonIndex);
    if (buttonIndex == 0) {
        return;
    }
    
    RSConformViewController *conformVC = [[RSConformViewController alloc] init];
    [self presentViewController:conformVC animated:YES completion:nil];
}

@end
