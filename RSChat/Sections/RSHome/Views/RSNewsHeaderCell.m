//
//  RSNewsHeaderCell.m
//  RSChat
//
//  Created by hehai on 11/25/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSNewsHeaderCell.h"

@implementation RSNewsHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)rowHeight {
    return 172;
}

#warning 注意：一开始这里的cell中的Label无法显示，然后，运行了加了底下这个，就好了，注释后，一人能够正常运行
//- (void)drawRect:(CGRect)rect {
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
//        [self layoutIfNeeded];
//    }
//}

@end
