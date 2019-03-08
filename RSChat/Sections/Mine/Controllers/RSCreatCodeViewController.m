//
//  RSCreatCodeViewController.m
//  RSChat
//
//  Created by hehai on 12/31/15.
//  Copyright © 2015 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSCreatCodeViewController.h"
#import <CoreImage/CoreImage.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface RSCreatCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;

@end

@implementation RSCreatCodeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    
    [_logoImgView sd_setImageWithURL:[NSURL URLWithString:@"https://avatars1.githubusercontent.com/u/13641317?s=460&v=4"] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
    [self showCode];
}

#pragma mark -

- (void)showCode {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    
    NSString *originStr = @"https://github.com/riversea2015";
    NSData *data = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outPutImage = [filter outputImage];
    self.codeImageView.image = [UIImage imageWithCIImage:outPutImage];
}

@end
