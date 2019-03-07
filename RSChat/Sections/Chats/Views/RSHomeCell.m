//
//  RSHomeCell.m
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSHomeCell.h"
#import "UIImage+RSExts.h"

@implementation RSHomeCell

+ (CGFloat)rowHeight {
    return 65;
}

- (void)setCellWithModel:(RSHomeModel *)model {
    self.leftImageView.image = [UIImage imageName:model.leftImageName];
    self.leftLabel.text = model.leftText;
    self.rightLabel.text = model.rightText;
    self.bottomLabel.text = model.bottomText;

    if (model.badgeNumberText.length == 0) {
        self.badgeNumLabel.hidden = YES;
    } else {
        self.badgeNumLabel.hidden = NO;
        self.badgeNumLabel.text = [NSString stringWithFormat:@"%@ ",model.badgeNumberText];
    }

}

@end
