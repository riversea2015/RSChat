//
//  RSPrivateOtherCell.m
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSPrivateOtherCell.h"

@implementation RSPrivateOtherCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowheight {
    return 44;
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

@end
