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
#import "RSHomeSearchResultController.h"

// 测试运行时使用
#import "UIViewController+RSExts.h"

@interface RSHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIBarPositioningDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;

@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, strong) RSHomeSearchResultController *resultTVC;

@end

@implementation RSHomeViewController

#pragma mark - lifeCycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBisicInfo];
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSHomeCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSHomeCell cellID]];
    [self.view addSubview:self.tableView];
    
    [self startSearch];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.searchVC.searchBar resignFirstResponder];
}

#pragma mark - private method

- (void)setBisicInfo {
    self.navigationItem.title = [NSString stringWithFormat:@"微信(%d)",3];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStyleDone target:self action:@selector(popUp)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - search

- (void)startSearch {

    self.resultTVC = [[RSHomeSearchResultController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self.resultTVC];
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:navi];
    
    // 设置搜索控制器的结果更新代理对象
    self.searchVC.searchResultsUpdater = self;
    
    [self.searchVC.searchBar sizeToFit];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"]; // 将searchBar的cancel按钮改成中文的
    self.searchVC.searchBar.barTintColor = [UIColor colorWithWhite:0.9 alpha:0.5]; // 背景色
    
    [self.searchVC.searchBar setBackgroundImage:[UIImage new]]; // 去除上下边界的黑线
    
    self.searchVC.searchBar.placeholder = @"搜索";
    self.searchVC.searchBar.tintColor = [UIColor greenColor]; // 文字颜色
    
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
    // 开启 在当前控制器中，允许切换另一个视图做呈现
    self.definesPresentationContext = YES;
    
    self.searchVC.searchBar.delegate = self;

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResultArray = [NSMutableArray array];
    
    for (RSHomeModel *model in self.allDatas) {
        NSRange range = [model.leftText rangeOfString:searchText];
        if (range.length > 0) {
            [searchResultArray addObject:model];
        }
    }
    
    self.resultTVC.resultArray = searchResultArray;
    [self.resultTVC.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar { // 点击搜索框时
    NSLog(@"方法调用 %s ", __func__);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar { // 点击cancel按钮时
    NSLog(@"方法调用 %s ", __func__);
}

#pragma mark - UISearchBarDelegate Method

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
