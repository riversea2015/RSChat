//
//  RSAddFriendCell.m
//  RSChat
//
//  Created by hehai on 1/5/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSAddFriendCell.h"

@implementation RSAddFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 59;
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([self class])];
}

@end
