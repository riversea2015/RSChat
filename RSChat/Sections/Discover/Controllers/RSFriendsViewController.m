//
//  RSFriendsViewController.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSFriendsViewController.h"
#import "RSFriendsHeaderView.h"
#import "RSFriendsACell.h"
#import "RSFriendsModel.h"

@interface RSFriendsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RSFriendsHeaderView *headerView;

@property (nonatomic, strong) UITableViewCell *prototypeCell;
@property (nonatomic, strong) NSArray *demoArray;

@end

@implementation RSFriendsViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_Camera"] style:UIBarButtonItemStyleDone target:self action:@selector(changePhoto)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // UIRectEdgeAll && NO 时，可以让tableView延伸至navigationBar下边去。
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addContentViews];
    
    [RSFriendsACell registToTableView:self.tableView];
    
    self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"RSFriendsACell"];
    
    self.demoArray = [RSFriendsModel demoData];
}

#pragma mark - private method

- (void)changePhoto {
    NSLog(@"更换头像。。。");
}

- (void)addContentViews {
    
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"RSFriendsHeaderView" owner:self options:nil] lastObject];
    [self.headerView.bkButton addTarget:self action:@selector(changeBKImage) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.titleButton addTarget:self action:@selector(changeTitleImage) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.headerView;

    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)changeBKImage {
    NSLog(@"更换背景图。。。");
}

- (void)changeTitleImage {
    NSLog(@"更换头像。。。");
}

#pragma mark - tableView dataSource delegate

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

#pragma mark - setter getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

@end
