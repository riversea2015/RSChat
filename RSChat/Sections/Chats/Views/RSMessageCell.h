//
//  RSMessageCell.h
//  RSChat
//
//  Created by hehai on 11/24/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSMessageModel.h"
#import "UITableViewCell+RSExts.h"

@interface RSMessageCell : UITableViewCell

@property (nonatomic, strong) RSMessageModel *message;
@property (nonatomic, strong) UIImageView *titleImageView;

@end


