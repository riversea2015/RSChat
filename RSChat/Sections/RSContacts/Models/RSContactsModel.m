//
//  RSContactsModel.m
//  RSChat
//
//  Created by hehai on 11/13/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSContactsModel.h"

@implementation RSContactsModel

+ (NSArray *)demoData {
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
    model5.contactImageName = @"cartoon_6";
    model5.contactName = @"Amber";
    model5.indexStr = @"A";
    model5.idStr = @"anber5624576";
    model5.telNumStr = @"13789098767";
    model5.district = @"山西 太原";
    model5.isMale = NO;
    RSContactsModel *model6 = [RSContactsModel new];
    model6.contactImageName = @"cartoon_5";
    model6.contactName = @"飞翔的兔子";
    model6.indexStr = @"F";
    model6.idStr = @"fei354639";
    model6.telNumStr = @"15878902345";
    model6.district = @"吉林 长春";
    model6.isMale = YES;
    RSContactsModel *model7 = [RSContactsModel new];
    model7.contactImageName = @"cartoon_4";
    model7.contactName = @"过客";
    model7.indexStr = @"G";
    model7.idStr = @"guo74672468";
    model7.telNumStr = @"15087909890";
    model7.district = @"黑龙江 哈尔滨";
    model7.isMale = YES;
    RSContactsModel *model8 = [RSContactsModel new];
    model8.contactImageName = @"cartoon_1";
    model8.contactName = @"Jone";
    model8.indexStr = @"J";
    model8.idStr = @"Jone6473674";
    model8.telNumStr = @"13109087891";
    model8.district = @"江西 新余";
    model8.isMale = NO;
    RSContactsModel *model9 = [RSContactsModel new];
    model9.contactImageName = @"cartoon_2";
    model9.contactName = @"Monkey";
    model9.indexStr = @"M";
    model9.idStr = @"Monkey647236";
    model9.telNumStr = @"18690989075";
    model9.district = @"安徽 芜湖";
    model9.isMale = YES;
    RSContactsModel *model10 = [RSContactsModel new];
    model10.contactImageName = @"cartoon_3";
    model10.contactName = @"千山暮雪";
    model10.indexStr = @"Q";
    model10.idStr = @"qian546763";
    model10.telNumStr = @"18709876543";
    model10.district = @"陕西 铜川";
    model10.isMale = YES;
    RSContactsModel *model11 = [RSContactsModel new];
    model11.contactImageName = @"SeaMonster";
    model11.contactName = @"SeaMonster";
    model11.indexStr = @"S";
    model11.idStr = @"sea4678383";
    model11.telNumStr = @"15678909876";
    model11.district = @"北京 大兴";
    model11.isMale = YES;
    RSContactsModel *model12 = [RSContactsModel new];
    model12.contactImageName = @"cartoon_8";
    model12.contactName = @"司马不平";
    model12.indexStr = @"S";
    model12.idStr = @"si5426746";
    model12.telNumStr = @"13589765434";
    model12.district = @"湖南 长沙";
    model12.isMale = NO;
    RSContactsModel *model13 = [RSContactsModel new];
    model13.contactImageName = @"cartoon_9";
    model13.contactName = @"忘忧草";
    model13.indexStr = @"W";
    model13.idStr = @"wang8654434";
    model13.telNumStr = @"13679890877";
    model13.district = @"陕西 西安";
    model13.isMale = NO;
    RSContactsModel *model14 = [RSContactsModel new];
    model14.contactImageName = @"cartoon_7";
    model14.contactName = @"云淡风轻";
    model14.indexStr = @"Y";
    model14.idStr = @"yun23456";
    model14.telNumStr = @"13289767896";
    model14.district = @"湖北 武汉";
    model14.isMale = NO;
    
    return @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model10, model11, model12, model13, model14];
}

@end
