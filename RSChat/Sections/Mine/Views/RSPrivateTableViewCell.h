//
//  RSPrivateTableViewCell.h
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPrivateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

+ (CGFloat)rowheight;
+ (NSString *)cellID;

@end
