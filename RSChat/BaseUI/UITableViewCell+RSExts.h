//
//  UITableViewCell+RSExts.h
//  RSChat
//
//  Created by hehai on 2019/3/6.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (RSExts)

+ (NSString *)cellID;

+ (void)registerNibToTableView:(UITableView *)tableView;

+ (void)registerClassToTableView:(UITableView *)tableView;

/// Need to be overrided by subclass
+ (CGFloat)rowHeight;

@end

NS_ASSUME_NONNULL_END
