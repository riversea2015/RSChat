//
//  RSMeOtherCell.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMeOtherCell.h"
#import "UIImage+RSExts.h"

@implementation RSMeOtherCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

- (void)setWithModel:(RSMeModel *)model {
    self.leftImageView.image = [UIImage imageName:model.leftImageName];
    self.leftLabel.text = model.leftText;
    self.middleImageView.image = [UIImage imageName:model.middleImageName];
    self.rightLabel.text = model.rightText;
    self.rightImageView.image = [UIImage imageName:model.rightImageName];
    
}

+ (CGFloat)rowHeight {
    return 44;
}

@end
