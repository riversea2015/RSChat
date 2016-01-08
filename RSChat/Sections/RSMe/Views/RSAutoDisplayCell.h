//
//  RSAutoDisplayCell.h
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAutoDisplayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger flag; // 第几个imageView被点击
@property (nonatomic, assign) NSInteger cellFlag ; // 是哪一个cell

+ (NSString *)cellID;
+ (CGFloat)cellHeight;
+ (void)registToTableView:(UITableView *)tableView;

- (void)setScrollWithArray:(NSArray *)imageArray;

@end
