//
//  RSMeModel.h
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMeModel : NSObject
@property (nonatomic, copy) NSString *leftImageName; // 公用
@property (nonatomic, copy) NSString *topText;
@property (nonatomic, copy) NSString *bottomText;

@property (nonatomic, copy) NSString *leftText;
@property (nonatomic, copy) NSString *rightText;
@property (nonatomic, copy) NSString *middleImageName;
@property (nonatomic, copy) NSString *rightImageName;

@property (nonatomic, strong) NSArray *headerArr;
@property (nonatomic, strong) NSArray *otherArr;

@end
