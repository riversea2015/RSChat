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
#import "RSDetailTableViewController.h"

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

    [self.view addSubview:self.tableView];
}

#pragma mark - private method

#warning TODO 实现 navigationBar 下拉列表功能
- (void)popUp {
    NSLog(@"下拉列表...");
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    if (section == 7) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [RSContactCell cellID];
    RSContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // 显示好友逻辑
    RSContactsModel *model = [[RSContactsModel alloc] init];
    if (indexPath.section == 0) {
        model = self.allDatas[indexPath.row];
    }
    
    if (indexPath.section <= 7 && indexPath.section > 0) {
        model = self.allDatas[3 + indexPath.section + indexPath.row];
    }
    
    if (indexPath.section > 7) {
        model = self.allDatas[3 + indexPath.section + indexPath.row + 1];
    }
    
    [cell setCellWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSLog(@"点击了新的朋友、群聊、标签、公众号");
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    RSContactsModel *model = [[RSContactsModel alloc] init];
    if (indexPath.section == 0) {
        model = self.allDatas[indexPath.row];
    }
    if (indexPath.section <= 7 && indexPath.section > 0) {
        model = self.allDatas[3 + indexPath.section + indexPath.row];
    }
    if (indexPath.section > 7) {
        model = self.allDatas[3 + indexPath.section + indexPath.row + 1];
    }
    
    RSDetailTableViewController *detailVC = [[RSDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    detailVC.contactMdel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - indexList

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    NSLog(@"%@", self.indexArr);
    return [self.indexArr objectAtIndex:section - 1];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArr;
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

- (NSMutableArray *)indexArr {
    if (!_indexArr) {
        _indexArr = [NSMutableArray array];
        for (RSContactsModel *model in self.allDatas) {
            static NSString *tmpStr = nil;
            if (model.indexStr == tmpStr || model.indexStr.length < 1) {
                continue;
            }

            [_indexArr addObject:model.indexStr];
            
            tmpStr = model.indexStr;
        }
    }
    return _indexArr;
}

@end
