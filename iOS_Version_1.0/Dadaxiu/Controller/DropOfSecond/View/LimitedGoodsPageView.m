//
//  LimitedGoodsPageView.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "LimitedGoodsPageView.h"

@interface LimitedGoodsPageView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *childVC;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation LimitedGoodsPageView

- (instancetype)initWithFrame:(CGRect)frame childVC:(NSArray *)childVC {
    if (self = [super initWithFrame:frame]) {
        self.childVC = childVC;
        self.contentView.contentSize = CGSizeMake(childVC.count * frame.size.width, 0);
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)index {
    UIViewController *VC = self.childVC[index];
    if (!VC.view.superview) {
        VC.view.frame = (CGRect){index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height};
        [self.contentView addSubview:VC.view];
    }
    [self.contentView setContentOffset:CGPointMake(index * self.frame.size.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 0.当前偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 1.当前页码
    NSInteger i = offsetX / self.frame.size.width;
    
    [self setCurrentIndex:i];
    
    !self.didEndScrollView ? : self.didEndScrollView(i);
}

#pragma mark - lazy
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.pagingEnabled = YES;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}

@end
