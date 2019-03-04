//
//  RSFriendsCircleViewController.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSFriendsCircleViewController.h"
#import "RSFriendsCircleHeader.h"
#import "RSFriendsACell.h"
#import "RSFriendsModel.h"
#import "RSChatMacro.h"

@interface RSFriendsCircleViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *prototypeCell;
@property (nonatomic, strong) RSFriendsCircleHeader *headerView;

@property (nonatomic, strong) NSArray *demoArray;

@end

@implementation RSFriendsCircleViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    
    [self initData];
    [self setupNavView];
    [self setupMainViews];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"RSFriendsACell"];
}

#pragma mark - private method

- (void)initData {
    self.demoArray = [RSFriendsModel demoData];
}

- (void)setupNavView {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_Camera"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(changePhoto)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)changePhoto {
    NSLog(@"更换头像。。。");
}

- (void)setupMainViews {
    
    _headerView = [[RSFriendsCircleHeader alloc] initWithFrame:CGRectMake(0, 0, RSScreenW, 380)];
    _headerView.changeBgBlock = ^{
        NSLog(@"更换背景图。。。");
    };
    _headerView.reviewInfoBlock = ^{
        NSLog(@"查看用户信息。。。");
    };
    self.tableView.tableHeaderView = self.headerView;

    [self.view addSubview:self.tableView];
}

#pragma mark - tableView dataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSFriendsACell *cell = [tableView dequeueReusableCellWithIdentifier:@"RSFriendsACell" forIndexPath:indexPath];
    cell.userInteractionEnabled = NO;
    
    RSFriendsModel *model = self.demoArray[indexPath.row];
    cell.contentLabel.text = model.contentText;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSFriendsACell *cell = (RSFriendsACell *)self.prototypeCell;
    RSFriendsModel *model = self.demoArray[indexPath.row];
    cell.contentLabel.text = model.contentText;
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1  + size.height;
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

#pragma mark - setter getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [RSFriendsACell registToTableView:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

@end
