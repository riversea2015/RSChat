//
//  RSFriendsCircleHeader.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSFriendsCircleHeader.h"
#import <Masonry/Masonry.h>
#import "UIButton+RSExts.h"

@interface RSFriendsCircleHeader ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *logoBtn;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subtitleLab;

@end

@implementation RSFriendsCircleHeader

- (instancetype)initWithFrame:(CGRect)frame { // 60 + 320
    if (self = [super initWithFrame:frame]) {
        [self setupMainViews];
    }
    return self;
}

- (void)setupMainViews {
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(320);
    }];
    
    [self.logoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.bgImageView).offset(18);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-90);
        make.bottom.equalTo(self.bgImageView).offset(-14);
        make.height.mas_equalTo(29);
    }];
    
    [self.subtitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-12);
        make.height.mas_equalTo(29);
    }];
}

#pragma amrk - Action

- (void)reviewUserInfo {
    if (_reviewInfoBlock) {
        _reviewInfoBlock();
    }
}

- (void)changeBgView {
    if (_changeBgBlock) {
        _changeBgBlock();
    }
}

#pragma mark - setter & getter

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friendsHeader_icon"]];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBgView)];
        [_bgImageView addGestureRecognizer:tapGesture];
    }
    return _bgImageView;
}

- (UIButton *)logoBtn {
    if (!_logoBtn) {
        _logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoBtn setImage:[UIImage imageNamed:@"hehai"] forState:UIControlStateNormal];
        [_logoBtn addTarget:self action:@selector(reviewUserInfo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_logoBtn];
    }
    return _logoBtn;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentRight;
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = @"RiverSea";
        [self addSubview:_titleLab];
    }
    return _titleLab;
}

- (UILabel *)subtitleLab {
    if (!_subtitleLab) {
        _subtitleLab = [[UILabel alloc] init];
        _subtitleLab.textAlignment = NSTextAlignmentCenter;
        _subtitleLab.textColor = [UIColor lightGrayColor];
        _subtitleLab.text = @"人生无非是笑笑人家，再被人家笑笑而已！";
        [self addSubview:_subtitleLab];
    }
    return _subtitleLab;
}

@end
