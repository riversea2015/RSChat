//
//  RSPrivateTableViewCell.m
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSPrivateTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface RSPrivateTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *logoBtn;

@end

@implementation RSPrivateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)rowHeight {
    return 81;
}

- (void)setLogoImgName:(NSString *)logoImgName {
    _logoImgName = logoImgName;
    
    [_logoBtn sd_setImageWithURL:[NSURL URLWithString:logoImgName] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
}

@end
