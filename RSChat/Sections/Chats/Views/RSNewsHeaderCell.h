//
//  RSNewsHeaderCell.h
//  RSChat
//
//  Created by hehai on 11/25/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSNewsHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *headerTextLabel;

+ (NSString *)cellID;
+ (CGFloat)rowHeight;

@end
