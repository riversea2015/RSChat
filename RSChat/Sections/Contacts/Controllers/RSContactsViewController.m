//
//  RSContactsViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSContactsViewController.h"
#import "RSDetailTableViewController.h"
#import "RSNewFriendViewController.h"
#import "RSGroupChatViewController.h"
#import "RSLabelViewController.h"
#import "RSOfficialAccountViewController.h"
#import "RSAddFriendViewController.h"

#import "RSContactCell.h"
#import "RSNewFriendCell.h"

#import "RSContactsModel.h"

#import "RSChatMacro.h"

@interface RSContactsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, strong) NSMutableArray *indexArr;
@property (nonatomic, strong) CALayer *layer;

@end

@implementation RSContactsViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavView];
    
    [self setupMainViews];
}

#pragma mark - View

- (void)setupNavView {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add_cube"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupMainViews {
    [self.view addSubview:self.tableView];
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 索引列文字、背景颜色
    self.tableView.sectionIndexColor = [UIColor greenColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSContactCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSContactCell cellID]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    label.text = @"9位联系人";
    self.tableView.tableFooterView = label;
}

#pragma mark - 导航栏背景渐变

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGFloat offsetY = self.tableView.contentOffset.y;
    CGFloat delta = offsetY/RSNavBarH  + 1.f;
    delta = MAX(0, delta);
    self.navigationController.navigationBar.alpha = MIN(1, delta);
}

#pragma mark - private method

- (void)addFriend {
    self.hidesBottomBarWhenPushed = YES;
    RSAddFriendViewController *addVC = [[RSAddFriendViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 7) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [RSContactCell cellID];
    RSContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    RSContactsModel *model = [[RSContactsModel alloc] init];
    if (indexPath.section == 0) {
        model = self.allDatas[indexPath.row];
    } else if (indexPath.section <= 7 && indexPath.section > 0) {
        model = self.allDatas[3 + indexPath.section + indexPath.row];
    } else if (indexPath.section > 7) {
        model = self.allDatas[3 + indexPath.section + indexPath.row + 1];
    }
    
    [cell setCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RSNewFriendViewController *newVC = [[RSNewFriendViewController alloc] init];            
            [self.navigationController pushViewController:newVC animated:YES];
        }
        
        if (indexPath.row == 1) {
            RSGroupChatViewController *groupVC = [[RSGroupChatViewController alloc] init];
            [self.navigationController pushViewController:groupVC animated:YES];
        }
        
        if (indexPath.row == 2) {
            RSLabelViewController *labelVC = [[RSLabelViewController alloc] init];
            [self.navigationController pushViewController:labelVC animated:YES];
        }
        
        if (indexPath.row == 3) {
            RSOfficialAccountViewController *officialVC = [[RSOfficialAccountViewController alloc] init];
            [self.navigationController pushViewController:officialVC animated:YES];
        }
        
        self.hidesBottomBarWhenPushed = NO;
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    RSContactsModel *model = [[RSContactsModel alloc] init];

    if (indexPath.section <= 7 && indexPath.section > 0) {
        model = self.allDatas[3 + indexPath.section + indexPath.row];
    }
    if (indexPath.section > 7) {
        model = self.allDatas[3 + indexPath.section + indexPath.row + 1];
    }
    
    RSDetailTableViewController *detailVC = [[RSDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    detailVC.contactMdel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - indexList

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
    label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    label.text = [NSString stringWithFormat:@"  %@", [self.indexArr objectAtIndex:section - 1]];
    label.textColor = [UIColor lightGrayColor];
    
    return label;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSContactCell cellHeight];
}

#pragma mark - setter & getter

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [[RSContactsModel demoData] mutableCopy];
    }
    return _allDatas;
}

- (NSMutableArray *)indexArr {
    if (!_indexArr) {
        _indexArr = [NSMutableArray array];
        for (RSContactsModel *model in self.allDatas) {
            static NSString *tmpStr = nil;
            if (model.indexStr == tmpStr || model.indexStr.length < 1) {
                continue;
            }

            [_indexArr addObject:model.indexStr];
            
            tmpStr = model.indexStr;
        }
    }
    return _indexArr;
}

@end
