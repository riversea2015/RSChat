//
//  RSContactsModel.m
//  RSChat
//
//  Created by hehai on 11/13/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSContactsModel.h"

@implementation RSContactsModel

- (NSArray *)contactArr {
    if (!_contactArr) {
        RSContactsModel *model1 = [RSContactsModel new];
        model1.contactImageName = @"plugins_FriendNotify";
        model1.contactName = @"新的朋友";
        RSContactsModel *model2 = [RSContactsModel new];
        model2.contactImageName = @"add_friend_icon_addgroup";
        model2.contactName = @"群聊";
        RSContactsModel *model3 = [RSContactsModel new];
        model3.contactImageName = @"Contact_icon_ContactTag";
        model3.contactName = @"标签";
        RSContactsModel *model4 = [RSContactsModel new];
        model4.contactImageName = @"add_friend_icon_offical";
        model4.contactName = @"公众号";
        
        RSContactsModel *model5 = [RSContactsModel new];
        model5.contactImageName = @"cartoon_1";
        model5.contactName = @"Jone";
        RSContactsModel *model6 = [RSContactsModel new];
        model6.contactImageName = @"cartoon_2";
        model6.contactName = @"Monkey";
        RSContactsModel *model7 = [RSContactsModel new];
        model7.contactImageName = @"cartoon_3";
        model7.contactName = @"千山暮雪";
        RSContactsModel *model8 = [RSContactsModel new];
        model8.contactImageName = @"cartoon_4";
        model8.contactName = @"过客";
        RSContactsModel *model9 = [RSContactsModel new];
        model9.contactImageName = @"cartoon_5";
        model9.contactName = @"飞翔的兔子";
        RSContactsModel *model10 = [RSContactsModel new];
        model10.contactImageName = @"cartoon_6";
        model10.contactName = @"Amber";
        RSContactsModel *model11 = [RSContactsModel new];
        model11.contactImageName = @"cartoon_7";
        model11.contactName = @"云淡风轻";
        RSContactsModel *model12 = [RSContactsModel new];
        model12.contactImageName = @"cartoon_8";
        model12.contactName = @"司马不平";
        RSContactsModel *model13 = [RSContactsModel new];
        model13.contactImageName = @"cartoon_9";
        model13.contactName = @"忘忧草";
        
        _contactArr = @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12, model13];
    }
    return _contactArr;
}

@end
