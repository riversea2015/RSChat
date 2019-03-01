//
//  RSSettingViewController.m
//  RSChat
//
//  Created by hehai on 12/30/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSSettingViewController.h"
#import "RSSettingCell.h"

#import "RSLogoutCell.h"
#import "RSReLoginViewController.h"

@interface RSSettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RSSettingViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [RSSettingCell registToTableView:self.tableView];
    [RSLogoutCell registToTableView:self.tableView];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView dataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 2;
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        RSLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSLogoutCell cellID] forIndexPath:indexPath];
        return cell;
    }
    
    RSSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSSettingCell cellID] forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.leftLabel.text = @"账号与安全";
        cell.rightLabel.text = @"未保护";
        cell.leftImageView.image = [UIImage imageNamed:@"Artboard 23"];
        cell.rightImageView.image = [UIImage imageNamed:@"ProfileLockOff"];
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.leftLabel.text = @"新消息通知";
                break;
            case 1:
                cell.leftLabel.text = @"隐私";
                break;
            default:
                cell.leftLabel.text = @"通用";
                break;
        }
        
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"帮助与反馈";
        } else {
            cell.leftLabel.text = @"关于微信";
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSSettingCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"退出后不会删除任何历史记录，下次登录依然可以使用本账号。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
        
        [actionSheet showInView:self.view];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        RSReLoginViewController *reLogin = [[RSReLoginViewController alloc] initWithNibName:@"RSReLoginViewController" bundle:[NSBundle mainBundle]];
        
        [self presentViewController:reLogin animated:YES completion:nil];
    }
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
