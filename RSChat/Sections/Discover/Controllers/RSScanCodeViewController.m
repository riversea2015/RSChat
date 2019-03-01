//
//  RSScanCodeViewController.m
//  RSChat
//
//  Created by hehai on 12/31/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface RSScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation RSScanCodeViewController

#pragma mark - LifeCycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 实例化拍摄设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 设置设备输入
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3. 设置元数据输出（扫描到的数据）
    // 3.1 实例化拍摄到的元数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 3.2 设置扫描的区域（矩形区域的位置、大小）
    [output setRectOfInterest:CGRectMake((124)/[UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.width - 220)/2)/[UIScreen mainScreen].bounds.size.width, 220/[UIScreen mainScreen].bounds.size.height, 220/[UIScreen mainScreen].bounds.size.width)];
    // 3.3 设置输出数据代理（由谁来监测扫描到的元数据，在哪个线程中处理）
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4. 添加拍摄会话（相当于session的一头是输入，一头是输出）
    // 4.1 实例化拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 4.2 添加会话输入
    [session addInput:input];
    // 4.3 添加会话输出
    [session addOutput:output];
    // 4.3 设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // 扫描到的元数据类型，只有扫描到的数据类型和这个相符，才会去调用后边的代理方法处理数据。
    
    self.session = session;
    
    // 5. 视频预览图层
    // 5.1 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preview.frame = self.view.bounds;
    // 5.2 将图层插入当前视图
    [self.view.layer insertSublayer:preview atIndex:100];
    
    self.previewLayer = preview;
    
    // 6. 启动会话
    [_session startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

// 当扫描到数据，而且和前边规定的类型相符时，调用此代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    // 会频繁的扫描，频繁的调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    NSLog(@"%@", metadataObjects);
    // 3. 设置界面显示扫描结果
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
        //        _label.text = obj.stringValue;
        NSLog(@"%@", obj.stringValue);
    }
}


@end
