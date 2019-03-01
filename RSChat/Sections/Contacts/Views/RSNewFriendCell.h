//
//  RSNewFriendCell.h
//  RSChat
//
//  Created by hehai on 12/17/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSNewFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (void)registToTableView:(UITableView *)tableView;
+ (NSString *)cellID;
+ (CGFloat)cellHeight;

@end
