//
//  RSNewsContentCell.m
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSNewsContentCell.h"

@implementation RSNewsContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight {
    return 60;
}

+ (NSString *)cellID {
    return NSStringFromClass([RSNewsContentCell class]);
}

@end
