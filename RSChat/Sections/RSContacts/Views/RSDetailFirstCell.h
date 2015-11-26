//
//  RSDetailFirstCell.h
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDetailFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

+ (CGFloat)rowHeight;
+ (NSString *)cellID;

@end
