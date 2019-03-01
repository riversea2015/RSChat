//
//  RSHomeCell.m
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSHomeCell.h"
#import "UIImage+RSExts.h"

@implementation RSHomeCell

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)rowHeight {
    return 65;
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:[RSHomeCell cellID] bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[RSHomeCell cellID]];
}

- (void)setCellWithModel:(RSHomeModel *)model {
    self.leftImageView.image = [UIImage imageName:model.leftImageName];
    self.leftLabel.text = model.leftText;
    self.rightLabel.text = model.rightText;
    self.bottomLabel.text = model.bottomText;
//    self.badgeNumberImageView.image = [UIImage imageName:model.badgeNumberImageName];

#warning TODO 实现头像角标的红色区域大小随badgeNum的位数多少变化？
    if (model.badgeNumberText.length == 0) {
        self.badgeNumLabel.hidden = YES;
    } else {
        self.badgeNumLabel.hidden = NO;
        self.badgeNumLabel.text = [NSString stringWithFormat:@"%@ ",model.badgeNumberText];
    }

}

@end
