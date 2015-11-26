//
//  RSNewsModel.m
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSNewsModel.h"

@implementation RSNewsModel

+ (id)parseJSONData:(NSDictionary *)dic {
    return [[self alloc] initWithJson:dic];
}

// 原版
- (id)initWithJson:(NSDictionary *)dic {
    if (self = [super init]) {
        _comment_date = dic[@"comment_date"];
        _comment_contents = dic[@"comment_contents"];
        NSString *urlStr = dic[@"faceurl"];
        _faceurl = [NSURL URLWithString:urlStr];
    }
    return self;
}

// 修订版
//- (id)initWithJson:(NSDictionary *)dic {
//    if (self = [super init]) {
//        _comment_date = dic[@"comment_date"];
//        _comment_contents = dic[@"comment_contents"];
//        NSString *urlStr = dic[@"faceurl"];
//        _faceurl = [NSURL URLWithString:urlStr];
//    }
//    return self;
//}

@end
