//
//  RSGameViewController.m
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSGameViewController.h"

#import "RSGameACell.h"
#import "RSGameBCell.h"
#import "RSGameCCell.h"
#import "RSGameDCell.h"
#import "RSGameECell.h"

#import "RSGameDetailViewController.h"

@interface RSGameViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation RSGameViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏";
    
    [self.view addSubview:self.tableView];
    
    [RSGameACell registToTableView:self.tableView];
    [RSGameBCell registToTableView:self.tableView];
    [RSGameCCell registToTableView:self.tableView];
    [RSGameDCell registToTableView:self.tableView];
    [RSGameECell registToTableView:self.tableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleDone target:self action:@selector(settings)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)settings {
    // ...
}

#pragma mark - TableView delegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 1;
        default:
            return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RSGameACell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameACell cellID] forIndexPath:indexPath];
            return cell;
        }
        
        RSGameBCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameBCell cellID] forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.section == 1) {

            RSGameCCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameCCell cellID] forIndexPath:indexPath];
            return cell;
    }
    
    if (indexPath.row < 3) {
        RSGameDCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameDCell cellID] forIndexPath:indexPath];
        cell.numLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
        return cell;
    }
    
    RSGameECell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameECell cellID] forIndexPath:indexPath];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [RSGameACell cellHeight];
        }
        return [RSGameBCell cellHeight];
    }
    
    if (indexPath.section == 1) {
        return [RSGameCCell cellHeight];
    }
    
    if (indexPath.row < 3) {
        return [RSGameDCell cellHeight];
    }
    
    return [RSGameECell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    
    CGRect frame = HeaderView.bounds;
    frame.origin.x = HeaderView.bounds.origin.x + 15;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    
    if (section == 1) {
        label.text = @"好友热玩";
    }
    
    if (section == 2) {
        label.text = @"精品游戏畅销榜";
    }
    
    [HeaderView addSubview:label];
    
    return HeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section > 0) {
        RSGameDetailViewController *detailVC = [[RSGameDetailViewController alloc] initWithNibName:@"RSGameDetailViewController" bundle:[NSBundle mainBundle]];
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
