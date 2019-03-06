//
//  UITableViewCell+RSExts.m
//  RSChat
//
//  Created by hehai on 2019/3/6.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UITableViewCell+RSExts.h"

@implementation UITableViewCell (RSExts)

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (void)registerNibToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:[self cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[self cellID]];
}

+ (void)registerClassToTableView:(UITableView *)tableView {
    [tableView registerClass:[self class] forCellReuseIdentifier:[self cellID]];
}

+ (CGFloat)rowHeight {
    return 44;
}

@end
