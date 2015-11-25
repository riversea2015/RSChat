//
//  RSContactsViewController.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSContactsViewController.h"
#import "RSContactsModel.h"
#import "RSContactCell.h"

@interface RSContactsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, strong) NSMutableArray *indexArr;
@property (nonatomic, strong) CALayer *layer;

@end

@implementation RSContactsViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系人";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add_cube"] style:UIBarButtonItemStyleDone target:self action:@selector(popUp)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
#warning TODO 添加搜索框，正在进行。。。
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
//    searchBar.translucent = YES;
//    searchBar.barStyle = UIBarStyleBlackTranslucent;
//    searchBar.showsCancelButton = YES;
//    [searchBar sizeToFit];
//    [self.tableView setTableHeaderView:searchBar];
    
    UIView *contentView = self.view;
    [contentView addSubview:self.tableView];
    
    self.indexArr = [NSMutableArray array];
}

#pragma mark - private method

#warning TODO 实现 navigationBar 下拉列表功能
- (void)popUp {
    NSLog(@"下拉列表...");
}

#pragma mark - indexList

#warning TODO 索引尚未关联
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return [@[@"1", @"2", @"3"] objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"1", @"2", @"3"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [RSContactCell cellID];
    RSContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

    RSContactsModel *model = self.allDatas[indexPath.row];
    [cell setCellWithModel:model];
    
    return cell;
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.sectionIndexColor = [UIColor greenColor]; // 设置右侧索引列的文字颜色
        
        [_tableView registerNib:[UINib nibWithNibName:[RSContactCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSContactCell cellID]];
    }
    return _tableView;
}

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [[RSContactsModel demoData] mutableCopy];
    }
    return _allDatas;
}

@end
