//
//  RSNewsModel.h
//  RSChat
//
//  Created by hehai on 11/19/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSNewsModel : NSObject
@property (nonatomic, strong) NSString *comment_date;
@property (nonatomic, strong) NSString *comment_contents;
@property (nonatomic, strong) NSURL *faceurl;

+ (id)parseJSONData:(NSDictionary *)dic;

@end
