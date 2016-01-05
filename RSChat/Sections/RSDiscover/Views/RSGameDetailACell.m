//
//  RSGameDetailACell.m
//  RSChat
//
//  Created by hehai on 1/4/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSGameDetailACell.h"

@interface RSGameDetailACell ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *demoArr;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation RSGameDetailACell

- (void)awakeFromNib {
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(5*160 + 6*10, 284);
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, self.frame.size.height-120-10, self.frame.size.width, 10);
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}

- (void)setScrollWithArray:(NSArray *)imageArray {
    for (NSInteger num=0; num<5; num++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[num]]];
        CGRect frame = CGRectMake(160*num + 10*(num+1), 0, 160, 284);
        imageView.frame = frame;
        [self.scrollView addSubview:imageView];
    }
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 413;
}

+ (void)registToTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([self class])];
}

#pragma mark - ScrollView delegate

// 注意：pageEnable情况下，他的一页，指的是scrollView的frame那么大的一个，而非一张图片的大小。

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    NSInteger index = round(point.x/scrollView.frame.size.width); // 这里只是控制点点，对于一次翻多大一页没影响。
    _pageControl.currentPage = index;
}

@end
