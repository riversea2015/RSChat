//
//  RSChatsViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSChatsViewController.h"
#import "RSNewsViewController.h"
#import "RSMessageViewController.h"
#import "RSHomeSearchResultController.h"
#import "RSScanViewController.h"
#import "RSAddFriendViewController.h"

#import "RSHomeCell.h"
#import "RSSearchTempView.h"
#import "RSPopView.h"

#import "RSHomeModel.h"
#import "RSChatMacro.h"
#import <sys/utsname.h>

@interface RSChatsViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate,
UISearchResultsUpdating,
UIBarPositioningDelegate
>

@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, strong) UISearchController *searchVC;
@property (nonatomic, strong) RSHomeSearchResultController *resultTVC;
@property (nonatomic, strong) RSPopView *popView;
@property (nonatomic, strong) RSSearchTempView *tmpView;

@end

@implementation RSChatsViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavView];
    [self setupMainViews];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.searchVC.searchBar resignFirstResponder];
}

#pragma mark -

- (void)setupMainViews {
    
    self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [RSHomeCell registerNibToTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self setupSearchView];
    
    for (UIButton *button in self.popView.popButtons) {
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)action:(UIButton *)button {
    
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
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.popView.flag == 1) {
        self.popView.flag = 0;
        [self.popView removeFromSuperview];
    }
    // ...
}

#pragma mark - NavigationBar

- (void)setupNavView {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(popUp)];
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

- (void)setupSearchView {

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
    _tmpView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_tmpView];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar { // 点击cancel按钮时
    NSLog(@"方法调用 %s ", __func__);
    [_tmpView removeFromSuperview];
    _tmpView = nil;
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
        RSNewsViewController *newsVC = [[RSNewsViewController alloc] init];
        [self.navigationController pushViewController:newsVC animated:YES];

    } else {
        
        RSMessageViewController *messageVC = [[RSMessageViewController alloc] init];
        RSHomeModel *model = self.allDatas[indexPath.row];
        messageVC.homeModel = model;
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - setter getter

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
