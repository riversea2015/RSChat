//
//  RSMoneyACell.h
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSMoneyACell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *moneyImageView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

+ (NSString *)cellID;
+ (CGFloat)cellHeight;
+ (void)registToCollectionView:(UICollectionView *)tableView;

@end
