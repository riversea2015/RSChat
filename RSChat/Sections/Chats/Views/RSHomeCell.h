//
//  RSHomeCell.h
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>
#import "RSHomeModel.h"
#import "UITableViewCell+RSExts.h"

@interface RSHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *badgeNumberImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeNumLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *badgeImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *badgeLabelWidth;

- (void)setCellWithModel:(RSHomeModel *)model;

@end
