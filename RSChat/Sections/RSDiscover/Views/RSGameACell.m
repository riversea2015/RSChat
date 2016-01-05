//
//  RSGameACell.m
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSGameACell.h"

@implementation RSGameACell

// 将这些方法抽出来，做一个baseCell，以后的都继承自它；

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 88;
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([self class])];
}

- (void)setCellWithModel:(id)model atIndexPath:(NSIndexPath *)indePath{
    // for subClass
}

@end
