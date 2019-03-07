//
//  RSPopView.m
//  RSChat
//
//  Created by hehai on 12/17/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSPopView.h"
#import "RSScanViewController.h"
#import "RSChatMacro.h"

@interface RSPopView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgY;

@end

@implementation RSPopView

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgY.constant = RSNavBarH;
    _contentY.constant = RSNavBarH + 20;
}

@end
