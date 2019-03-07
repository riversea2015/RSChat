//
//  RSDetailViewController.h
//  RSChat
//
//  Created by hehai on 11/26/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSViewController.h"
#import "RSContactsModel.h"

@interface RSDetailViewController : RSViewController

@property (nonatomic, copy) NSString *lastVCName;
@property (nonatomic, strong) RSContactsModel *contactMdel;

@end
