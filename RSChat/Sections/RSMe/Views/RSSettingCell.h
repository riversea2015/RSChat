//
//  RSSettingCell.h
//  RSChat
//
//  Created by hehai on 12/30/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

+ (CGFloat)cellHeight;
+ (NSString *)cellID;
+ (void)registToTableView:(UITableView *)tableView;

@end
