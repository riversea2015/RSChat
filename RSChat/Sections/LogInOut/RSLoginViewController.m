//
//  RSLoginViewController.m
//  RSChat
//
//  Created by hehai on 15/12/22.
//  Copyright (c) 2015年 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSLoginViewController.h"
#import "RSMainTabBarController.h"
#import "RSOtherLoginViewController.h"
#import "RSQuestionViewController.h"
#import "RSCountryListViewController.h"

@interface RSLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@end

@implementation RSLoginViewController

#pragma mark - Life Cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.telNumber.delegate = self;
    self.password.delegate = self;
    
    // 文本框中的 “x”
    self.telNumber.clearButtonMode = UITextFieldViewModeAlways;
    self.password.clearButtonMode = UITextFieldViewModeAlways;
    
    // 再次点击文本框时，清空之前的内容
//    self.telNumber.clearsOnBeginEditing = YES;
//    self.password.clearsOnBeginEditing = YES;
    
    [self registerNotification];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - Private Method

- (void)openKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.constraint.constant = 10;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)closeKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.constraint.constant = 80;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)didInputTelName:(UITextField *)sender {
    [self.password becomeFirstResponder];
}

- (IBAction)didInputPassword:(UITextField *)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}


- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}

- (void)checkInfo {
    NSString *telNum = self.telNumber.text;
    NSString *pwd = self.password.text;
    
    if (telNum.length == 0 || pwd.length == 0) {
        self.errorLabel.text = @"手机号码和密码不能为空！";
        return;
    }
    
    if ([telNum isEqualToString:@"11111111111"] && [pwd isEqualToString:@"123456"]) {
        RSMainTabBarController *mainVC = [[RSMainTabBarController alloc] init];
        [self presentViewController:mainVC animated:YES completion:nil];
    } else {
        self.errorLabel.text = @"手机号码或密码错误，请重新输入！";
    }
}

- (IBAction)chooseCountry:(UIButton *)sender {
    RSCountryListViewController *tempVC = [[RSCountryListViewController alloc] init];
    [self presentViewController:tempVC animated:YES completion:nil];
}

- (IBAction)cancel:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)moreOptions:(UIButton *)sender {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *freeze = [UIAlertAction actionWithTitle:@"紧急冻结" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
        questionVC.titleText = @"冻结账号";
        questionVC.url = [NSURL URLWithString:@"https://support.weixin.qq.com/security/readtemplate?t=account_frozen/w_intro&from=sec&type=frozen&wechat_real_lang=zh_CN&rid=55ee85fd37a18fe405355d10f63b95d0_1551668600"];
        [self presentViewController:questionVC animated:YES completion:nil];
    }];
    
    UIAlertAction *securityCenter = [UIAlertAction actionWithTitle:@"前往微信安全中心" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
        questionVC.titleText = @"微信安全中心";
        questionVC.url = [NSURL URLWithString:@"https://weixin110.qq.com/security/readtemplate?t=w_security_center_website/index&lang=zh_CN"];
        [self presentViewController:questionVC animated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertC addAction:freeze];
    [alertC addAction:securityCenter];
    [alertC addAction:cancel];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (IBAction)question:(id)sender {
    RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
    questionVC.titleText = @"找回账号密码";
    questionVC.url = [NSURL URLWithString:@"https://support.weixin.qq.com/cgi-bin/mmsupport-bin/readtemplate?t=find_password/w_index&lang=zh_CN"];
    [self presentViewController:questionVC animated:YES completion:nil];
}

#pragma mark - delegate

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.errorLabel.text = nil;
    if (textField == self.telNumber) {
        self.telNumber.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.telNumber.keyboardType = UIKeyboardTypeDefault;
    }
}

@end
