//
//  RSContactsModel.h
//  RSChat
//
//  Created by hehai on 11/13/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSContactsModel : NSObject
@property (nonatomic, strong) NSString *contactImageName;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *indexStr;

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *telNumStr;
@property (nonatomic, strong) NSString *district;

@property (nonatomic, assign) BOOL isMale;

+ (NSArray *)demoData;

@end
