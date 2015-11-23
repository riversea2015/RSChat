//
//  RSNewsTableViewController.m
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSNewsTableViewController.h"
//#import "RSNewsTitleCell.h"
//#import "RSDateView.h"
#import "RSNewsContentCell.h"
#import "RSNewsModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface RSNewsTableViewController () // <NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSMutableArray *newsArr;

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) AFHTTPRequestOperation *operation;

@property (nonatomic, assign) NSUInteger pagesize;
@property (nonatomic, assign) NSUInteger p;
@property (nonatomic, strong) NSString *docurl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger job;

@end

@implementation RSNewsTableViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 网络请求的原始参数，用于拼接url
    self.pagesize = 20;
    self.p = 1;
    self.docurl = @"http%3A%2F%2Fnews.ifeng.com%2Fmainland%2Fspecial%2Fxjpg20%2F";
    self.type = @"all";
    self.job = 9;
    
    self.title = @"腾讯新闻";
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = item;

    [self.tableView registerNib:[UINib nibWithNibName:[RSNewsContentCell cellID] bundle:nil] forCellReuseIdentifier:[RSNewsContentCell cellID]];

    self.newsArr = [[NSMutableArray alloc] init];
    
    // 加载动画
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    hud.labelColor = [UIColor greenColor];
    hud.xOffset = 0;
    hud.yOffset = 20;
    hud.color = [UIColor redColor];
    
    [self sendRequestGetJSON];
    
    // 下拉刷新，上拉加载更多数据
    [self headerRefresh];
    [self footerRefresh];
}

// 跳出此界面时，撤销网络请求
- (void)viewWillDisappear:(BOOL)animated {
    // [self.connection cancel]; // 使用 NSUURLConnection
    [self.operation cancel];     // 使用 AFNetworking
}

#pragma mark - headerRefresh footerRefresh

- (void)headerRefresh {
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

- (void)loadNewData
{
    [self.newsArr removeAllObjects];
    [self sendRequestGetJSON];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    });
}

- (void)footerRefresh {
    __weak __typeof(self) weakSelf = self;
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadMoreData {
    self.p++;
    [self sendRequestGetJSON];
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
}

#pragma mark - send request & parse data

- (void)sendRequestGetJSON {

    NSString *urlStr = [NSString stringWithFormat:@"http://icomment.ifeng.com/geti.php?pagesize=%ld&p=%ld&docurl=%@&type=%@&job=%ld", self.pagesize, self.p, self.docurl, self.type, self.job];
    NSURL *url = [NSURL URLWithString:urlStr];
    self.request = [NSURLRequest requestWithURL:url];
/**
 发送网络请求：第一种方式 NSURLConnection，用到了代理：NSURLConnectionDataDelegate
 */
//    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];

/**
 发送网络请求：第二种方式 AFNetworking
 */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    WEAKSELF
    self.operation = [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"AFN json:%@", responseObject);
        
        [weakSelf getResult:responseObject];
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"AFN 返回失败：%@", error.userInfo);
    }];
    
}


- (void)getResult:(NSDictionary *)jsonDic {
    NSArray *testArr = jsonDic[@"comments"][@"hottest"];
    for (NSDictionary *dic in testArr) {
        RSNewsModel *newsModel = [RSNewsModel parseJSONData:dic];
        [self.newsArr addObject:newsModel];
    }
    
    testArr = jsonDic[@"comments"][@"newest"];
    for (NSDictionary *dic in testArr) {
        RSNewsModel *newsModel = [RSNewsModel parseJSONData:dic];
        
        [self.newsArr addObject:newsModel];
    }
    
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - NSURLConnectionDataDelegate

/**
 发送网络请求：第一种方式用到的4个代理类方法
 */
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    NSLog(@"%s", __func__);
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    NSLog(@"%s", __func__);
//    
//    if (data.length < 1) {
//        NSLog(@"返回数据为空");
//        return ;
//    }
//    
//    NSError *error = nil;
//    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//    
//    if (error) {
//        NSLog(@"解析出错:%@", error.userInfo);
//        return ;
//    }
//    
//    NSLog(@"dic:%@", jsonDic);
//
//    NSArray *testArr = jsonDic[@"comments"][@"hottest"];
//    for (NSDictionary *dic in testArr) {
//        RSNewsModel *newsModel = [RSNewsModel parseJSONData:dic];
//        [self.newsArr addObject:newsModel];
//    }
//    
//    testArr = jsonDic[@"comments"][@"newest"];
//    for (NSDictionary *dic in testArr) {
//        RSNewsModel *newsModel = [RSNewsModel parseJSONData:dic];
//        
//        [self.newsArr addObject:newsModel];
//    }
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSLog(@"%s", __func__);
//    [self.tableView reloadData];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    NSLog(@"%s", __func__);
//    NSLog(@"请求失败：%@", error.userInfo);
//}

#pragma mark - private method

- (void)setting {
#warning TODO settings
    NSLog(@"设置腾讯新闻。。。");
}

#pragma mark - Table view dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *contentCellID = [RSNewsContentCell cellID];
    RSNewsContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellID forIndexPath:indexPath];
    
    if (indexPath.row < self.newsArr.count) {
        RSNewsModel *model = self.newsArr[indexPath.row];
        [cell.titleImageView sd_setImageWithURL:model.faceurl placeholderImage:[UIImage imageNamed:@"test"]];
        cell.contentLabel.text = model.comment_contents;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSNewsContentCell cellHeight];
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

#pragma mark - getter setter

@end
