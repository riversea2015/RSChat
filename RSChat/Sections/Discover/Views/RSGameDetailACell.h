//
//  RSGameDetailACell.h
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSGameDetailACell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

+ (NSString *)cellID;
+ (CGFloat)cellHeight;
+ (void)registToTableView:(UITableView *)tableView;

- (void)setScrollWithArray:(NSArray *)imageArray;

@end
