//
//  RSBottleViewController.m
//  RSChat
//
//  Created by hehai on 12/4/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSBottleViewController.h"

@interface RSBottleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bkImageView;

@end

@implementation RSBottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"漂流瓶";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.navigationController.navigationBarHidden == NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
