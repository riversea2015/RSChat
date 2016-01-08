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
@property (nonatomic, strong) NSTimer *timer;

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
    
    [self addTimer];
    
    // 为添加手势做准备
    self.scrollView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    //2.设置手势对象的属性
    tapGR.numberOfTouchesRequired = 1;
    tapGR.numberOfTapsRequired = 1;
    //3.关联视图
    [self.scrollView addGestureRecognizer:tapGR];
    
    self.flag = 0; // 哪一个ImageView被点了
    self.cellFlag = 0; // 哪一个cell
}

- (void)tap:(UITapGestureRecognizer *)gr{
    
    // 获取手势的触点在self.scrollView的坐标系下的点位置
    CGPoint location = [gr locationInView:self.scrollView];
    // 使用NSStringFromCGPoint函数可以将一个结构体变成字符串
    NSLog(@"🈴%@",NSStringFromCGPoint(location));
    
    if (location.x <= self.scrollView.frame.size.width) {
        NSLog(@"第一个");
        self.flag = 1;
        return;
    }
    if (location.x <= 2 * self.scrollView.frame.size.width) {
        NSLog(@"第二个");
        self.flag = 2;
        return;
    }
    if (location.x <= 3 * self.scrollView.frame.size.width) {
        NSLog(@"第三个");
        self.flag = 3;
        return;
    }
    
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    [self.timer invalidate];
}

- (void)nextImage {
    int page = (int)self.pageControl.currentPage;
    if (page == 2) {
        page = 0;
    } else {
        page++;
    }
    
    CGFloat x = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
}

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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self removeTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self addTimer];
}

@end
