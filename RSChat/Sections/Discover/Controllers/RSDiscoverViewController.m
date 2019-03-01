//
//  RSDiscoverViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSDiscoverViewController.h"
#import "RSDiscoverModel.h"
#import "RSDiscoverCell.h"
#import "UIImage+RSSet.h"

#import "RSScanViewController.h"
#import "RSShakeViewController.h"
#import "RSLocalViewController.h"
#import "RSBottleViewController.h"
#import "RSFriendsViewController.h"
#import "RSBuyViewController.h"
#import "RSGameViewController.h"

@interface RSDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;

@end

@implementation RSDiscoverViewController

#pragma mark - lifeCycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    UIView *contentView = self.view;
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSDiscoverCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSDiscoverCell cellID]];
    
    [contentView addSubview:self.tableView];
    
    // 确保View（此处是tableView）不会延伸至导航栏和tabBar的区域之内
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
}

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [RSDiscoverCell cellID];
    RSDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    RSDiscoverModel *model = [RSDiscoverModel new];
    switch (indexPath.section) {
        case 0:
            model = self.allDatas[0];
            break;
        case 1:
            if (indexPath.row == 0) {
                model = self.allDatas[1];
            } else {
                model = self.allDatas[2];
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                model = self.allDatas[3];
            } else {
                model = self.allDatas[4];
            }
            break;
        default:
            if (indexPath.row == 0) {
                model = self.allDatas[5];
            } else {
                model = self.allDatas[6];
            }
            break;
    }
    [cell setCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSDiscoverCell rowHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@: section:%ld, row:%ld",self, (long)indexPath.section, (long)indexPath.row);
    self.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 0) {
        RSFriendsViewController *friendsVC = [[RSFriendsViewController alloc] init];
        [self.navigationController pushViewController:friendsVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        RSScanViewController *scanVC = [[RSScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        RSShakeViewController *shakeVC = [[RSShakeViewController alloc] initWithNibName:@"RSShakeViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:shakeVC animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        RSLocalViewController *localVC = [[RSLocalViewController alloc] initWithNibName:@"RSLocalViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:localVC animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        RSBottleViewController *bottleVC = [[RSBottleViewController alloc] initWithNibName:@"RSBottleViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:bottleVC animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        RSBuyViewController *buyVC = [[RSBuyViewController alloc] init];//WithNibName:@"RSBuyViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:buyVC animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 1) {
        RSGameViewController *gameVC = [[RSGameViewController alloc] init];
        [self.navigationController pushViewController:gameVC animated:YES];
    }
    
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [[RSDiscoverModel demoData] mutableCopy];
    }
    return _allDatas;
}

@end
