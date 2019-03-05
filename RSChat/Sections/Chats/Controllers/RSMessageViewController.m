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
#import "RSMessageCell.h"
#import "RSMessageModel.h"

@interface RSMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutConstraint;

@property (nonatomic, strong) RSMessageCell *prototypeCell;

@property (nonatomic, strong) NSMutableArray *allMessages;

@end

@implementation RSMessageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // tabelView内容不会延伸至navigationBar和tabBar之下,默认为 UIRectEdgeAll 是延伸的
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    // automaticallyAdjustsScrollViewInsets 为YES 时，tableView 上下滑动时，是可以穿过导航栏&状态栏的，在他们下面有淡淡的浅浅红色,实际测试：YES和NO都有浅红色。
    
    self.title = self.homeModel.leftText;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_InfoSingle"] style:UIBarButtonItemStyleDone target:self action:@selector(showUserInfo)];
    self.navigationItem.rightBarButtonItem = rightItem;
        
    [self.tableView registerClass:[RSMessageCell class] forCellReuseIdentifier:[RSMessageCell cellID]];
    
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:[RSMessageCell cellID]];
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
        self.navigationItem.leftBarButtonItem = leftItem; // leftItem;
    }
    
}

- (void)goBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// regist notification
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    [self scrollToTableViewBottom];
}

// remove notification
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - private method

- (void)showUserInfo {
    NSLog(@"聊天详情。。。");
}

- (void)openKeyboard:(NSNotification *)notification {
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.bottomLayoutConstraint.constant = keyboardFrame.size.height;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
        [self scrollToTableViewBottom];
    } completion:nil];
}

- (void)closeKeyboard:(NSNotification *)notification {
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.bottomLayoutConstraint.constant = 0;
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
        [self scrollToTableViewBottom];
    } completion:nil];
}

// Send chat messages
- (IBAction)sendMessage:(UITextField *)sender {
    NSString *newContent = sender.text;
    if (newContent.length < 1) {
        return;
    }
    RSMessageModel *newMessage = [[RSMessageModel alloc] init];
    newMessage.content = newContent;
    newMessage.fromMe = YES;

    [self.allMessages addObject:newMessage];
    sender.text = @"";

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

// Scroll to the bottom row
- (void)scrollToTableViewBottom {
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.allMessages.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
//    [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentSize.height - 1, self.tableView.bounds.size.width, 1) animated:NO];
}

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    
    return cell;
}

// Calculate the height of rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSMessageModel *message = self.allMessages[indexPath.row];
    self.prototypeCell.message = message;
    
    NSLog(@"%f", self.prototypeCell.bounds.size.height);
    return self.prototypeCell.bounds.size.height;
}

#pragma mark - setter getter

- (NSMutableArray *)allMessages {
    if (!_allMessages) {
        _allMessages = [[RSMessageModel demoData] mutableCopy];
    }
    return _allMessages;
}

@end
