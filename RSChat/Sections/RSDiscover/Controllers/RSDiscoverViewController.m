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

@interface RSDiscoverViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSDiscoverModel *model;

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
            model = self.model.modelArr[0];
            break;
        case 1:
            if (indexPath.row == 0) {
                model = self.model.modelArr[1];
            } else {
                model = self.model.modelArr[2];
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                model = self.model.modelArr[3];
            } else {
                model = self.model.modelArr[4];
            }
            break;
        default:
            if (indexPath.row == 0) {
                model = self.model.modelArr[5];
            } else {
                model = self.model.modelArr[6];
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
    NSLog(@"%@: section:%ld, row:%ld",self, indexPath.section, indexPath.row);
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

- (RSDiscoverModel *)model {
    if (!_model) {
        _model = [RSDiscoverModel new];
    }
    return _model;
}

@end
