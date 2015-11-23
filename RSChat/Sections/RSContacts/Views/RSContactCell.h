//
//  RSContactCell.h
//  RSChat
//
//  Created by hehai on 11/14/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSContactsModel.h"

@interface RSContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;

+ (NSString *)cellID;
- (void)setCellWithModel:(RSContactsModel *)model;

@end
