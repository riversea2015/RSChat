//
//  RSAlbumViewController.m
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSAlbumViewController.h"

@interface RSAlbumViewController ()

@end

@implementation RSAlbumViewController

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(choose)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -

- (void)choose {
    // ...
}

#pragma mark - 



@end
