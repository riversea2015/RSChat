//
//  RSOfficialAccountViewController.m
//  RSChat
//
//  Created by hehai on 12/18/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSOfficialAccountViewController.h"
#import "RSOfficialCell.h"

@interface RSOfficialAccountViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, copy) NSArray *accountArray;
@property (nonatomic, copy) NSMutableArray *sectionIndexArray;

@end

@implementation RSOfficialAccountViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公众号";

    [RSOfficialCell registToTableView:self.tableview];
    [self.view addSubview:self.tableview];
}

#pragma mark - Private Method

// ...

#pragma mark - tableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSOfficialCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSOfficialCell cellID] forIndexPath:indexPath];
    
    NSDictionary *dic = [NSDictionary dictionary];
    if (indexPath.section == 0) {
        dic = self.accountArray[0];
    } else if (indexPath.section == 1) {
        dic = self.accountArray[indexPath.section + indexPath.row];
    } else {
        dic = self.accountArray[indexPath.section + 1];
    }
    
    cell.titleImageView.image = [UIImage imageNamed:dic[@"titleImageName"]];
    cell.nameLabel.text = dic[@"name"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSOfficialCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, [UIScreen mainScreen].bounds.size.width - 26, 22)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    label.text = self.sectionIndexArray[section];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 22)];
    [view addSubview:label];
    
    return view;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexArray;
}

/**
 * 点击某个OfficialAccount时，执行的逻辑...
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setter & getter

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        
        _tableview.sectionIndexColor = [UIColor redColor];
        _tableview.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    return _tableview;
}

/**
 * 这次，使用plist存储数据。
 */
- (NSArray *)accountArray {
    if (!_accountArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"officialAccounts" ofType:@"plist"];
        _accountArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _accountArray;
}

- (NSMutableArray *)sectionIndexArray {
    if (!_sectionIndexArray) {
        _sectionIndexArray = [NSMutableArray array];
        for (NSDictionary *dic in self.accountArray) {
            static NSString *tmpStr = nil;
            NSString *str = dic[@"word"];
            if (str == tmpStr || str.length < 1) {
                continue;
            }
            
            [_sectionIndexArray addObject:dic[@"word"]];
            
            tmpStr = dic[@"word"];
        }
    }
    return _sectionIndexArray;
}

@end
