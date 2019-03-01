//
//  RSDiscoverModel.m
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSDiscoverModel.h"

@implementation RSDiscoverModel

+ (NSArray *)demoData {
    RSDiscoverModel *model1 = [RSDiscoverModel new];
    model1.leftImageName = @"ff_IconShowAlbum";
    model1.leftText = @"朋友圈";
    model1.rightImageName = nil;
    RSDiscoverModel *model2 = [RSDiscoverModel new];
    model2.leftImageName = @"ff_IconQRCode";
    model2.leftText = @"扫一扫";
    model2.rightImageName = nil;
    RSDiscoverModel *model3 = [RSDiscoverModel new];
    model3.leftImageName = @"ff_IconShake";
    model3.leftText = @"摇一摇";
    model3.rightImageName = nil;
    RSDiscoverModel *model4 = [RSDiscoverModel new];
    model4.leftImageName = @"ff_IconLocationService";
    model4.leftText = @"附近的人";
    model4.rightImageName = @"FootStep";
    RSDiscoverModel *model5 = [RSDiscoverModel new];
    model5.leftImageName = @"ff_IconBottle";
    model5.leftText = @"漂流瓶";
    model5.rightImageName = nil;
    RSDiscoverModel *model6 = [RSDiscoverModel new];
    model6.leftImageName = @"CreditCard_ShoppingBag";
    model6.leftText = @"购物";
    model6.rightText = @"京东11.11";
    model6.rightImageName = @"AlbumNewNotify";
    RSDiscoverModel *model7 = [RSDiscoverModel new];
    model7.leftImageName = @"MoreGame";
    model7.leftText = @"游戏";
    model7.rightImageName = nil;
    
    return @[model1, model2, model3, model4, model5, model6, model7];
}

@end
