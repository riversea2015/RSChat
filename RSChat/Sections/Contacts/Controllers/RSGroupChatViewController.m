//
//  RSGroupChatViewController.m
//  RSChat
//
//  Created by hehai on 12/18/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSGroupChatViewController.h"

@interface RSGroupChatViewController ()

@end

@implementation RSGroupChatViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群聊";
    
    [self showBlankLabel];
    // 添加群聊的逻辑。。。
}

#pragma mark - Private Method

- (void)showBlankLabel {
    CGRect frame = [UIScreen mainScreen].bounds;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, frame.size.height)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"你可以通过群聊中的“保存到通讯录”选项，将其保存到这里";
    [self.view addSubview:label];
}

@end
