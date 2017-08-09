//
//  LimitedGoodsTimePageView.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "LimitedGoodsTimePageView.h"

#define btn_font 14*kScreen_Width/375

@interface LimitedGoodsTimePageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleScrollView;

@property (nonatomic, strong) NSArray *titles;
/** 所有按钮的数组 */
@property (nonatomic ,strong) NSMutableArray<UIButton *> *titleBtns;
// 记录上一个选中按钮
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, assign) CGFloat btnWidth;

@end

@implementation LimitedGoodsTimePageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = [UIColor colorWithHex:0x8b8b8b];
        [self addSubview:self.titleScrollView];
        [self setupInit];
    }
    return self;
}

- (void)setCurrentTitleIndex:(NSInteger)index {
    [self selectTitleButton:self.titleBtns[index]];
//    [self.titleScrollView setContentOffset:CGPointMake(_btnWidth*index, 0) animated:YES];
    CGRect rect = [_selectButton.superview convertRect:_selectButton.frame toView:self];
    
    [UIView animateWithDuration:0 animations:^{
        CGPoint contentOffset = self.titleScrollView.contentOffset;
        if (contentOffset.x - (kScreen_Width/2-rect.origin.x - _btnWidth/2)<=0) {
            [self.titleScrollView setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
            
        } else if (contentOffset.x - (kScreen_Width/2-rect.origin.x - _btnWidth/2) + kScreen_Width >= self.titleBtns.count*_btnWidth) {
            [self.titleScrollView setContentOffset:CGPointMake(self.titleBtns.count*_btnWidth-kScreen_Width, contentOffset.y) animated:YES];
            
        } else {
            [self.titleScrollView setContentOffset:CGPointMake(contentOffset.x - (kScreen_Width/2 - rect.origin.x-_btnWidth/2), contentOffset.y) animated:YES];
        }
    }];
}

- (void)titleClick:(UIButton *)button {
    // 0.获取角标
    NSInteger i = button.tag;
    
    !self.didTitleClick ? : self.didTitleClick(i);
    // 1.让标题按钮选中
    [self selectTitleButton:button];
}

- (void)selectTitleButton:(UIButton *)btn {
    // 恢复上一个按钮颜色
    _selectButton.backgroundColor = [UIColor colorWithHex:0x8b8b8b];
    // 设置当前选中按钮的颜色
    btn.backgroundColor = ThemeColor;
    
    // 记录当前选中的按钮
    _selectButton = btn;
    
    CGRect rect = [_selectButton.superview convertRect:_selectButton.frame toView:self];
    
    [UIView animateWithDuration:0 animations:^{

        CGPoint contentOffset = self.titleScrollView.contentOffset;
        if (contentOffset.x - (kScreen_Width/2-rect.origin.x - _btnWidth/2)<=0) {
            [self.titleScrollView setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];

        } else if (contentOffset.x - (kScreen_Width/2-rect.origin.x - _btnWidth/2) + kScreen_Width >= self.titleBtns.count*_btnWidth) {
            [self.titleScrollView setContentOffset:CGPointMake(self.titleBtns.count*_btnWidth-kScreen_Width, contentOffset.y) animated:YES];

        } else {
            [self.titleScrollView setContentOffset:CGPointMake(contentOffset.x - (kScreen_Width/2 - rect.origin.x-_btnWidth/2), contentOffset.y) animated:YES];
        }
    }];
}


- (void)setupInit
{
    CGFloat btnH = self.frame.size.height;
    
    if (self.titles.count < 5) {
        _btnWidth = self.frame.size.width / self.titles.count;
        _titleScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } else {
        _btnWidth = self.frame.size.width / 5;
        _titleScrollView.contentSize = CGSizeMake(_btnWidth*self.titles.count, CGRectGetHeight(self.frame));
    }
   
    
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        CustomHTitleButton *btn = [[CustomHTitleButton alloc] initWithFrame:(CGRect) {_btnWidth * idx, 0, _btnWidth, btnH} withTopTitle:[title componentsSeparatedByString:@" "][0]  withBottomTitle:[title componentsSeparatedByString:@" "][1] withFont:[UIFont systemFontOfSize:btn_font]];
        btn.tag = idx;
//        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        
        if (!idx) {
            [self titleClick:btn];
        }
        [self.titleScrollView addSubview:btn];
        [self.titleBtns addObject:btn];
    }];
}

#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)titleBtns {
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (UIScrollView *)titleScrollView
{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.pagingEnabled = YES;
        _titleScrollView.delegate = self;
    }
    return _titleScrollView;
}


@end


@implementation CustomHTitleButton

- (instancetype)initWithFrame:(CGRect)frame withTopTitle:(NSString *)topTitle withBottomTitle:(NSString *)bottomTitle withFont:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutWithTopTitle:topTitle bottomTitle:bottomTitle withFont:font];
    }
    return self;
}

- (void)layoutWithTopTitle:(NSString *)topTitle bottomTitle:(NSString *)bottomTitle withFont:(UIFont *)font
{
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)];
    [self addSubview:topLabel];
    topLabel.text = topTitle;
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = font;
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)];
    [self addSubview:bottomLabel];
    bottomLabel.text = bottomTitle;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.font = font;
}

@end

