//
//  RSDetailSecondCell.h
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UITableViewCell+RSExts.h"
#import "RSContactsModel.h"

@interface RSDetailSecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
///
@property (nonatomic, strong) RSContactsModel *contact;

+ (CGFloat)rowHeight;
+ (NSString *)cellID;

@end
