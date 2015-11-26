//
//  RSMeViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMeViewController.h"
#import "RSMeHeaderCell.h"
#import "RSMeOtherCell.h"
#import "RSMeModel.h"

@interface RSMeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSMeModel *model;

@end

@implementation RSMeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我";
    
    UIView *contentView = self.view;
    [contentView addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSMeHeaderCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSMeHeaderCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSMeOtherCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSMeOtherCell cellID]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *headerCellID = [RSMeHeaderCell cellID];
    if (indexPath.section == 0) {
        RSMeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellID forIndexPath:indexPath];
        RSMeModel *model = self.model.headerArr[0];
        [cell setWithModel:model];
        return cell;
    }
    
    NSString *otherCellID = [RSMeOtherCell cellID];
    RSMeOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCellID forIndexPath:indexPath];
    
    RSMeModel *model = self.model.otherArr[0];
    
    switch (indexPath.section) {
        case 1:
            model = self.model.otherArr[indexPath.row];
            break;
        case 2:
            model = self.model.otherArr[indexPath.row + 3];
            break;
        default:
            model = self.model.otherArr[indexPath.row + 4];
            break;
    }
    
    [cell setWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [RSMeHeaderCell rowHeight];
    }
    return [RSMeOtherCell rowHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@: section:%ld, row:%ld",self, (long)indexPath.section, (long)indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (RSMeModel *)model {
    if (!_model) {
        _model = [RSMeModel new];
    }
    return _model;
}
@end
