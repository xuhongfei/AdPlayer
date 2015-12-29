//
//  HFPicScrollView.m
//  BubbleGum
//
//  Created by xuhongfei on 15/11/12.
//  Copyright © 2015年 shansander. All rights reserved.
//

#import "HFPicScrollView.h"

@interface HFPicScrollView ()<HFPicScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HFPicScrollView


- (instancetype)init
{
    if (self = [super init]) {
        [self setupSubViews];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.delegate = self;

    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:self.bounds];
    pageControl.frame = CGRectMake(self.bounds.origin.x, self.bounds.size.height / 2 - 10, self.bounds.size.width, self.bounds.size.height);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    pageControl.userInteractionEnabled = NO;
    
    [self addTimer];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.scrollView addGestureRecognizer:tapGesture];
}

- (void)tap
{
    if (self.deleagte != nil && [self.deleagte respondsToSelector:@selector(picScrollView:didClickedPicIndex:)]) {
        [self.deleagte picScrollView:self didClickedPicIndex:self.pageControl.currentPage];
    }
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage
{
    unsigned long page = 0;
    page = self.pageControl.currentPage + 1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [UIScrollView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = offset;
    }];
    
    self.pageControl.currentPage = page;
}

- (void)settingScrollPics:(NSArray *)pics
{
    unsigned long imageCount = pics.count;
    
    CGFloat x = self.scrollView.bounds.origin.x;
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    for (int i = 0; i < imageCount; i ++) {
        x = i * w;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, w, h)];
        imageView.image = pics[i];
        
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(w * imageCount, 0);

    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = imageCount;
}

#pragma mark - delegate function
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    CGFloat viewW = self.scrollView.frame.size.width;
    self.pageControl.currentPage = (offsetX + viewW * 0.5) / viewW;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self terminateTimer];
}

- (void)terminateTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
