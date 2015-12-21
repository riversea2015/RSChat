//
//  RSPopView.h
//  RSChat
//
//  Created by hehai on 12/17/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *groupChat;
@property (weak, nonatomic) IBOutlet UIButton *friends;
@property (weak, nonatomic) IBOutlet UIButton *scan;
@property (weak, nonatomic) IBOutlet UIButton *money;

@property (nonatomic, assign) NSInteger flag;

@end
