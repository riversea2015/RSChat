//
//  RSMessageModel.h
//  RSChat
//
//  Created by hehai on 11/24/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <Foundation/Foundation.h>

/**
 作用：存储消息:内容、发出方
 */
@interface RSMessageModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL fromMe;

+ (NSArray *)demoData;

@end
