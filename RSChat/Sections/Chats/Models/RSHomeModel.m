//
//  RSHomeModel.m
//  RSChat
//
//  Created by hehai on 11/11/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSHomeModel.h"

@implementation RSHomeModel

+ (NSArray *)demoData {
    RSHomeModel *model1 = [RSHomeModel new];
    model1.leftImageName = @"Plugins_News_avatar";
    model1.leftText = @"腾讯新闻";
    model1.rightText = @"12:12";
    model1.bottomText = @"新版百元钞票印制流程曝光";
    model1.badgeNumberText = @"5";
    RSHomeModel *model2 = [RSHomeModel new];
    model2.leftImageName = @"public_weex";
    model2.leftText = @"WEEX测试";
    model2.rightText = @"13:24";
    model2.bottomText = @"内存泄露从入门到精通三部曲之基础知识篇";
    model2.badgeNumberText = @"12  ";
//    RSHomeModel *model3 = [RSHomeModel new];
//    model3.leftImageName = @"ReadVerified_icon";
//    model3.leftText = @"订阅号";
//    model3.rightText = @"16:35";
//    model3.bottomText = @"CocoaChina:不要自称是程序员，我十多年的IT职场总结";
//    model3.badgeNumberText = @"6";
    RSHomeModel *model4 = [RSHomeModel new];
    model4.leftImageName = @"cartoon_1";
    model4.leftText = @"Jone";
    model4.rightText = @"10月1日";
    model4.bottomText = @"人生无非是笑笑人家，然后再被人家笑笑而已。";
    RSHomeModel *model5 = [RSHomeModel new];
    model5.leftImageName = @"cartoon_2";
    model5.leftText = @"Monkey";
    model5.rightText = @"10月15日";
    model5.bottomText = @"既然选择了远方，便只顾风雨兼程！";
    model5.badgeNumberText = @"2";
    RSHomeModel *model6 = [RSHomeModel new];
    model6.leftImageName = @"cartoon_3";
    model6.leftText = @"千山暮雪";
    model6.rightText = @"10月16日";
    model6.bottomText = @"一个人有无成就，决定于他青年时期是不是有志气。";
    model6.badgeNumberText = @"7";
    RSHomeModel *model7 = [RSHomeModel new];
    model7.leftImageName = @"cartoon_4";
    model7.leftText = @"过客";
    model7.rightText = @"10月19日";
    model7.bottomText = @"青年总是年青的，只有老年才会变老。";
    RSHomeModel *model8 = [RSHomeModel new];
    model8.leftImageName = @"cartoon_5";
    model8.leftText = @"飞翔的兔子";
    model8.rightText = @"11月2日";
    model8.bottomText = @"给青年人最好的忠告是让他们谦逊谨慎，孝敬父母，爱戴亲友。";
    RSHomeModel *model9 = [RSHomeModel new];
    model9.leftImageName = @"cartoon_6";
    model9.leftText = @"Amber";
    model9.rightText = @"1:01";
    model9.bottomText = @"成功的人是跟别人学习经验，失败的人只跟自己学习经验。";
    RSHomeModel *model10 = [RSHomeModel new];
    model10.leftImageName = @"cartoon_7";
    model10.leftText = @"云淡风轻";
    model10.rightText = @"8:32";
    model10.bottomText = @"世界上一成不变的东西，只有“任何事物都是在不断变化的”这条真理。";
    RSHomeModel *model11 = [RSHomeModel new];
    model11.leftImageName = @"cartoon_8";
    model11.leftText = @"司马不平";
    model11.rightText = @"12:01";
    model11.bottomText = @"一个不注意小事情的人，永远不会成功大事业";
    RSHomeModel *model12 = [RSHomeModel new];
    model12.leftImageName = @"cartoon_9";
    model12.leftText = @"忘忧草";
    model12.rightText = @"23:10";
    model12.bottomText = @"能使所爱的人快乐，便是得了报酬。";

    
    return @[model1, model2, model4, model5, model6, model7, model8, model9, model10, model11, model12];
    // model3,
}

@end
