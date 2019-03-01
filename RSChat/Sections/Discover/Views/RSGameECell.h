//
//  RSGameECell.h
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSGameECell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

+ (NSString *)cellID;
+ (CGFloat)cellHeight;
+ (void)registToTableView:(UITableView *)tableView;

@end
