//
//  RSEmotionACell.h
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSEmotionACell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

+ (NSString *)cellID;
+ (CGFloat)cellHeight;
+ (void)registToTableView:(UITableView *)tableView;

@end
