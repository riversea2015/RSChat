//
//  RSFavoriteCell.h
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSFavoriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

+ (NSString *)cellID;
+ (CGFloat)cellHeight;
+ (void)registToTableView:(UITableView *)tableView;

@end
