//
//  RSLabelViewController.m
//  RSChat
//
//  Created by hehai on 12/18/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSLabelViewController.h"
#import "RSLabelBlankView.h"

@interface RSLabelViewController ()
@property (nonatomic, strong) RSLabelBlankView *blankView;

@end

@implementation RSLabelViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签";
    
    [self.view addSubview:self.blankView];
}

#pragma mark - Private Method

// ...

#pragma mark - setter getter

- (RSLabelBlankView *)blankView {
    if (!_blankView) {
        _blankView = [[[NSBundle mainBundle] loadNibNamed:@"RSLabelBlankView" owner:self options:nil] lastObject];
    }
    return _blankView;
}

@end
