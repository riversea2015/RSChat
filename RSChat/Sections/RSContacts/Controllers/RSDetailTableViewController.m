//
//  RSDetailTableViewController.m
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSDetailTableViewController.h"
#import "RSDetailFirstCell.h"
#import "RSDetailSecondCell.h"
#import "RSMessageVideoCell.h"

@interface RSDetailTableViewController ()

@end

@implementation RSDetailTableViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细资料";
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSDetailFirstCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSDetailFirstCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSDetailSecondCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSDetailSecondCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSMessageVideoCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSMessageVideoCell cellID]];
}

#pragma mark - private method


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        case 3:
        case 4:
            return 1;
        case 1:
            return 2;
        default:
            return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RSDetailFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSDetailFirstCell cellID] forIndexPath:indexPath];
        cell.leftImageView.image = [UIImage imageNamed:self.contactMdel.contactImageName];
        cell.topLabel.text = self.contactMdel.contactName;
        cell.bottomLabel.text = self.contactMdel.idStr;
        if (self.contactMdel.isMale) {
            cell.rightImageView.image = [UIImage imageNamed:@"Contact_Male"];
        } else {
            cell.rightImageView.image = [UIImage imageNamed:@"Contact_Female"];
        }
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"设置备注和标签";
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"电话号码";
            cell.detailTextLabel.text = self.contactMdel.telNumStr;
        }

        return cell;
    }
    
    if (indexPath.section == 3 || indexPath.section == 4) {
        RSMessageVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSMessageVideoCell cellID] forIndexPath:indexPath];
        if (indexPath.section == 3) {
            cell.nameLabel.text = @"发消息";
            cell.bkIMageView.image = [UIImage imageNamed:@"Bg_hl"];
        } else {
            cell.nameLabel.text = @"视频聊天";
            cell.bkIMageView.image = [UIImage imageNamed:@"Action_Tap"];
        }
        
        return cell;
    }
    
    // section 2
    if (indexPath.row == 0 || indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
        }
        
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.text = @"地区";
            cell.detailTextLabel.text = self.contactMdel.district;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"更多";
        }
        
        return cell;
    }
    
    RSDetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSDetailSecondCell cellID] forIndexPath:indexPath];
    cell.leftImageView.image = [UIImage imageNamed:@"cartoon_5"];
    cell.middleImageView.image = [UIImage imageNamed:@"cartoon_7"];
    cell.rightImageView.image = [UIImage imageNamed:@"cartoon_9"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [RSDetailFirstCell rowHeight];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        return [RSDetailSecondCell rowHeight];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

#pragma mark - setter getter

@end
