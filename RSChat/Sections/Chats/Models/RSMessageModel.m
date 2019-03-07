//
//  RSMessageModel.m
//  RSChat
//
//  Created by hehai on 11/24/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSMessageModel.h"

@implementation RSMessageModel

+ (NSArray *)demoData {
    RSMessageModel *message1 = [[RSMessageModel alloc] init];
    message1.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message1.fromMe = YES;
    RSMessageModel *message2 = [[RSMessageModel alloc] init];
    message2.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message2.fromMe = NO;
    RSMessageModel *message3 = [[RSMessageModel alloc] init];
    message3.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message3.fromMe = YES;
    RSMessageModel *message4 = [[RSMessageModel alloc] init];
    message4.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message4.fromMe = NO;
    RSMessageModel *message5 = [[RSMessageModel alloc] init];
    message5.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message5.fromMe = YES;
    RSMessageModel *message6 = [[RSMessageModel alloc] init];
    message6.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message6.fromMe = NO;
    RSMessageModel *message7 = [[RSMessageModel alloc] init];
    message7.content = @"测试数据";
    message7.fromMe = YES;
    RSMessageModel *message8 = [[RSMessageModel alloc] init];
    message8.content = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
    message8.fromMe = NO;
    
    return @[message1, message2, message3, message4, message5, message6, message7, message8];
}

@end
