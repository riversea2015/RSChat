//
//  RSOfficialCell.m
//  RSChat
//
//  Created by hehai on 12/18/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSOfficialCell.h"

@implementation RSOfficialCell

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:[self cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[self cellID]];
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 65;
}

@end
