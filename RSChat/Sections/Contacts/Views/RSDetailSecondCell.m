//
//  RSDetailSecondCell.m
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSDetailSecondCell.h"

@implementation RSDetailSecondCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight {
    return 87;
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

@end
