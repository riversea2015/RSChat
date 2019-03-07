//
//  RSViewController.m
//  RSChat
//
//  Created by hehai on 2019/3/1.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface RSViewController ()

@property (nonatomic, strong) MBProgressHUD *hudView;

@end

@implementation RSViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.separatorInset = UIEdgeInsetsZero;
}

- (void)dealloc {
    NSLog(@"🎉 %@ dealloc 🎉", self);
}

#pragma mark - TableView delegate & dataSource

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:self.separatorInset];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - HUD

- (void)showHUD {
    [self showHUDInView:self.view animated:YES];
}

- (void)hideHUD {
    [self hideHUDInView:self.view animated:YES];
}

- (void)showHUDInView:(UIView *)view animated:(BOOL)animated {
    [self.hudView showAnimated:YES];
}

- (void)hideHUDInView:(UIView *)view animated:(BOOL)animated {
    [self.hudView hideAnimated:YES];
}

- (MBProgressHUD *)hudView {
    if (!_hudView) {
        _hudView = [[MBProgressHUD alloc] initWithView:self.view];
        _hudView.label.text = @"Loading";
        _hudView.label.textColor = [UIColor whiteColor];
        _hudView.offset = CGPointZero;
        _hudView.bezelView.color = [UIColor lightGrayColor];
        _hudView.removeFromSuperViewOnHide = YES;
        [self.view addSubview:_hudView];
    }
    return _hudView;
}

#pragma mark - Setter & Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        
#ifdef __IPHONE_11_0
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
#endif
    }
    return _tableView;
}

@end
