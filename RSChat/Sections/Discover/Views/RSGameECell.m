//
//  RSGameECell.m
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSGameECell.h"

@implementation RSGameECell

+ (CGFloat)rowHeight {
    return 80;
}

- (void)setCellWithModel:(id)model atIndexPath:(NSIndexPath *)indePath{
    // for subClass
}

- (IBAction)enterItunesStore:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wo-jiaomt2-zhou-nian-xiang/id932346202?l=en&mt=8"]];
}
@end
