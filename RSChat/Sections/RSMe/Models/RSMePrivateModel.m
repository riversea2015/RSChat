//
//  RSMePrivateModel.m
//  RSChat
//
//  Created by hehai on 12/3/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSMePrivateModel.h"

@implementation RSMePrivateModel

+ (NSArray *)demoData {
    RSMePrivateModel *model1 = [[RSMePrivateModel alloc] init];
    model1.leftText = @"名字";
    model1.rightText = @"seamonster";
    RSMePrivateModel *model2 = [[RSMePrivateModel alloc] init];
    model2.leftText = @"微信号";
    model2.rightText = @"riversea2015";
    RSMePrivateModel *model3 = [[RSMePrivateModel alloc] init];
    model3.leftText = @"我的二维码";
    model3.rightImageName = @"setting_myQR";
    RSMePrivateModel *model4 = [[RSMePrivateModel alloc] init];
    model4.leftText = @"我的地址";
    RSMePrivateModel *model5 = [[RSMePrivateModel alloc] init];
    model5.leftText = @"性别";
    model5.rightText = @"男";
    RSMePrivateModel *model6 = [[RSMePrivateModel alloc] init];
    model6.leftText = @"地区";
    model6.rightText = @"中国";
    RSMePrivateModel *model7= [[RSMePrivateModel alloc] init];
    model7.leftText = @"个性签名";
    model7.rightText = @"你若不想做，总会找到借口；你若想做，总会找到方法！";

    return @[model1, model2, model3, model4, model5, model6, model7];
}

@end
