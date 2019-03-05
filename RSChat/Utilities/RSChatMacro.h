//
//  RSChatMacro.h
//  HHChat
//
//  Created by hehai on 2018/9/7.
//  Copyright © 2018 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#ifndef RSChatMacro_h
#define RSChatMacro_h


#pragma mark - TabbarItem Title

#define ChatsTitle      NSLocalizedString(@"Chats", @"The title of the first tabbarItem.")
#define ContactsTitle   NSLocalizedString(@"Contacts", @"The title of the second tabbarItem.")
#define DiscoverTitle   NSLocalizedString(@"Discover", @"The title of the third tabbarItem.")
#define MineTitle       NSLocalizedString(@"Mine", @"The title of the fourth tabbarItem.")


#pragma mark - Screen Width & Height

#define RSScreenW [UIScreen mainScreen].bounds.size.width
#define RSScreenH [UIScreen mainScreen].bounds.size.height

#define kIsIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define RSNavBarH ((kIsIPhoneX) ? 88 : 64)

#define RSBottomH ((kIsIPhoneX) ? 34 : 0)

#define RSStatusBarH [[UIApplication sharedApplication] statusBarFrame].size.height

#endif /* RSChatMacro_h */
