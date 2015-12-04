//
//  RSPrivateViewController.m
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSPrivateViewController.h"
#import "RSPrivateTableViewCell.h"
#import "RSPrivateOtherCell.h"
#import "RSMePrivateModel.h"
#import "UIImage+RSSet.h"

@interface RSPrivateViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *demoArray;

@end

@implementation RSPrivateViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self.tableView registerNib:[UINib nibWithNibName:[RSPrivateOtherCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSPrivateOtherCell cellID]];
    [self.tableView registerNib:[UINib nibWithNibName:[RSPrivateTableViewCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSPrivateTableViewCell cellID]];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        RSPrivateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSPrivateTableViewCell cellID] forIndexPath:indexPath];
        // cell相关设置。。。
        return cell;
    }
    
    RSPrivateOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSPrivateOtherCell cellID] forIndexPath:indexPath];
    RSMePrivateModel *model = [[RSMePrivateModel alloc] init];
    if (indexPath.section == 0) {
        model = self.demoArray[indexPath.row-1];
    }
    if (indexPath.section == 1) {
        model = self.demoArray[indexPath.row+4];
    }

    cell.leftLabel.text = model.leftText;
    cell.rightLabel.text = model.rightText;
    cell.rightImageView.image = [UIImage imageName:model.rightImageName];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [RSPrivateTableViewCell rowheight];
    }
#warning TODO 应改为自动变高
    if (indexPath.section == 1 && indexPath.row == 2) {
        return 80;
    }
    return [RSPrivateOtherCell rowheight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
        [sheet showInView:self.view];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"点击了ActionSheet。。。");
}

#pragma mark - setter getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSArray *)demoArray {
    if (!_demoArray) {
        _demoArray = [RSMePrivateModel demoData];
    }
    return _demoArray;
}

@end
