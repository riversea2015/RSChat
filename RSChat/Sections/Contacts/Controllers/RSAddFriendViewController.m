//
//  RSAddFriendViewController.m
//  RSChat
//
//  Created by hehai on 1/3/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSAddFriendViewController.h"
#import "RSAddFriendCell.h"

@interface RSAddFriendViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *naviContacts;

@end

@implementation RSAddFriendViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加朋友";
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - TableView Dalegate & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"To be continued...";
        return cell;
    }
    
    RSAddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSAddFriendCell cellID] forIndexPath:indexPath];
    
    NSDictionary *dic = self.naviContacts[indexPath.row];
    cell.rightImageView.image = [UIImage imageNamed:dic[@"imageName"]];
    cell.topLabel.text = dic[@"titleText"];
    cell.bottomLabel.text = dic[@"subtitleText"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSAddFriendCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, -5, 180, view.frame.size.height)];
        label.text = [NSString stringWithFormat:@"我的微信号：%@", @"riversea2015"];
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add_friend_myQR"]];
        imageView.frame = CGRectMake(label.frame.size.width + label.frame.origin.x + 5, 7, 20, 20);
        [view addSubview:imageView];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [RSAddFriendCell registToTableView:_tableView];
        
#ifdef __IPHONE_11_0
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
#endif
    }
    return _tableView;
}

- (NSArray *)naviContacts {
    if (!_naviContacts) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"homeNaviContacts" ofType:@"plist"];
        _naviContacts = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _naviContacts;
}

@end
