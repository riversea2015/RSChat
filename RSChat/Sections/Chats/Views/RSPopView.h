//
//  RSPopView.h
//  RSChat
//
//  Created by hehai on 12/17/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSPopView : UIView

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *popButtons;
@property (nonatomic, assign) NSInteger flag;

@end
