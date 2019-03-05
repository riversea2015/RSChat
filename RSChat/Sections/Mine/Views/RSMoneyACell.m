//
//  RSMoneyACell.m
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSMoneyACell.h"

@implementation RSMoneyACell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 80;
}

+ (void)registToCollectionView:(UICollectionView *)collectionView {
    [collectionView registerNib:[UINib nibWithNibName:[self cellID] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[self cellID]];
}

@end
