//
//  RSAutoDisplayCell.m
//  RSChat
//
//  Created by hehai on 1/6/16.
//  Copyright © 2016 hehai. All rights reserved.
//

#import "RSAutoDisplayCell.h"

@interface RSAutoDisplayCell ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation RSAutoDisplayCell

- (void)awakeFromNib {
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(3*self.frame.size.width, 120);
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(0, self.frame.size.height-10, self.frame.size.width, 10);
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}

// testArray : @[@"emotion_0", @"emotion_1", @"emotion_2"]
- (void)setScrollWithArray:(NSArray *)imageArray {
    for (NSInteger num=0; num<3; num++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[num]]];
        CGRect frame = CGRectMake(self.frame.size.width*num, 0, self.frame.size.width, 120);
        imageView.frame = frame;
        [self.scrollView addSubview:imageView];
    }
}

+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight {
    return 120;
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
