//
//  RSAutoDisplayCell.h
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UITableViewCell+RSExts.h"

@interface RSAutoDisplayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger flag; // 第几个imageView被点击
@property (nonatomic, assign) NSInteger cellFlag ; // 是哪一个cell

- (void)setScrollWithArray:(NSArray *)imageArray;

@end
