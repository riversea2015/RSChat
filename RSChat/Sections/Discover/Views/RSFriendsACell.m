//
//  RSFriendsACell.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSFriendsACell.h"

@implementation RSFriendsACell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"RSFriendsACell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RSFriendsACell"];
}

+ (CGFloat)rowHeight {
    return 126;
}

@end
