//
//  RSDiscoverModel.h
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSDiscoverModel : NSObject
@property (nonatomic, copy) NSString *leftImageName; //
@property (nonatomic, copy) NSString *leftText; //
@property (nonatomic, copy) NSString *rightImageName;
@property (nonatomic, copy) NSString *rightText;

+ (NSArray *)demoData;

@end
