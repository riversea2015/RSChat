//
//  RSHomeModel.m
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSHomeModel.h"

@implementation RSHomeModel

- (NSArray *)homeArr {
    if (!_homeArr) {
        RSHomeModel *model = [RSHomeModel new];
        model.leftImageName = @"Plugins_News_avatar";
        model.leftText = @"腾讯新闻";
        model.rightText = @"12:12";
        model.bottomText = @"新版百元钞票印制流程曝光";
        model.badgeNumberText = @"5";
//        model.badgeNumberImageName = @"tabbar_badge";
        RSHomeModel *model0 = [RSHomeModel new];
        model0.leftImageName = @"bugly";
        model0.leftText = @"腾讯Bugly";
        model0.rightText = @"13:24";
        model0.bottomText = @"内存泄露从入门到精通三部曲之基础知识篇";
        model0.badgeNumberText = @"12  ";
//        model0.badgeNumberImageName = @"tabbar_badge";
        RSHomeModel *model1 = [RSHomeModel new];
        model1.leftImageName = @"cartoon_1";
        model1.leftText = @"Jone";
        model1.rightText = @"10月1日";
        model1.bottomText = @"人生无非是笑笑人家，然后再被人家笑笑而已。";
//        model1.badgeNumberImageName = nil;
        RSHomeModel *model2 = [RSHomeModel new];
        model2.leftImageName = @"cartoon_2";
        model2.leftText = @"Monkey";
        model2.rightText = @"10月15日";
        model2.bottomText = @"既然选择了远方，便只顾风雨兼程！";
        model2.badgeNumberText = @"2";
//        model2.badgeNumberImageName = nil;
        RSHomeModel *model3 = [RSHomeModel new];
        model3.leftImageName = @"cartoon_3";
        model3.leftText = @"千山暮雪";
        model3.rightText = @"10月16日";
        model3.bottomText = @"一个人有无成就，决定于他青年时期是不是有志气。";
        model3.badgeNumberText = @"7";
//        model3.badgeNumberImageName = @"tabbar_badge";
        RSHomeModel *model4 = [RSHomeModel new];
        model4.leftImageName = @"cartoon_4";
        model4.leftText = @"过客";
        model4.rightText = @"10月19日";
        model4.bottomText = @"青年总是年青的，只有老年才会变老。";
//        model4.badgeNumberImageName = nil;
        RSHomeModel *model5 = [RSHomeModel new];
        model5.leftImageName = @"cartoon_5";
        model5.leftText = @"飞翔的兔子";
        model5.rightText = @"11月2日";
        model5.bottomText = @"给青年人最好的忠告是让他们谦逊谨慎，孝敬父母，爱戴亲友。";
//        model5.badgeNumberImageName = nil;
        RSHomeModel *model6 = [RSHomeModel new];
        model6.leftImageName = @"cartoon_6";
        model6.leftText = @"Amber";
        model6.rightText = @"1:01";
        model6.bottomText = @"成功的人是跟别人学习经验，失败的人只跟自己学习经验。";
//        model6.badgeNumberImageName = nil;
        RSHomeModel *model7 = [RSHomeModel new];
        model7.leftImageName = @"cartoon_7";
        model7.leftText = @"云淡风轻";
        model7.rightText = @"8:32";
        model7.bottomText = @"世界上一成不变的东西，只有“任何事物都是在不断变化的”这条真理。";
//        model7.badgeNumberImageName = nil;
        RSHomeModel *model8 = [RSHomeModel new];
        model8.leftImageName = @"cartoon_8";
        model8.leftText = @"司马不平";
        model8.rightText = @"12:01";
        model8.bottomText = @"一个不注意小事情的人，永远不会成功大事业";
//        model8.badgeNumberImageName = nil;
        RSHomeModel *model9 = [RSHomeModel new];
        model9.leftImageName = @"cartoon_9";
        model9.leftText = @"忘忧草";
        model9.rightText = @"23:10";
        model9.bottomText = @"能使所爱的人快乐，便是得了报酬。";
        
//        model9.badgeNumberImageName = @"tabbar_badge";
        RSHomeModel *model10 = [RSHomeModel new];
        model10.leftImageName = @"ReadVerified_icon";
        model10.leftText = @"订阅号";
        model10.rightText = @"16:35";
        model10.bottomText = @"CocoaChina:不要自称是程序员，我十多年的IT职场总结";
        model10.badgeNumberText = @"6";
//        model10.badgeNumberImageName = @"tabbar_badge";
        
        _homeArr = @[model, model0, model10, model1, model2, model3, model4, model5, model6, model7, model8, model9];
    }
    return _homeArr;
}

@end
