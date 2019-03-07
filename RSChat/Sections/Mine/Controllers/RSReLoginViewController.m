//
//  RSReLoginViewController.m
//  RSChat
//
//  Created by hehai on 12/30/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSReLoginViewController.h"
#import "RSMainTabBarController.h"
#import "RSQuestionViewController.h"

#import "RSLoginViewController.h"
#import "RSOtherLoginViewController.h"
#import "RSSignUpViewController.h"

@interface RSReLoginViewController ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet UIImageView *accountImageView;
@property (weak, nonatomic) IBOutlet UILabel *accoutLabel;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation RSReLoginViewController

#pragma mark -Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

#pragma mark - Action

- (IBAction)submit:(id)sender {
    [self.view endEditing:YES];
    [self checkInfo];
}

- (void)checkInfo {
    NSString *pwd = self.password.text;
    
    if (pwd.length == 0) {
        self.errorLabel.text = @"密码不能为空！";
        return;
    }
    
    if ([pwd isEqualToString:@"123456"]) {
        RSMainTabBarController *mainVC = [[RSMainTabBarController alloc] init];
        [self presentViewController:mainVC animated:YES completion:nil];
    } else {
        self.errorLabel.text = @"密码错误，请重新输入！";
    }
}

- (IBAction)questionAndAnswer:(id)sender {
    RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
    questionVC.url = [NSURL URLWithString:@"https://support.weixin.qq.com/security/readtemplate?t=page/login_optimized__w_index&lang=zh_CN"];
    questionVC.titleText = @"登陆遇到问题";
    
    [self presentViewController:questionVC animated:YES completion:nil];
}

- (IBAction)more:(id)sender {
    
    UIActionSheet *acttion = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"切换账号...", @"注册", @"前往微信安全中心", nil];
    
    
    [acttion showInView:self.view];
}

#pragma mark - actionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.numberOfButtons == 3) {
        
        if (buttonIndex == 0) {
            RSLoginViewController *login = [[RSLoginViewController alloc] initWithNibName:@"RSLoginViewController" bundle:[NSBundle mainBundle]];
            [self presentViewController:login animated:YES completion:nil];
        }
        
        if (buttonIndex == 1) {
            RSOtherLoginViewController *otherLogin = [[RSOtherLoginViewController alloc] initWithNibName:@"RSOtherLoginViewController" bundle:[NSBundle mainBundle]];
            [self presentViewController:otherLogin animated:YES completion:nil];
        }
        
        return;
    }
    
    if (buttonIndex == 0) {
        UIActionSheet *acttion = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"手机号", @"微信号/邮箱地址/QQ号", nil];
        
        [acttion showInView:self.view];
    }
    
    if (buttonIndex == 1) {
        RSSignUpViewController *signUp = [[RSSignUpViewController alloc] initWithNibName:@"RSSignUpViewController" bundle:[NSBundle mainBundle]];
        
        [self presentViewController:signUp animated:YES completion:nil];
    }
    
    if (buttonIndex == 2) {
        RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] init];
        questionVC.url = [NSURL URLWithString:@"https://weixin110.qq.com"];
        questionVC.titleText = @"微信安全中心";
        
        [self presentViewController:questionVC animated:YES completion:nil];
    }
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

@end
