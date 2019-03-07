//
//  RSMessageVideoCell.h
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+RSExts.h"

@interface RSMessageVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bkIMageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (CGFloat)rowHeight;
+ (NSString *)cellID;

@end
