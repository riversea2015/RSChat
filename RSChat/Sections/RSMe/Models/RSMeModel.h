//
//  RSMeModel.h
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMeModel : NSObject
@property (nonatomic, strong) NSString *leftImageName; // 公用
@property (nonatomic, strong) NSString *topText;
@property (nonatomic, strong) NSString *bottomText;

@property (nonatomic, strong) NSString *leftText;
@property (nonatomic, strong) NSString *rightText;
@property (nonatomic, strong) NSString *middleImageName;
@property (nonatomic, strong) NSString *rightImageName;

@property (nonatomic, strong) NSArray *headerArr;
@property (nonatomic, strong) NSArray *otherArr;

@end
