//
//  RSHomeViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSHomeViewController.h"
#import "RSHomeCell.h"
#import "RSHomeModel.h"
#import "RSNewsTableViewController.h"
#import "RSMessageViewController.h"

// 测试运行时使用
#import "UIViewController+RSExts.h"

@interface RSHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;

@end

@implementation RSHomeViewController

#pragma mark - lifeCycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"微信(%d)",3];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStyleDone target:self action:@selector(popUp)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSHomeCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSHomeCell cellID]];

    [self.view addSubview:self.tableView];
    
}

#pragma mark - private method

#warning TODO 实现 navigationBar 下拉列表功能
- (void)popUp {

    NSLog(@"下拉列表...");
}

#pragma mark - tableView dataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [RSHomeCell cellID];
    RSHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    RSHomeModel *model = self.allDatas[indexPath.row];
    [cell setCellWithModel:model];
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSHomeCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@: section:%ld, row:%ld",self, indexPath.section, indexPath.row);
    
    if (indexPath.row == 0) {
        RSNewsTableViewController *newsVC = [[RSNewsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:newsVC animated:YES];

    } else if (indexPath.row == 1 || indexPath.row == 2) {
        NSLog(@"点击了Bugly或订阅号。。。");
    } else {
        self.hidesBottomBarWhenPushed = YES;
        
        RSMessageViewController *messageVC = [[RSMessageViewController alloc] init];
        RSHomeModel *model = self.allDatas[indexPath.row];
        messageVC.homeModel = model;
        
        [self.navigationController pushViewController:messageVC animated:YES];
        
        self.hidesBottomBarWhenPushed = NO;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; // 选中后，取消选中状态（取消了选中时的颜色）
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - setter getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [[RSHomeModel demoData] mutableCopy];
    }
    return _allDatas;
}

@end
