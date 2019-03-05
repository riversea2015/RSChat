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

#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface RSNewsViewController ()

@property (nonatomic, strong) NSMutableArray *newsArr;

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;

@property (nonatomic, assign) NSUInteger pagesize;
@property (nonatomic, assign) NSUInteger p;
@property (nonatomic, copy) NSString *docurl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger job;

@end

@implementation RSNewsViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBasicData];
    
    self.newsArr = [[NSMutableArray alloc] init];
    
    [self startProgressAnimation];
    
    [self setRequestParameters];
    [self sendRequestGetJSON];
    
    [self headerRefresh];
    [self footerRefresh];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.operation cancel];
}

#pragma mark - private method

- (void)setBasicData {
    self.title = @"腾讯新闻";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.tableView registerNib:[UINib nibWithNibName:[RSNewsContentCell cellID] bundle:nil] forCellReuseIdentifier:[RSNewsContentCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSNewsHeaderCell cellID] bundle:nil] forCellReuseIdentifier:[RSNewsHeaderCell cellID]];
    [self.view addSubview:self.tableView];
}

- (void)startProgressAnimation {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    hud.labelColor = [UIColor grayColor];
    hud.xOffset = 0;
    hud.yOffset = 20;
    hud.color = [UIColor greenColor];
}

#pragma mark - send request & parse data

- (void)setRequestParameters {
    self.pagesize = 20;
    self.p = 1;
    self.docurl = @"http%3A%2F%2Fnews.ifeng.com%2Fmainland%2Fspecial%2Fxjpg20%2F";
    self.type = @"all";
    self.job = 9;
}

- (void)sendRequestGetJSON {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://icomment.ifeng.com/geti.php?pagesize=%d&p=%d&docurl=%@&type=%@&job=%d", self.pagesize, self.p, self.docurl, self.type, self.job];
    NSURL *url = [NSURL URLWithString:urlStr];
    self.request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // [AFHTTPResponseSerializer serializer];
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
        NSLog(@"%@", newsModel.comment_contents);
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

#pragma mark - headerRefresh footerRefresh

- (void)headerRefresh {
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

- (void)loadNewData
{
    [self.newsArr removeAllObjects];
    [self sendRequestGetJSON];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)footerRefresh {
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadMoreData {
    self.p++;
    [self sendRequestGetJSON];
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
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
