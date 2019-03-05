//
//  RSGameDetailViewController.m
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSGameDetailViewController.h"

#import "RSGameDetailHeader.h"
#import "RSGameDetailACell.h"
#import "RSGameDetailBCell.h"

@interface RSGameDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *demoArr;

@end

@implementation RSGameDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏详情";
    
    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"RSGameDetailHeader" owner:self options:nil] lastObject];
    
    [RSGameDetailACell registToTableView:self.tableView];
    [RSGameDetailBCell registToTableView:self.tableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(settings)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)settings {
    // ...
}

#pragma mark - Navigation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        RSGameDetailACell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameDetailACell cellID] forIndexPath:indexPath];
        
        [cell setScrollWithArray:self.demoArr];
        
        return cell;
    }
    
    RSGameDetailBCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSGameDetailBCell cellID] forIndexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [RSGameDetailACell cellHeight];
    }
    return [RSGameDetailBCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    
    CGRect frame = HeaderView.bounds;
    frame.origin.x = HeaderView.bounds.origin.x + 15;
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13];
    
    if (section == 0) {
        label.text = @"内容摘要";
    }
    
    if (section == 1) {
        label.text = @"游戏攻略";
    }
    
    [HeaderView addSubview:label];
    
    return HeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 进入游戏下载页面

- (IBAction)enterItunesStore:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wo-jiaomt2-zhou-nian-xiang/id932346202?l=en&mt=8"]];
}

#pragma mark - setter getter

- (NSArray *)demoArr {
    if (!_demoArr) {
        _demoArr = @[@"game_e", @"game_f", @"game_g", @"game_h", @"game_i"];
    }
    return _demoArr;
}

@end
