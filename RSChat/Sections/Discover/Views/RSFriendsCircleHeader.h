//
//  RSFriendsCircleHeader.h
//  RSChat
//
//  Created by hehai on 12/5/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSFriendsCircleHeader : UIView

@property (nonatomic, copy) void(^changeBgBlock)(void);

@property (nonatomic, copy) void(^reviewInfoBlock)(void);

@end
