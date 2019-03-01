//
//  RSSettingCell.m
//  RSChat
//
//  Created by hehai on 12/30/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSSettingCell.h"

@implementation RSSettingCell

+ (CGFloat)cellHeight {
    return 43;
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"RSSettingCell" bundle:nil] forCellReuseIdentifier:@"RSSettingCell"];
}

@end
