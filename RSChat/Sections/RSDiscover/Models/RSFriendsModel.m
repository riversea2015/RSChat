//
//  RSFriendsModel.m
//  RSChat
//
//  Created by hehai on 12/8/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "RSFriendsModel.h"

@implementation RSFriendsModel

+ (NSArray *)demoData {
    RSFriendsModel *model1 = [[RSFriendsModel alloc] init];
    model1.contentText = @"完成工作的方法是爱惜每一分钟。－－达尔文";
    RSFriendsModel *model2 = [[RSFriendsModel alloc] init];
    model2.contentText = @"不要以感伤的眼光去看过去，因为过去再也不会回来了，最聪明的办法，就是好好对付你的现在--现在正握在你的手里，你要以堂堂正正的大丈夫气概去迎接如梦如幻的未来。---郎费罗";
    RSFriendsModel *model3 = [[RSFriendsModel alloc] init];
    model3.contentText = @"合理安排时间，就等于节约时间。－－培根";
    RSFriendsModel *model4 = [[RSFriendsModel alloc] init];
    model4.contentText = @"应当仔细地观察，为的是理解；应当努力地理解，为的是行动。－－罗曼罗兰";
    RSFriendsModel *model5 = [[RSFriendsModel alloc] init];
    model5.contentText = @"时而言，有初、中、后之分；日而言，有今、昨、明之称；身而言，有幼、壮、艾之期。--唐·刘禹锡";
    RSFriendsModel *model6 = [[RSFriendsModel alloc] init];
    model6.contentText = @"人误地一时，地误人一年。";
    RSFriendsModel *model7 = [[RSFriendsModel alloc] init];
    model7.contentText = @"皇皇三十载，书剑两无成。";
    RSFriendsModel *model8 = [[RSFriendsModel alloc] init];
    model8.contentText = @"每一点滴的进展都是缓慢而艰巨的，一个人一次只能着手解决一项有限的目标。－－贝弗里奇";
    RSFriendsModel *model9 = [[RSFriendsModel alloc] init];
    model9.contentText = @"爱情是灯，友情是影子，当灯灭了，你会发现你的周围都是影子。朋友，是在黑暗时候给你力量的人。";
    RSFriendsModel *model10 = [[RSFriendsModel alloc] init];
    model10.contentText = @"这个世上没有人能保护你，坚强，是你唯一的出路。";
    
    return @[model1, model2, model3, model4, model5, model6, model7, model8, model9, model10];
}

@end
