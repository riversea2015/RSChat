//
//  RSOtherLoginViewController.m
//  RSChat
//
//  Created by hehai on 15/12/23.
//  Copyright © 2015年 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSOtherLoginViewController.h"
#import "RSMainTabBarController.h"
#import "RSQuestionViewController.h"

@interface RSOtherLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation RSOtherLoginViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.account.clearButtonMode = UITextFieldViewModeAlways;
    self.password.clearButtonMode = UITextFieldViewModeAlways;
}


#pragma mark - Action

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}

- (IBAction)didInputAccount:(id)sender {
    [self.password becomeFirstResponder];
    
}

- (IBAction)didInputPwd:(id)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}


- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}

- (IBAction)goBack:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)checkInfo {
    NSString *account = self.account.text;
    NSString *pwd = self.password.text;
    
    if (account.length == 0 || pwd.length == 0) {
        self.errorLabel.text = @"账号和密码不能为空！";
        return;
    }
    
    if ([account isEqualToString:@"123456"] && [pwd isEqualToString:@"123456"]) {
        RSMainTabBarController *mainVC = [[RSMainTabBarController alloc] init];
        [self presentViewController:mainVC animated:YES completion:nil];
    } else {
        self.errorLabel.text = @"账号或密码错误，请重新输入！";
    }
}

- (IBAction)question:(id)sender {
    RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
    [self presentViewController:questionVC animated:YES completion:nil];
}

@end
