//
//  RSPrivateTableViewCell.m
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSPrivateTableViewCell.h"

@implementation RSPrivateTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowheight {
    return 81;
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

@end
