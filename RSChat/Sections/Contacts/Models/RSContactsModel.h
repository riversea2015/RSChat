//
//  RSContactsModel.h
//  RSChat
//
//  Created by hehai on 11/13/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSContactsModel : NSObject
@property (nonatomic, copy) NSString *contactImageName;
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *indexStr;

@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, copy) NSString *telNumStr;
@property (nonatomic, copy) NSString *district;

@property (nonatomic, assign) BOOL isMale;

+ (NSArray *)demoData;

@end
