//
//  RSMeHeaderCell.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMeHeaderCell.h"
#import "UIImage+RSSet.h"

@implementation RSMeHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

- (void)setWithModel:(RSMeModel *)model {
    self.leftImageView.image = [UIImage imageName:model.leftImageName];
    self.topLabel.text = model.topText;
    self.bottomLabel.text = model.bottomText;
}

+ (CGFloat)rowHeight {
    return 87;
}

@end
