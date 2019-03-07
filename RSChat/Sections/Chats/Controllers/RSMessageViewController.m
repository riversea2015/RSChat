//
//  RSMessageViewController.m
//  RSChat
//
//  Created by hehai on 11/24/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSMessageViewController.h"
#import "RSDetailViewController.h"

#import "RSMessageCell.h"
#import "RSMessageModel.h"
#import "RSChatToolBar.h"
#import <Masonry/Masonry.h>
#import "RSChatMacro.h"

@interface RSMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) RSMessageCell *prototypeCell;
@property (nonatomic, strong) NSMutableArray *allMessages;
@property (nonatomic, strong) RSChatToolBar *toolBar;

@end

@implementation RSMessageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupNavView];
    [self setupMainViews];
    [self registerNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View

- (void)setupNavView {
    
    self.title = self.homeModel.leftText;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_InfoSingle"]
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(showUserInfo)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(goBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (void)goBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupMainViews {
    
    _toolBar = [RSChatToolBar creatWithframe:CGRectZero];
    [self.view addSubview:_toolBar];
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(45+RSBottomH);
        make.bottom.equalTo(self.view);
    }];
    __weak typeof(self) weakSelf = self;
    _toolBar.sendBlock = ^(NSString * _Nonnull msg) {
        [weakSelf sendMessage:msg];
    };
    
    [RSMessageCell registerClassToTableView:self.tableView];
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:[RSMessageCell cellID]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.toolBar.mas_top);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.tableView addGestureRecognizer:tap];
}

- (void)tapAction {
    [self.view endEditing:YES];
}

- (void)registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark - private method

- (void)showUserInfo {
    NSLog(@"聊天详情。。。");
}

- (void)openKeyboard:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self.toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(45);
        make.bottom.equalTo(self.view).offset(-keyboardFrame.size.height);
    }];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
        [self scrollToTableViewBottom];
    } completion:nil];
}

- (void)closeKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [self.toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(45+RSBottomH);
        make.bottom.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
        [self scrollToTableViewBottom];
    } completion:nil];
}

- (void)sendMessage:(NSString *)text {
    NSString *newContent = text;
    if (text.length < 1) {
        return;
    }
    
    RSMessageModel *newMessage = [[RSMessageModel alloc] init];
    newMessage.content = newContent;
    newMessage.fromMe = YES;

    [self.allMessages addObject:newMessage];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self scrollToTableViewBottom];
}

- (void)scrollToTableViewBottom {
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.allMessages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView setContentOffset:CGPointMake(0, tableView.contentSize.height-tableView.frame.size.height) animated:NO];
    return self.allMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSMessageCell cellID] forIndexPath:indexPath];
    
    RSMessageModel *message = self.allMessages[indexPath.row];
    cell.message = message;
    
    if (cell.message.fromMe) {
        cell.titleImageView.image = [UIImage imageNamed:@"hehai"];
    } else {
        UIImage *image = [UIImage imageNamed:self.homeModel.leftImageName];
        cell.titleImageView.image = image;
    }
    
    __weak typeof(self) weakSelf = self;
    cell.clickLogoBlock = ^{
        
        RSContactsModel *tempContact = [RSContactsModel new];
        tempContact.contactImageName = @"cartoon_2";
        tempContact.contactName = @"聊天->联系人信息";
        tempContact.indexStr = @"M";
        tempContact.idStr = @"xyz";
        tempContact.telNumStr = @"11111111111";
        tempContact.district = @"安徽 芜湖";
        tempContact.isMale = YES;
        
        RSDetailViewController *detailVC = [[RSDetailViewController alloc] init];
        detailVC.contactMdel = tempContact;
        detailVC.lastVCName = NSStringFromClass([weakSelf class]);
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSMessageModel *message = self.allMessages[indexPath.row];
    self.prototypeCell.message = message;
    
    return self.prototypeCell.bounds.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - setter getter

- (NSMutableArray *)allMessages {
    if (!_allMessages) {
        _allMessages = [[RSMessageModel demoData] mutableCopy];
    }
    return _allMessages;
}

@end
