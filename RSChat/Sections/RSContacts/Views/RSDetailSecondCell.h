//
//  RSDetailSecondCell.h
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSDetailSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

+ (CGFloat)rowHeight;
+ (NSString *)cellID;

@end
