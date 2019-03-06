//
//  RSChatToolBar.h
//  RSChat
//
//  Created by hehai on 2019/3/6.
//  Copyright © 2019 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSChatToolBar : UIView

///
@property (nonatomic, copy) void(^sendBlock)(NSString *msg);

+ (instancetype)creatWithframe:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
