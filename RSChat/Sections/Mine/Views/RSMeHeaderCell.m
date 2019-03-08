//
//  RSMeHeaderCell.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMeHeaderCell.h"
#import "UIImage+RSExts.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RSMeHeaderCell ()

@end

@implementation RSMeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWithModel:(RSMeModel *)model {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.leftImageName] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
    self.topLabel.text = model.topText;
    self.bottomLabel.text = model.bottomText;
}

+ (CGFloat)rowHeight {
    return 87;
}

@end
