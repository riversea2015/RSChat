//
//  RSHomeSearchResultController.m
//  RSChat
//
//  Created by hehai on 11/27/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSHomeSearchResultController.h"
#import "RSHomeModel.h"
#import "RSMessageViewController.h"

@interface RSHomeSearchResultController ()

@end

@implementation RSHomeSearchResultController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell1"];
}


#pragma mark - TableView dataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
    RSHomeModel *model = self.resultArray[indexPath.row];
    
    cell.textLabel.text = model.leftText;
    cell.imageView.image = [UIImage imageNamed:model.leftImageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了搜索内容...");
    
    RSMessageViewController *messageVC = [[RSMessageViewController alloc] init];
    RSHomeModel *model = self.resultArray[indexPath.row];
    messageVC.homeModel = model;
    
//    [self.navigationController pushViewController:messageVC animated:NO];
    
    self.navi = [[UINavigationController alloc] initWithRootViewController:messageVC];
    [self.navigationController presentViewController:self.navi animated:NO completion:nil];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setter getter

@end
