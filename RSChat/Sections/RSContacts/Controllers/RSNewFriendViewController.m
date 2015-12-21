//
//  RSNewFriendViewController.m
//  RSChat
//
//  Created by hehai on 12/17/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSNewFriendViewController.h"
#import "RSNewFriendCell.h"

@interface RSNewFriendViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RSNewFriendViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新的朋友";
    
    [RSNewFriendCell registToTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self addRightItem];
}

#pragma mark - Private Method

- (void)addRightItem {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加朋友" style:UIBarButtonItemStyleDone target:self action:@selector(addFriends)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addFriends {
    // To be continued...
}

#pragma mark - tableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSNewFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSNewFriendCell cellID] forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleImageView.image = [UIImage imageNamed:@"FriendCardNodeIconMobile"];
        cell.nameLabel.text = @"添加手机联系人";
    } else {
        cell.titleImageView.image = [UIImage imageNamed:@"FriendCardNodeIconQQ"];
        cell.nameLabel.text = @"添加QQ好友";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSNewFriendCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //...点击事件的逻辑
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setter getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self addTableHeaderView];
    }
    return _tableView;
}

- (void)addTableHeaderView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [UIScreen mainScreen].bounds.size.width - 30, 75)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.text = @"你可以绑定手机QQ账号，以便找到更多好友。";
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75)];
    
    [self.tableView.tableHeaderView  addSubview:label];
}

@end
