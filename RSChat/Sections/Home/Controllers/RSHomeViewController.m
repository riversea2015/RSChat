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
#import "RSScanViewController.h"
#import "RSAddFriendViewController.h"
#import "RSSearchTempView.h"
#import "RSPopView.h"
#import "UIViewController+RSExts.h" // 测试/调试
#import <sys/utsname.h>

@interface RSHomeViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating, UIBarPositioningDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, strong) RSHomeSearchResultController *resultTVC;
@property (nonatomic, strong) RSPopView *popView;
@property (nonatomic, strong) RSSearchTempView *tmpView;

@end

@implementation RSHomeViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *modelStr = [UIDevice currentDevice].model;
    NSLog(@"当前设备：%@", modelStr);
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@"设备型号：%@", deviceString);
    
    [self setBisicInfo];
    
    [RSHomeCell registToTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self startSearch];
    
    for (UIButton *button in self.popView.popButtons) {
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)action:(UIButton *)button {
    self.hidesBottomBarWhenPushed = YES;
    
    if (button.tag == 1) {
        RSAddFriendViewController *addFriendVC = [[RSAddFriendViewController alloc] init];
        [self.navigationController pushViewController:addFriendVC animated:YES];
    }
    
    if (button.tag == 2) {
        RSScanViewController *scanVC = [[RSScanViewController alloc] init];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
    
    self.popView.flag = 0;
    [self.popView removeFromSuperview];
    self.hidesBottomBarWhenPushed = NO;
}



- (void)viewWillDisappear:(BOOL)animated {
    [self.searchVC.searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.popView.flag == 1) {
        self.popView.flag = 0;
        [self.popView removeFromSuperview];
    }
    // ...
}

#pragma mark - NavigationBar

- (void)setBisicInfo {
    self.navigationItem.title = [NSString stringWithFormat:@"我信(%d)",32];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStyleDone target:self action:@selector(popUp)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)popUp {
    if (self.popView.flag == 1) {
        self.popView.flag = 0;
        [self.popView removeFromSuperview];
        return;
    }
    self.popView.flag = 1;
    [self.view addSubview:self.popView];
}

#pragma mark - SearchMethod & UISearchResultsUpdating

- (void)startSearch {

    self.resultTVC = [[RSHomeSearchResultController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self.resultTVC];
    self.searchVC = [[UISearchController alloc] initWithSearchResultsController:navi];
    
    [self.searchVC.searchBar sizeToFit];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"]; // 将searchBar的cancel按钮改成中文的
    [self.searchVC.searchBar setBackgroundImage:[UIImage new]]; // 去除上下边界的黑线
    self.searchVC.searchBar.placeholder = @"搜索";
    self.searchVC.searchBar.tintColor = [UIColor greenColor]; // 文字颜色
    
    self.searchVC.searchBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];

    self.searchVC.searchResultsUpdater = self; // 设置 搜索控制器 的结果更新代理对象
    self.searchVC.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
    // 开启 在当前控制器中，允许切换另一个视图做呈现
    self.definesPresentationContext = YES;
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

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar { // 点击搜索框时
    NSLog(@"方法调用 %s ", __func__);
    
    _tmpView = [[[NSBundle mainBundle] loadNibNamed:@"RSSearchTempView" owner:self options:nil] lastObject];
    [self.view addSubview:_tmpView];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar { // 点击cancel按钮时
    NSLog(@"方法调用 %s ", __func__);
    [_tmpView removeFromSuperview];
}

#pragma mark - tableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSHomeCell cellID] forIndexPath:indexPath];
    RSHomeModel *model = self.allDatas[indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSHomeCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@: section:%ld, row:%ld",self, indexPath.section, indexPath.row);
    
    self.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.row == 0) {
        RSNewsTableViewController *newsVC = [[RSNewsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:newsVC animated:YES];

    } else {
        
        RSMessageViewController *messageVC = [[RSMessageViewController alloc] init];
        RSHomeModel *model = self.allDatas[indexPath.row];
        messageVC.homeModel = model;
        [self.navigationController pushViewController:messageVC animated:YES];
    }
    
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; // 取消选中状态
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

// 设置分割线的长度
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [[RSHomeModel demoData] mutableCopy];
    }
    return _allDatas;
}

- (RSPopView *)popView {
    if (!_popView) {
        _popView = [[[NSBundle mainBundle] loadNibNamed:@"RSPopView" owner:self options:nil] lastObject];
        _popView.frame = [UIScreen mainScreen].bounds;
        _popView.flag = 0;
    }
    return _popView;
}


@end
