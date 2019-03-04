//
//  RSDiscoverViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSDiscoverViewController.h"
#import "RSDiscoverModel.h"
#import "RSDiscoverCell.h"
#import "UIImage+RSExts.h"

#import "RSScanViewController.h"
#import "RSShakeViewController.h"
#import "RSLocalViewController.h"
#import "RSBottleViewController.h"
#import "RSFriendsCircleViewController.h"
#import "RSBuyViewController.h"
#import "RSGameViewController.h"

@interface RSDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *allDatas;

@end

@implementation RSDiscoverViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSDiscoverCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSDiscoverCell cellID]];
    [self.view addSubview:self.tableView];
    
#ifdef __IPHONE_11_0
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
#endif
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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    RSViewController *destVC = nil;
    
    if (indexPath.section == 0) {
        destVC = [[RSFriendsCircleViewController alloc] init];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        destVC = [[RSScanViewController alloc] init];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        destVC = [[RSShakeViewController alloc] initWithNibName:@"RSShakeViewController" bundle:[NSBundle mainBundle]];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        destVC = [[RSLocalViewController alloc] initWithNibName:@"RSLocalViewController" bundle:[NSBundle mainBundle]];
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        destVC = [[RSBottleViewController alloc] initWithNibName:@"RSBottleViewController" bundle:[NSBundle mainBundle]];
    } else if (indexPath.section == 3 && indexPath.row == 0) {
        destVC = [[RSBuyViewController alloc] init];
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        destVC = [[RSGameViewController alloc] init];
    }
    
    destVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:destVC animated:YES];
}

#pragma mark - setter & getter

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [[RSDiscoverModel demoData] mutableCopy];
    }
    return _allDatas;
}

@end
