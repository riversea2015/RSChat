//
//  RSFavoritesViewController.m
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSFavoritesViewController.h"
#import "RSFavoriteCell.h"

@interface RSFavoritesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *demoArray;

@end

@implementation RSFavoritesViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    
    [self.view addSubview:self.tableView];
    [RSFavoriteCell registToTableView:self.tableView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addAcontents)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addAcontents {
    //
}

#pragma mark - tableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.demoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSFavoriteCell cellID] forIndexPath:indexPath];
    
    NSDictionary *dic = self.demoArray[indexPath.section];
    cell.topImageView.image = [UIImage imageNamed:dic[@"topImageName"]];
    cell.bottomImageView.image = [UIImage imageNamed:dic[@"bottomImageName"]];
    cell.nameLabel.text = dic[@"nameText"];
    cell.timeLabel.text = dic[@"timeText"];
    cell.contentLabel.text = dic[@"contentText"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RSFavoriteCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setter & getter

- (NSArray *)demoArray {
    if (!_demoArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"favorites" ofType:@"plist"];
        _demoArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _demoArray;
}

@end
