//
//  WEEXDemoVC.m
//  RSChat
//
//  Created by hehai on 2019/3/11.
//  Copyright © 2019 hehai. All rights reserved.
//

#import "WEEXDemoVC.h"
#import <WeexSDK/WeexSDK.h>

@interface WEEXDemoVC ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) NSURL *url;

@end

@implementation WEEXDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupWeexInstance];
}

- (void)dealloc {
    [self.instance destroyInstance];
}

#pragma mark - Weex

- (void)setupWeexInstance {
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame;
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:view];
    };
    _instance.onFailed = ^(NSError *error) {
        NSLog(@"failure: %@",error);
    };
    _instance.renderFinish = ^ (UIView *view) {
        NSLog(@"success");
    };

    [_instance renderWithURL:self.url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
}

- (NSURL *)url {
    if (!_url) {
        _url =  [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"js"];
    }
    return _url;
}

@end
