//
//  RSDetailTableViewController.m
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSDetailTableViewController.h"
#import "RSDetailFirstCell.h"
#import "RSDetailSecondCell.h"
#import "RSMessageVideoCell.h"
#import "RSActionView.h"
#import "RSMessageViewController.h"
#import "RSHomeModel.h"
#import "RSVideoViewController.h"

@interface RSDetailTableViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) RSActionView *actionView;
@property (nonatomic, strong) NSArray *homeModelArray;

@end

@implementation RSDetailTableViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细资料";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(setDetails)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSDetailFirstCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSDetailFirstCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSDetailSecondCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSDetailSecondCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSMessageVideoCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSMessageVideoCell cellID]];
    
    [self SetTableFooterView];
}

#pragma mark - private method

- (void)SetTableFooterView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 123)];
    [view addSubview:self.actionView];
    
    [self.actionView.message addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.actionView.videoChat addTarget:self action:@selector(videoChat) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView setTableFooterView:view];
}

- (void)sendMessage {
    NSLog(@"发消息。。。");
    self.hidesBottomBarWhenPushed = YES;
    
    RSMessageViewController *messageVC = [[RSMessageViewController alloc] init];
    for (RSHomeModel *homeModel in self.homeModelArray) {
        if ([self.contactMdel.contactName isEqualToString:homeModel.leftText]) {
            messageVC.homeModel = homeModel;
        }
    }
    [self.navigationController pushViewController:messageVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

#warning 在真机上无法显示xib的内容，在模拟器上可以
- (void)videoChat {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"视频聊天", @"语音聊天", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"%@",title);
    
    if (buttonIndex == 0) {
        self.hidesBottomBarWhenPushed = YES;
        RSVideoViewController *videoVC = [[RSVideoViewController alloc] initWithNibName:@"RSVideoViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:videoVC animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        NSLog(@"语音聊天。。。");
    }
    
}

- (void)setDetails {
    NSLog(@"资料设置。。。");
}

#pragma mark - TableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
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
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

// 设置分割线的长度
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了详细资料中的某一行。。。");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setter getter

- (RSActionView *)actionView {
    if (!_actionView) {
        _actionView = [[[NSBundle mainBundle] loadNibNamed:@"RSActionView" owner:self options:nil] lastObject];
    }
    return _actionView;
}

- (NSArray *)homeModelArray {
    if (!_homeModelArray) {
        _homeModelArray = [RSHomeModel demoData];
    }
    return _homeModelArray;
}

@end
