//
//  RSGameDetailACell.h
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UITableViewCell+RSExts.h"

@interface RSGameDetailACell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)setScrollWithArray:(NSArray *)imageArray;

@end
