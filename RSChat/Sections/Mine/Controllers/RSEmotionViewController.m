//
//  RSEmotionViewController.m
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//  GitHub: https://github.com/riversea2015
//  源码地址: https://github.com/riversea2015/RSChat
//

#import "RSEmotionViewController.h"
#import "RSAutoDisplayCell.h"
#import "RSEmotionACell.h"

#import "RSAlbumViewController.h" // 临时借用占位
#import "RSFavoritesViewController.h"
#import "RSMoneyCollectionViewController.h"

@interface RSEmotionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl *topSegmentControl;
@property (nonatomic, strong) NSArray *aArray;
@property (nonatomic, strong) NSArray *bArray;

@end

@implementation RSEmotionViewController

#pragma mark - Life Cycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.topSegmentControl;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleDone target:self action:@selector(setEmontions)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [RSAutoDisplayCell registToTableView:self.tableView];
    [RSEmotionACell registToTableView:self.tableView];
}

- (void)setEmontions {
    // navigationBar...
}

#pragma mark - tableView Delegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_topSegmentControl.selectedSegmentIndex == 0) {
        return 5;
    }
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RSAutoDisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:[RSAutoDisplayCell cellID] forIndexPath:indexPath];
        cell.flag = 0;

        // 监控哪一个ImageView被点击
        [cell addObserver:self forKeyPath:@"flag" options:NSKeyValueObservingOptionNew context:@"image"];
        
        if (_topSegmentControl.selectedSegmentIndex == 0) {
            [cell setScrollWithArray:@[@"emotion_0", @"emotion_1", @"emotion_2"]];
        } else {
            [cell setScrollWithArray:@[@"emotion_3", @"emotion_4", @"emotion_5"]];
        }
        
        return cell;
    }
    
    if (_topSegmentControl.selectedSegmentIndex == 0) {
        RSEmotionACell *cell = [tableView dequeueReusableCellWithIdentifier:[RSEmotionACell cellID] forIndexPath:indexPath];
        cell.titleImageView.image = [UIImage imageNamed:self.aArray[indexPath.row-1]];
        
        return cell;
    } else {
        RSEmotionACell *cell = [tableView dequeueReusableCellWithIdentifier:[RSEmotionACell cellID] forIndexPath:indexPath];
        cell.titleImageView.image = [UIImage imageNamed:self.bArray[indexPath.row-1]];
        
        return cell;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    self.hidesBottomBarWhenPushed = YES;
    
    NSNumber *number = [object valueForKeyPath:keyPath];
    NSInteger num = [number integerValue];
    NSLog(@"%ld", num);
    NSLog(@"%@", keyPath);
    
    if (num == 1) {
        RSAlbumViewController *album = [[RSAlbumViewController alloc] init];
        [self.navigationController pushViewController:album animated:YES];
        return;
    }
    
    if (num == 2) {
        RSFavoritesViewController *album = [[RSFavoritesViewController alloc] init];
        [self.navigationController pushViewController:album animated:YES];
        return;
    }
    
    if (num == 3) {
        RSMoneyCollectionViewController *album = [[RSMoneyCollectionViewController alloc] initWithNibName:@"RSMoneyCollectionViewController" bundle:nil];
        [self.navigationController pushViewController:album animated:YES];
        return;
    }
    
#warning TODO cell 重用，就会出现问题？--- 会连续推出多个相同的界面，重用几次，就推出几个。
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [RSAutoDisplayCell cellHeight];
    }
    return [RSEmotionACell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - segment Method

- (UISegmentedControl *)topSegmentControl {
    if (!_topSegmentControl) {
        _topSegmentControl = [[UISegmentedControl alloc] initWithItems:@[@"精选表情", @"投稿表情"]];
        _topSegmentControl.layer.borderWidth = 1;
        _topSegmentControl.layer.borderColor = [[UIColor whiteColor] CGColor];
        _topSegmentControl.layer.cornerRadius = 3;
        _topSegmentControl.layer.masksToBounds = YES;
        _topSegmentControl.frame = CGRectMake(62.5, 8, [UIScreen mainScreen].bounds.size.width - 125, 28);
        [_topSegmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
        
        [self.topSegmentControl addTarget:self action:@selector(valueChangedAction:) forControlEvents:UIControlEventValueChanged];
        [_topSegmentControl setSelectedSegmentIndex:0];
    }
    return _topSegmentControl;
}

- (void)valueChangedAction:(UISegmentedControl *)segmentControl {
    NSInteger index = segmentControl.selectedSegmentIndex;
    NSLog(@"selectedSegmentIndex：%ld", index);
    [self.tableView reloadData];
}

#pragma mark - setter getter

- (NSArray *)aArray {
    if (!_aArray) {
        _aArray = @[@"em_0", @"em_1", @"em_2", @"em_3", @"em_4"];
    }
    return _aArray;
}

- (NSArray *)bArray {
    if (!_bArray) {
        _bArray = @[@"emo_0", @"emo_1", @"emo_2", @"emo_3", @"emo_4", @"emo_5", @"emo_6"];
    }
    return _bArray;
}

@end
