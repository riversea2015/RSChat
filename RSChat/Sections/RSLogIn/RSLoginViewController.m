//
//  RSLoginViewController.m
//  RSChat
//
//  Created by hehai on 15/12/22.
//  Copyright (c) 2015年 hehai. All rights reserved.
//

#import "RSLoginViewController.h"
#import "RSMainTabBarController.h"
#import "RSOtherLoginViewController.h"
#import "RSQuestionViewController.h"

@interface RSLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;

@end

@implementation RSLoginViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.telNumber.delegate = self;
    self.password.delegate = self;
    
    // 文本框中的 “x”
    self.telNumber.clearButtonMode = UITextFieldViewModeAlways;
    self.password.clearButtonMode = UITextFieldViewModeAlways;
    
    // 再次点击文本框时，清空之前的内容
//    self.telNumber.clearsOnBeginEditing = YES;
//    self.password.clearsOnBeginEditing = YES;
    
}

// regist notification
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

// remove notification
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Private Method

- (void)openKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.constraint.constant = 10; // 原为 80
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)closeKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.constraint.constant = 80; // 原为 10
    
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
    
    if ([telNum isEqualToString:@"123456"] && [pwd isEqualToString:@"123456"]) {
        RSMainTabBarController *mainVC = [[RSMainTabBarController alloc] init];
        [self presentViewController:mainVC animated:YES completion:nil];
    } else {
        self.errorLabel.text = @"手机号码或密码错误，请重新输入！";
    }
}

- (IBAction)cancel:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)otherLoginMethod:(id)sender {
    RSOtherLoginViewController *other = [[RSOtherLoginViewController alloc] init];
    [self presentViewController:other animated:YES completion:nil];
}

- (IBAction)question:(id)sender {
    RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
    [self presentViewController:questionVC animated:YES completion:nil];
}

#pragma mark - delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.errorLabel.text = nil;
    if (textField == self.telNumber) {
        self.telNumber.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        self.telNumber.keyboardType = UIKeyboardTypeDefault;
    }
}

@end
