//
//  RSDetailFirstCell.h
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+RSExts.h"
#import "RSContactsModel.h"

@interface RSDetailFirstCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

///
@property (nonatomic, strong) RSContactsModel *contact;

+ (CGFloat)rowHeight;
+ (NSString *)cellID;

@end
