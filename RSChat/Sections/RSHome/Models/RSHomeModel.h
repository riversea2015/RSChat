//
//  RSHomeModel.h
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSHomeModel : NSObject
@property (nonatomic, strong) NSString *leftImageName;
@property (nonatomic, strong) NSString *leftText;
@property (nonatomic, strong) NSString *rightText;
@property (nonatomic, strong) NSString *bottomText;
//@property (nonatomic, strong) NSString *badgeNumberImageName;
@property (nonatomic, strong) NSString *badgeNumberText;

@property (nonatomic, strong) NSArray *homeArr;

@end
