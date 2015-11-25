//
//  RSMessageModel.h
//  RSChat
//
//  Created by hehai on 11/24/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 作用：存储消息:内容、发出方
 */
@interface RSMessageModel : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL fromMe;

+ (NSArray *)demoData;

@end
