//
//  RSMePrivateModel.h
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import <Foundation/Foundation.h>

@interface RSMePrivateModel : NSObject
@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;
@property (nonatomic, copy) NSString *rightImageName;

+ (NSArray *)demoData;

@end
