//
//  RSFriendsACell.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSFriendsACell.h"

@implementation RSFriendsACell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:@"RSFriendsACell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RSFriendsACell"];
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 126;
}

@end
