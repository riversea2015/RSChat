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
    [super awakeFromNib];
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
