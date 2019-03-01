//
//  RSScanViewController.m
//  RSChat
//
//  Created by hehai on 11/29/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSScanViewController.h"
#import "ZBarSDK.h"
#import "RSScanResultViewController.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] applicationFrame].size.width    //屏幕宽
#define SCREEN_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height   //屏幕高，去除状态栏
#define NAVIGATIONBAR_HEIGHT 44 //导航条高

@interface RSScanViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,
ZBarReaderViewDelegate>
@property (nonatomic, strong) ZBarReaderView *reader;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, assign) BOOL upOrDown;
@property (nonatomic, assign) int num;

@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation RSScanViewController

#pragma mark - Life Cycle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码/条码";
    
    _num = 0;
    _upOrDown = NO;
    _reader = [[ZBarReaderView alloc]init];
    _reader.frame = CGRectMake(0, 64, SCREEN_WIDTH, self.view.frame.size.height - 64);
    _reader.readerDelegate = self;
    _reader.tracksSymbols = NO;
    //关闭闪光灯
    _reader.torchMode = 0;
    [self.view addSubview:_reader];
    _reader.scanCrop = CGRectMake(0.1, 0.2, 0.5, 0.6);//扫描的感应框
    [_reader start];
    
    ZBarImageScanner *scanner = _reader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _reader.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    [_reader addSubview: view];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height - 64)];
    if(self.view.frame.size.height > 500)
    {
        image.image = [UIImage imageNamed:@"pick_bg"];
    }
    else
    {
        image.image = [UIImage imageNamed:@"pick_bg4"];
    }
    
    [view addSubview:image];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(45, 60, 230, 2)];
    _line.image = [UIImage imageNamed:@"linetemp"];
    [image addSubview:_line];
    
    //定时器，设定时间过1.5秒，
    _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(_reader)
    {
        [_reader start];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if(_reader)
    {
        [_reader stop];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animation1 {
    if (_upOrDown == NO) {
        _num++;
        _line.frame = CGRectMake(45, 60 + 2 * _num, SCREEN_WIDTH - 90, 2);
        if (2 * _num == 220) {
            _upOrDown = YES;
        }
    }
    else {
        _num--;
        _line.frame = CGRectMake(45, 60 + 2 * _num, SCREEN_WIDTH - 90, 2);
        if (_num == 0) {
            _upOrDown = NO;
        }
    }
}

#pragma mark - ZBarReaderViewDelegate
// 对扫到的数据进行处理
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image {
    self.hidesBottomBarWhenPushed = YES;
    for (ZBarSymbol *symbol in symbols) {
        NSLog(@"%@", symbol.data);
        
        RSScanResultViewController *resultVC = [[RSScanResultViewController alloc] initWithNibName:@"RSScanResultViewController" bundle:[NSBundle mainBundle]];
        resultVC.openStr = symbol.data;
        [self.navigationController pushViewController:resultVC animated:NO];
    }
    
    [self.reader stop];
}


@end
