//
//  RSShakeViewController.m
//  RSChat
//
//  Created by hehai on 11/29/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSShakeViewController.h"

@interface RSShakeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation RSShakeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"摇一摇";
}

#pragma mark - 摇一摇

/*开始摇一摇*/
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionBegan");
    self.resultLabel.text = nil;

}

/*摇一摇结束(需要在这里处理摇晃动作结束后的代码)*/
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //判断是否为 摇一摇事件
    if (motion != UIEventSubtypeMotionShake) {
        return;
    }
    NSLog(@"motionEnded");
    self.resultLabel.text = @"摇一摇结束";
}

/*摇一摇取消(被中断，比如 突然来了电话)*/
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancel");
}

@end
