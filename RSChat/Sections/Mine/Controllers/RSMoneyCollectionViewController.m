//
//  RSMoneyCollectionViewController.m
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSMoneyCollectionViewController.h"
#import "RSMoneyACell.h"
#import "RSQuestionViewController.h"
#import "RSMoneyCollectionView.h"

@interface RSMoneyCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation RSMoneyCollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"钱包";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleDone target:self action:@selector(help)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [RSMoneyACell registerNibToCollectionView:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"RSMoneyCollectionView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RSMoneyCollectionView"];
    // Do any additional setup after loading the view.
}

- (void)help {
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 10;
        default:
            return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RSMoneyACell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RSMoneyACell cellID] forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    RSQuestionViewController *questionVC = [[RSQuestionViewController alloc] initWithNibName:@"RSQuestionViewController" bundle:[NSBundle mainBundle]];
    
    if (indexPath.section == 0) {
        questionVC.url = [NSURL URLWithString:@"http://m.meilishuo.com/"];
        questionVC.titleText = @"美丽说";
    }
    if (indexPath.section == 1) {
        questionVC.url = [NSURL URLWithString:@"http://wq.jd.com/mcoss/mportal/show?tabid=6&tpl=7&PTAG=17012.4.2&ptype=4"];
        questionVC.titleText = @"京东";
    }
    if (indexPath.section == 2) {
        questionVC.url = [NSURL URLWithString:@"http://m.dianping.com/"];
        questionVC.titleText = @"大众点评";
    }
    
    [self presentViewController:questionVC animated:YES completion:nil];
}

/*
 下边2个方法，依次用来：
 1.返回 Header 的 大小 size
 2.获取 Header 的 视图 View
 */

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(self.view.frame.size.width, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RSMoneyCollectionView *view = (RSMoneyCollectionView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RSMoneyCollectionView" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            view.nameLabel.text = nil;
            break;
        case 1:
            view.nameLabel.text = @"腾讯服务";
            break;
        default:
            view.nameLabel.text = @"第三方服务";
            break;
    }
    
    return view;
}

#pragma mark <UICollectionViewDelegate>


@end
