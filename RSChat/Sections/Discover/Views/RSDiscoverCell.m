//
//  RSDiscoverCell.m
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSDiscoverCell.h"
#import "UIImage+RSExts.h"

@implementation RSDiscoverCell

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
    return 44;
}

- (void)setCellWithModel:(RSDiscoverModel *)model {
    self.leftImageView.image = [UIImage imageName:model.leftImageName];
    self.rightImageView.image = [UIImage imageName:model.rightImageName];
    self.leftLabel.text = model.leftText;
    self.rightLabel.text = model.rightText;
}

@end
