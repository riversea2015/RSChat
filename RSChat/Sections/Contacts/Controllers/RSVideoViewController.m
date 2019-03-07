//
//  RSVideoViewController.m
//  RSChat
//
//  Created by hehai on 11/29/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSVideoViewController.h"

@interface RSVideoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;

@end

@implementation RSVideoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }

    [self presentViewController:imagePicker animated:YES completion:^{
    }];
}

#pragma mark - UIImagePickerControllerDelegate
// 图片捕捉(方法过期)
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
//
//}

// 视频捕捉
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",info);
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.cameraImageView.image=image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
