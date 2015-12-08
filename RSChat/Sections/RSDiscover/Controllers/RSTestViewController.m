//
//  RSTestViewController.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSTestViewController.h"

@interface RSTestViewController ()
<UITableViewDataSource, UITableViewDelegate>

@end

@implementation RSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  23
/*
 高度都缓存到cell对应的Mdoel里
 cellH
 cellID
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    /*
//     Model.cellID
//     tableview dequeuereusecell:cellID ==Cell
//     fillData:(id){
//     id iskinkofclass
//       cell filldata:data
//     
//     }
//     */
//    BOOL isTrue = [tableView respondsToSelector:@selector(fillData:)];
//    [tableView performSelector:@selector(fillData:) withObject:nil];
//}
@end
