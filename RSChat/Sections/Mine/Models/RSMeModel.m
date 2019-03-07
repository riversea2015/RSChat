//
//  RSMeModel.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSMeModel.h"
#import <objc/runtime.h>

@implementation RSMeModel

- (NSArray *)headerArr {
    if (!_headerArr) {
        RSMeModel *model1 = [RSMeModel new];
        model1.leftImageName = @"hehai";
        model1.topText = @"seamonster";
        model1.bottomText = @"riversea2015";
        _headerArr = @[model1];
    }
    return _headerArr;
}

- (NSArray *)otherArr {
    if (!_otherArr) {
        RSMeModel *model1 = [RSMeModel new];
        model1.leftImageName = @"MoreMyAlbum";
        model1.leftText = @"相册";
        model1.rightText = nil;
        model1.middleImageName = nil;
        model1.rightImageName = nil;
        RSMeModel *model2 = [RSMeModel new];
        model2.leftImageName = @"MoreMyFavorites";
        model2.leftText = @"收藏";
        model2.rightText = nil;
        model2.middleImageName = @"Artboard 23";
        model2.rightImageName = nil;
        RSMeModel *model3 = [RSMeModel new];
        model3.leftImageName = @"MoreMyBankCard";
        model3.leftText = @"钱包";
        model3.rightText = nil;
        model3.middleImageName = nil;
        model3.rightImageName = nil;
        RSMeModel *model4 = [RSMeModel new];
        model4.leftImageName = @"EmotionsEmojiHL";
        model4.leftText = @"表情";
        model4.rightText = nil;
        model4.middleImageName = nil;
        model4.rightImageName = @"xiaohuangren";
        RSMeModel *model5 = [RSMeModel new];
        model5.leftImageName = @"MoreSetting";
        model5.leftText = @"设置";
        model5.rightText = @"账号未保护";
        model5.middleImageName = @"Artboard 23";
        model5.rightImageName = nil;
        _otherArr = @[model1, model2, model3, model4, model5];
    }
    return _otherArr;
}

@end
