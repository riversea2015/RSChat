//
//  RSConformViewController.m
//  RSChat
//
//  Created by hehai on 15/12/23.
//  Copyright © 2015年 hehai. All rights reserved.
//

#import "RSConformViewController.h"
#import "RSMainTabBarController.h"

@interface RSConformViewController ()
@property (weak, nonatomic) IBOutlet UITextField *authCode;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation RSConformViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authCode.keyboardType = UIKeyboardTypeNumberPad;
    
    self.authCode.clearButtonMode = UITextFieldViewModeAlways;
}

#pragma mark - Private Method
- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(UIButton *)sender {
    [self.view endEditing:YES];
    NSString *authCode = self.authCode.text;
    
    if (authCode.length == 0) {
        self.errorLabel.text = @"验证码不能为空！";
        return;
    }
    
    if ([authCode isEqualToString:@"123456"]) {
        self.errorLabel.text = nil;
        RSMainTabBarController *mainVC = [[RSMainTabBarController alloc] init];
        [self presentViewController:mainVC animated:YES completion:nil];
    } else {
        self.errorLabel.text = @"验证码错误，请重新输入！";
    }
}


@end
