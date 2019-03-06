//
//  RSChatToolBar.m
//  RSChat
//
//  Created by hehai on 2019/3/6.
//  Copyright © 2019 hehai. All rights reserved.
//

#import "RSChatToolBar.h"
#import <Masonry/Masonry.h>

@interface RSChatToolBar ()<UITextFieldDelegate>

///
@property (nonatomic, strong) UIButton *voiceBtn;
///
@property (nonatomic, strong) UITextField *inputView;
///
@property (nonatomic, strong) UIButton *emotionBtn;
///
@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation RSChatToolBar

+ (instancetype)creatWithframe:(CGRect)frame {
    RSChatToolBar *toolBar = [[RSChatToolBar alloc] initWithFrame:frame];
    return toolBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildViews];
    }
    return self;
}

- (void)setupChildViews {
    self.backgroundColor = [UIColor whiteColor];
    
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self).offset(5);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.right.equalTo(self).offset(-8);
        make.top.equalTo(self).offset(5);
    }];
    
    [self.emotionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.right.equalTo(self.moreBtn.mas_left).offset(-8);
        make.top.equalTo(self).offset(5);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35);
        make.left.equalTo(self.voiceBtn.mas_right).offset(8);
        make.right.equalTo(self.emotionBtn.mas_left).offset(-8);
        make.top.equalTo(self).offset(5);
    }];
}

- (void)clickVoiceBtn {
    
}

- (void)clickEmotionBtn {
    
}

- (void)clickMoreBtn {
    
}

#pragma mark -

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_sendBlock) {
        _sendBlock(textField.text);
    }
    textField.text = @"";
    return YES;
}

#pragma mark -

- (UIButton *)voiceBtn { // 35x35
    if (!_voiceBtn) {
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn setImage:[UIImage imageNamed:@"ToolViewInputVoice"] forState:UIControlStateNormal];
        [_voiceBtn addTarget:self action:@selector(clickVoiceBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_voiceBtn];
    }
    return _voiceBtn;
}

- (UITextField *)inputView {
    if (!_inputView) {
        _inputView = [[UITextField alloc] init];
        _inputView.borderStyle = UITextBorderStyleRoundedRect;
        _inputView.delegate = self;
        [self addSubview:_inputView];
    }
    return _inputView;
}

- (UIButton *)emotionBtn {
    if (!_emotionBtn) {
        _emotionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emotionBtn setImage:[UIImage imageNamed:@"ToolViewEmotion"] forState:UIControlStateNormal];
        [_emotionBtn addTarget:self action:@selector(clickEmotionBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_emotionBtn];
    }
    return _emotionBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"TypeSelectorBtn_Black"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(clickMoreBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
    }
    return _moreBtn;
}

@end
