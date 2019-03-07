//
//  RSOfficialCell.h
//  RSChat
//
//  Created by hehai on 12/18/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>

@interface RSOfficialCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (void)registToTableView:(UITableView *)tableView;
+ (NSString *)cellID;
+ (CGFloat)cellHeight;

@end
