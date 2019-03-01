//
//  RSMeHeaderCell.h
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSMeModel.h"

@interface RSMeHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

+ (NSString *)cellID;
- (void)setWithModel:(RSMeModel *)model;
+ (CGFloat)rowHeight;
@end
