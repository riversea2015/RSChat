//
//  RSNewFriendCell.m
//  RSChat
//
//  Created by hehai on 12/17/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSNewFriendCell.h"

@implementation RSNewFriendCell

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:[self cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[self cellID]];
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 43;
}

@end
