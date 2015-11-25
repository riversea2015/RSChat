//
//  RSMessageCell.m
//  RSChat
//
//  Created by hehai on 11/24/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMessageCell.h"

#define CELL_MARGIN_TB     10.0
#define CELL_MARGIN_L      56.0 // 距离有头像那边
#define CELL_TAIL_WIDTH    16
#define CELL_CORNER        18
#define CELL_PADDINHG      8

#define IMAGE_WIDTH        40.0
#define IMAGE_MARGIN_L     10.0 // 距离边框

#define MAX_WIDES_OF_TEXT  200

@interface RSMessageCell ()
// 声明为了显示数据而存在的2个控件
@property (nonatomic, strong) UIImageView *popImageView;
@property (nonatomic, strong) UILabel *popLabel;

@end

@implementation RSMessageCell

#pragma mark - private method

+ (NSString *)cellID {
    return NSStringFromClass([self class]); // 其他地方依此改动
}

#pragma setter getter

- (UIImageView *)popImageView {
    if (!_popImageView) {
        _popImageView = [[UIImageView alloc] init];
    }
    return _popImageView;
}

- (UILabel *)popLabel {
    if (!_popLabel) {
        _popLabel = [[UILabel alloc] init];
        _popLabel.numberOfLines = 0;
    }
    return _popLabel;
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] init];
    }
    return _titleImageView;
}

- (void)setMessage:(RSMessageModel *)message {
    _message = message;
    
    self.popLabel.text = message.content;
    if (message.fromMe) {
        // 右边气泡
        self.popLabel.textColor = [UIColor whiteColor];
        self.popImageView.image = [UIImage imageNamed:@"SenderTextNodeBkg"];
        
        // 1.文本frame
        CGRect rectOfText = [self.popLabel textRectForBounds:CGRectMake(0, 0, MAX_WIDES_OF_TEXT, 999) limitedToNumberOfLines:0];
        CGRect frameOfLabel = CGRectZero;
        frameOfLabel.size = rectOfText.size;
        frameOfLabel.origin.x = self.bounds.size.width - CELL_MARGIN_L - CELL_TAIL_WIDTH - CELL_PADDINHG - rectOfText.size.width;
        frameOfLabel.origin.y = CELL_MARGIN_TB + CELL_PADDINHG;
        self.popLabel.frame = frameOfLabel;
        
        // 2.气泡frame(5和8是因为图片尺寸有问题，在此修正)
        CGRect frameOfImageView = self.popLabel.frame;
        frameOfImageView.origin.x -= CELL_PADDINHG + 10;
        frameOfImageView.origin.y = CELL_MARGIN_TB;
        frameOfImageView.size.width += 2 * CELL_PADDINHG + CELL_TAIL_WIDTH + 5;
        frameOfImageView.size.height += 2 * CELL_PADDINHG + 8;
        self.popImageView.frame = frameOfImageView;
        
        // 3.titileImageView
        CGRect frameOfTitleImage = self.bounds;
        frameOfTitleImage.size = CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH);
        frameOfTitleImage.origin.x = self.bounds.size.width - IMAGE_MARGIN_L - IMAGE_WIDTH;
        frameOfTitleImage.origin.y = CELL_MARGIN_TB;
        self.titleImageView.frame = frameOfTitleImage;
        self.titleImageView.image = [UIImage imageNamed:@"SeaMonster"];
        
        // cell bounds
        CGRect bounds = self.bounds;
        bounds.size.height = frameOfImageView.size.height + 2 * CELL_MARGIN_TB;
        self.bounds = bounds;
        
    } else {
        // 左边气泡
        self.popLabel.textColor = [UIColor darkGrayColor]; //
        self.popImageView.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"] resizableImageWithCapInsets:UIEdgeInsetsMake(CELL_CORNER + 10, CELL_CORNER + CELL_TAIL_WIDTH, CELL_CORNER, CELL_CORNER)]; //
        
        // 1.文本frame
        CGRect rectOfText = [self.popLabel textRectForBounds:CGRectMake(0, 0, MAX_WIDES_OF_TEXT, 999) limitedToNumberOfLines:0];
        CGRect frameOfLabel = CGRectZero;
        frameOfLabel.size = rectOfText.size;
        frameOfLabel.origin.x = CELL_MARGIN_L + CELL_TAIL_WIDTH + CELL_PADDINHG; //
        frameOfLabel.origin.y = CELL_MARGIN_TB + CELL_PADDINHG;
        self.popLabel.frame = frameOfLabel;
        
        // 2.气泡frame
        CGRect frameOfImageView = self.popLabel.frame;
        frameOfImageView.origin.x = CELL_MARGIN_L + 5;
        frameOfImageView.origin.y = CELL_MARGIN_TB;
        frameOfImageView.size.width += 2 * CELL_PADDINHG + CELL_TAIL_WIDTH + 5;
        frameOfImageView.size.height += 2 * CELL_PADDINHG + 8;
        self.popImageView.frame = frameOfImageView;
        
        // 3.titileImageView
        CGRect frameOfTitleImage = self.bounds;
        frameOfTitleImage.size = CGSizeMake(IMAGE_WIDTH, IMAGE_WIDTH);
        frameOfTitleImage.origin.x = IMAGE_MARGIN_L;
        frameOfTitleImage.origin.y = CELL_MARGIN_TB;
        self.titleImageView.frame = frameOfTitleImage;
        self.titleImageView.image = nil;
        
        // cell bounds
#warning TODO 易错点：
        // 易错点：如果下边使用了self.popImageView.frame而不是frameOfImageView的话，后边动态改变cell的高度时，将无法改变，如果po的话，会提示：property 'bounds' not found on object of type 'RSMessageCell *'.
        CGRect bounds = self.bounds;
        bounds.size.height = frameOfImageView.size.height + 2 * CELL_MARGIN_TB;
        self.bounds = bounds;
    }
    // 添加
    [self.contentView addSubview:self.popImageView];
    [self.contentView addSubview:self.popLabel];
    [self.contentView addSubview:self.titleImageView];
}

@end
