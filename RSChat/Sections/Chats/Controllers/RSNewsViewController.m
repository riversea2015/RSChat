//
//  RSNewsViewController.m
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSNewsViewController.h"
#import "RSNewsHeaderCell.h"
#import "RSNewsDateView.h"
#import "RSNewsContentCell.h"
#import "RSNewsModel.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import <AFNetworking/AFNetworking.h>

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface RSNewsViewController ()

@property (nonatomic, strong) NSMutableArray *newsArr;
@property (nonatomic, assign) NSUInteger pagesize;
@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation RSNewsViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVariables];
    [self setupNavView];
    [self setupMainViews];
    [self setupRefreshView];
    
    [self sendRequestGetJSON];
}

#pragma mark - private method

- (void)initVariables {
    self.newsArr = [[NSMutableArray alloc] init];
    _pagesize = 20;
    _currentPage = 1;
}

- (void)setupNavView {
    self.title = @"腾讯新闻";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"]
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupMainViews {
    [RSNewsContentCell registerNibToTableView:self.tableView];
    [RSNewsHeaderCell registerNibToTableView:self.tableView];
    [self.view addSubview:self.tableView];
}

#pragma mark - request

- (void)sendRequestGetJSON {
    
    [self showHUD];
    
    NSString *docurl = @"http%3A%2F%2Fnews.ifeng.com%2Fmainland%2Fspecial%2Fxjpg20%2F";
    NSString *type = @"all";
    NSInteger job = 9;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://icomment.ifeng.com/geti.php?pagesize=%lu&p=%lu&docurl=%@&type=%@&job=%ld", (unsigned long)self.pagesize, (unsigned long)self.currentPage, docurl, type, (long)job];
    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    WEAKSELF
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [weakSelf hideHUD];
        if (error) {
            NSLog(@"Error: %@", error);
            [weakSelf handleFailureResult:responseObject];
        } else {
            [weakSelf handleSuccessResult:responseObject];
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
                                      
    [dataTask resume];
}

- (void)handleFailureResult:(NSDictionary *)jsonDic {
    [self endMJRefreshing];
}

- (void)endMJRefreshing {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    } else if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (void)handleSuccessResult:(NSDictionary *)jsonDic {
    
    if (_currentPage == 1) {
        [self.newsArr removeAllObjects];
    }
    
    NSArray *testArr = jsonDic[@"comments"][@"hottest"];
    
    for (NSDictionary *dic in testArr) {
        RSNewsModel *newsModel = [RSNewsModel parseJSONData:dic];
        NSLog(@"%@", newsModel.comment_contents);
        [self.newsArr addObject:newsModel];
    }
    
    testArr = jsonDic[@"comments"][@"newest"];
    for (NSDictionary *dic in testArr) {
        RSNewsModel *newsModel = [RSNewsModel parseJSONData:dic];
        [self.newsArr addObject:newsModel];
    }
    
    [self.tableView reloadData];
    [self endMJRefreshing];
}

#pragma mark - headerRefresh & footerRefresh

- (void)setupRefreshView {
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    _currentPage = 1;
    [self sendRequestGetJSON];
}

- (void)loadMoreData {
    _currentPage++;
    [self sendRequestGetJSON];
}

#pragma mark - private method

- (void)setting {
    NSLog(@"设置腾讯新闻。。。");
}

#pragma mark - Table view dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.newsArr.count / 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = 4 * indexPath.section + indexPath.row;
    
    if (indexPath.row == 0) {
        RSNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSNewsHeaderCell cellID] forIndexPath:indexPath];
        if (index < self.newsArr.count) {
            RSNewsModel *model = self.newsArr[index];
            [cell.headerImageView sd_setImageWithURL:model.faceurl placeholderImage:[UIImage imageNamed:@"test"]];
            cell.headerTextLabel.text = [NSString stringWithFormat:@" %@", model.comment_contents];
        }
        return cell;
    }
    
    RSNewsContentCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSNewsContentCell cellID] forIndexPath:indexPath];
    
    if (index < self.newsArr.count) {
        RSNewsModel *model = self.newsArr[index];
        [cell.titleImageView sd_setImageWithURL:model.faceurl placeholderImage:[UIImage imageNamed:@"test"]];
        cell.contentLabel.text = model.comment_contents;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [RSNewsHeaderCell rowHeight];
    }
    return [RSNewsContentCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    RSNewsDateView *dateView = [[[NSBundle mainBundle] loadNibNamed:@"RSNewsDateView" owner:self options:nil] lastObject];
    [dateView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    dateView.backgroundColor = [UIColor clearColor];
    
    if (self.newsArr.count > 4 * section) {
        RSNewsModel *model = self.newsArr[4 * section + 0];
        dateView.dateLabel.text = [NSString stringWithFormat:@" %@ ", model.comment_date];
    }
    
    return dateView;
}

@end
