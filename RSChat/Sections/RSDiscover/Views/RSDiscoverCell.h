//
//  RSDiscoverCell.h
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSDiscoverModel.h"

@interface RSDiscoverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

+ (NSString *)cellID;
+ (CGFloat)rowHeight;

- (void)setCellWithModel:(RSDiscoverModel *)model;

@end
