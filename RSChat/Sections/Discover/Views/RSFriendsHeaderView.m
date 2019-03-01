//
//  RSFriendsHeaderView.m
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSFriendsHeaderView.h"

@implementation RSFriendsHeaderView

- (void)awakeFromNib {
    self.titleButton.layer.cornerRadius = 5;
    self.titleButton.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
