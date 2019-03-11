//
//  RSMeViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSMeViewController.h"

#import "RSMeHeaderCell.h"
#import "RSMeOtherCell.h"

#import "RSMeModel.h"

#import "RSPrivateViewController.h"
#import "RSSettingViewController.h"
#import "RSEmotionViewController.h"
#import "RSMoneyCollectionViewController.h"
#import "RSAlbumViewController.h"
#import "RSFavoritesViewController.h"

@interface RSMeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) RSMeModel *model;

@end

@implementation RSMeViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupMainViews];
}

#pragma mark -

- (void)setupMainViews {
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:[RSMeHeaderCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSMeHeaderCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSMeOtherCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSMeOtherCell cellID]];
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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *destVC = nil;
    
    if (indexPath.section == 0) {
        destVC = [[RSPrivateViewController alloc] init];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        destVC = [[RSAlbumViewController alloc] init];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        destVC = [[RSFavoritesViewController alloc] init];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        destVC = [[RSMoneyCollectionViewController alloc] initWithNibName:@"RSMoneyCollectionViewController" bundle:[NSBundle mainBundle]];
    } else if (indexPath.section == 2) {
        destVC = [[RSEmotionViewController alloc] init];
    } else if (indexPath.section == 3) {
        destVC = [[RSSettingViewController alloc] init];
    }
    
    [self.navigationController pushViewController:destVC animated:YES];
}

#pragma mark - setter & getter

- (RSMeModel *)model {
    if (!_model) {
        _model = [RSMeModel new];
    }
    return _model;
}

@end
