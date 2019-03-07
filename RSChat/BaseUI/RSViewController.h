//
//  RSViewController.h
//  RSChat
//
//  Created by hehai on 2019/3/1.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) UIEdgeInsets separatorInset;

- (void)showHUD;
- (void)hideHUD;
- (void)showHUDInView:(UIView *)view animated:(BOOL)animated;
- (void)hideHUDInView:(UIView *)view animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
