//
//  UICollectionViewCell+RSExts.m
//  RSChat
//
//  Created by hehai on 2019/3/6.
//  Copyright © 2019 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "UICollectionViewCell+RSExts.h"

@implementation UICollectionViewCell (RSExts)

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (void)registerNibToCollectionView:(UICollectionView *)collectionView {
    [collectionView registerNib:[UINib nibWithNibName:[self cellID] bundle:[NSBundle mainBundle]]
     forCellWithReuseIdentifier:[self cellID]];
}

+ (void)registerClassToCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self cellID]];
}

@end
