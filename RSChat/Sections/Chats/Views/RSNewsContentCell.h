//
//  RSNewsContentCell.h
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+RSExts.h"

@interface RSNewsContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@end
