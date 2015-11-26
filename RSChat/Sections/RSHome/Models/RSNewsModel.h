//
//  RSNewsModel.h
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSNewsModel : NSObject
// 原版
@property (nonatomic, strong) NSString *comment_date;
@property (nonatomic, strong) NSString *comment_contents;
@property (nonatomic, strong) NSURL *faceurl;

// 修订版
//@property (nonatomic, strong) NSString *updateTime; // 更新时间
//@property (nonatomic, strong) NSString *thumbnail;  // 图片
//@property (nonatomic, strong) NSString *title;      // 标题

+ (id)parseJSONData:(NSDictionary *)dic;

@end
