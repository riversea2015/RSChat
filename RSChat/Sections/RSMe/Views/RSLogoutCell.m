//
//  RSLogoutCell.m
//  RSChat
//
//  Created by hehai on 12/30/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSLogoutCell.h"

@implementation RSLogoutCell

+ (CGFloat)cellHeight {
    return 43;
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"RSLogoutCell" bundle:nil] forCellReuseIdentifier:@"RSLogoutCell"];
}

@end
