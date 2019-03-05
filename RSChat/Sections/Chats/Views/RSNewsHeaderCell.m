//
//  RSNewsHeaderCell.m
//  RSChat
//
//  Created by hehai on 11/25/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSNewsHeaderCell.h"

@implementation RSNewsHeaderCell

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

+ (CGFloat)rowHeight {
    return 172;
}

@end
