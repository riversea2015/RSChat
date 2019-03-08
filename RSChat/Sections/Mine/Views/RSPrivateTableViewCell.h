//
//  RSPrivateTableViewCell.h
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UITableViewCell+RSExts.h"

@interface RSPrivateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (nonatomic, copy) NSString *logoImgName;

@end
