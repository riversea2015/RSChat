//
//  RSDetailFirstCell.m
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSDetailFirstCell.h"

@implementation RSDetailFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight {
    return 86;
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

- (void)setContact:(RSContactsModel *)contact {
    _contact = contact;
    
    _leftImageView.image = [UIImage imageNamed:contact.contactImageName];
    _topLabel.text = contact.contactName;
    _bottomLabel.text = contact.idStr;
    if (contact.isMale) {
        _rightImageView.image = [UIImage imageNamed:@"Contact_Male"];
    } else {
        _rightImageView.image = [UIImage imageNamed:@"Contact_Female"];
    }
}

@end
