//
//  RSContactCell.m
//  RSChat
//
//  Created by hehai on 11/14/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSContactCell.h"

@implementation RSContactCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellID {
    return NSStringFromClass([RSContactCell class]);
}

+ (CGFloat)cellHeight {
    return 55;
}

- (void)setCellWithModel:(RSContactsModel *)model {
    self.contactImageView.image = [UIImage imageNamed:model.contactImageName];
    self.contactNameLabel.text = model.contactName;
}

@end
