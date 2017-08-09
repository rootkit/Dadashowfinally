//
//  TitleViewController.m
//  OCScrollTitleAndView
//
//  Created by 李萍 on 16/2/25.
//  Copyright © 2016年 李萍. All rights reserved.
//

#import "TitleViewController.h"
//#import "SubViewController.h"

@interface TitleViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *titleButtonScrollView; //整体滚动视图
@property (nonatomic, strong) UIScrollView *footScrollView; //底部横栏滚动视图
@property (nonatomic, strong) UIScrollView *subViewScrollView; //底部视图框

@property (nonatomic, assign) CGRect viewFrame;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, assign) BOOL isFixedLength;
@property (nonatomic, assign) BOOL isHasNavig;
@property (nonatomic, assign) BOOL isHasTabbar;

@property (nonatomic, assign) CGFloat sizeWidth;
@property (nonatomic, assign) CGFloat sizeHeight;
@property (nonatomic, assign) CGFloat sizeY;

@property (nonatomic, assign) NSInteger titlesCount;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *foots;

@end

@implementation TitleViewController
- (instancetype)initWithFrame:(CGRect)viewFrame
                       titles:(NSArray*)titles viewControllers:(NSArray*)viewControllers andIsFixedTitleLength:(BOOL)isFixed andHasNavig:(BOOL)isHasNav andHasTabbar:(BOOL)isHasTabbar
{
    self = [super init];
    if (self) {
        _viewFrame = viewFrame;
        _titles = titles;
        _controllers = viewControllers;
        _isFixedLength = isFixed;
        _isHasNavig = isHasNav;
        _isHasTabbar = isHasTabbar;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _buttons = [NSMutableArray new];
    _foots = [NSMutableArray new];
    _sizeWidth = CGRectGetWidth(_viewFrame);

    if (_isHasNavig) {
        if (_isHasTabbar) {
            _sizeHeight = CGRectGetHeight(_viewFrame) - 20 - 44 - 40;
        } else {
            _sizeHeight = CGRectGetHeight(_viewFrame) - 20 - 44;
        }
        _sizeY = 64;
    } else {
        if (_isHasTabbar) {
            _sizeHeight = CGRectGetHeight(_viewFrame) - 20 - 40;
        } else {
            _sizeHeight = CGRectGetHeight(_viewFrame) - 20;
        }
        _sizeY = 20;
    }
    

    _titlesCount = _titles.count;
    
    if (_isFixedLength) {
        //固定标题长度
        if (!_titleButtonWidth) { _titleButtonWidth = 80;}
    } else {
        //均分屏幕宽度(标题不多时)
        _titleButtonWidth = _sizeWidth/_titlesCount;
    }

    [self initForScrollView];
    [self setContentForTitleScrollView];
    [self setContentForSubviewScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - 初始化滚动视图
- (void)initForScrollView
{
    self.view.userInteractionEnabled  =YES;
    
    _titleButtonScrollView = [UIScrollView new];
    _titleButtonScrollView.bounces = NO;
    _titleButtonScrollView.frame = CGRectMake(0, _sizeY, _sizeWidth, _titleScrollViewHeight);
    
    if (_isFixedLength) {
        _titleButtonScrollView.contentSize = CGSizeMake(_titleButtonWidth*_titlesCount, _titleScrollViewHeight);
        
    } else {
        _titleButtonScrollView.contentSize = CGSizeMake(_sizeWidth, _titleScrollViewHeight);
    }
    _titleButtonScrollView.pagingEnabled = YES;
    _titleButtonScrollView.bounces = NO;
    _titleButtonScrollView.showsVerticalScrollIndicator = NO;
    _titleButtonScrollView.showsHorizontalScrollIndicator = NO;
    _titleButtonScrollView.delegate = self;
    [self.view addSubview:_titleButtonScrollView];
    
    _subViewScrollView = [UIScrollView new];
    _subViewScrollView.frame = CGRectMake(0, _sizeY+_titleScrollViewHeight, _sizeWidth, _sizeHeight-_titleScrollViewHeight);

    _subViewScrollView.contentSize = CGSizeMake(_sizeWidth*_titlesCount, _sizeHeight-_titleScrollViewHeight);
    _subViewScrollView.pagingEnabled = YES;
    _subViewScrollView.delegate = self;
    [self.view addSubview:_subViewScrollView];
}

#pragma mark - 标题栏添加按钮
- (void)setContentForTitleScrollView
{
    if (_titlesCount > 0) {
        for (int i = 0; i < _titlesCount; i++) {
            UIButton *label = [UIButton new];
            label.frame = CGRectMake(_titleButtonWidth*i, 0, _titleButtonWidth, _titleScrollViewHeight-_footHeight);
            [label setTitle:_titles[i] forState:UIControlStateNormal];
            label.titleLabel.font = _font;
            [label setBackgroundColor:_buttonBackgroundColor];
            label.tag = i+1;
            [label addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
            [_buttons addObject:label];
            [_titleButtonScrollView addSubview:label];
            if (i == 0) {
                [label setTitleColor:_buttonTitleSelectedColor forState:UIControlStateNormal];
            } else {
                [label setTitleColor:_buttonTitleUnSelectedColor forState:UIControlStateNormal];
            }
            
            UIView *footView = [UIView new];
            footView.userInteractionEnabled = YES;
            [footView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTitleFootView:)]];
            switch (_selectedType) {
                case TitleSelectedTypeWithFoot:
                {
                    footView.frame = CGRectMake(_titleButtonWidth*i, _titleScrollViewHeight-_footHeight, _titleButtonWidth, _footHeight);
                    footView.backgroundColor = _buttonBackgroundColor;
                    footView.tag = i+1000;
                    [_foots addObject:footView];
                    [_titleButtonScrollView addSubview:footView];
                    
                    if (i == 0) {
                        footView.backgroundColor = _buttonSelectedColor;
                    } else {
                        footView.backgroundColor = _footerUnSelectedColor;
                    }
                    break;
                }
                case TitleSelectedTypeWithBubble:
                {
                    footView.frame = CGRectMake(CGRectGetMinX(label.frame)+5, CGRectGetMinY(label.frame)+4, CGRectGetWidth(label.frame) - 10, CGRectGetHeight(label.frame)-8);
                    footView.backgroundColor = _buttonBackgroundColor;
                    footView.tag = i+1000;
                    footView.alpha = 0.3;
                    footView.layer.cornerRadius = _bubbleCornerRadius;
                    [_foots addObject:footView];
                    [_titleButtonScrollView addSubview:footView];
                    
                    if (i == 0) {
                        footView.backgroundColor = _buttonSelectedColor;
                    } else {
                        footView.backgroundColor = _footerUnSelectedColor;
                    }
                    break;
                }
                default:
                    break;
            }
            
            
        }
    }
}
//点击标题按钮滚动
- (void)clickTitleButton:(UIButton *)button
{
    int i = (int)button.tag;
    
    [self scrollViewSelectedAction:i+999];

    /*
    for (UIButton *button in _buttons) {
        if (button.tag == i) {
            [button setTitleColor:_buttonTitleSelectedColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:_buttonTitleUnSelectedColor forState:UIControlStateNormal];
        }
    }
    for (UIView *foots in _foots) {
        switch (_selectedType) {
            case TitleSelectedTypeWithFoot:
            {
                if (foots.tag == i+999) {
                    [foots setBackgroundColor:_buttonSelectedColor];
                } else {
                    [foots setBackgroundColor:_footerUnSelectedColor];
                }
                break;
            }
            case TitleSelectedTypeWithBubble:
            {
                if (foots.tag == i+999) {
                    [foots setBackgroundColor:_buttonSelectedColor];
                } else {
                    [foots setBackgroundColor:_footerUnSelectedColor];
                }
                break;
            }
            default:
                break;
        }
        
    }

    //滚动对应的视图
    [_subViewScrollView scrollRectToVisible:CGRectMake(_sizeWidth*(i-1), 0, _sizeWidth, _sizeHeight-_titleScrollViewHeight) animated:YES];
    */
    //实现代理回调
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(delegateActionForScrollButton:)]) {
        [_myDelegate delegateActionForScrollButton:i];
    }
}

- (void)clickTitleFootView:(UITapGestureRecognizer *)tap
{
    NSInteger viewTag = tap.view.tag;
    
    [self scrollViewSelectedAction:viewTag];
}

#pragma mark - scroll action
- (void)scrollViewSelectedAction:(NSInteger)index
{
    for (UIButton *button in _buttons) {
        if (button.tag == index-999) {
            [button setTitleColor:_buttonTitleSelectedColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:_buttonTitleUnSelectedColor forState:UIControlStateNormal];
        }
    }
    for (UIView *foots in _foots) {
        switch (_selectedType) {
            case TitleSelectedTypeWithFoot:
            {
                if (foots.tag == index) {
                    [foots setBackgroundColor:_buttonSelectedColor];
                } else {
                    [foots setBackgroundColor:_footerUnSelectedColor];
                }
                break;
            }
            case TitleSelectedTypeWithBubble:
            {
                if (foots.tag == index) {
                    [foots setBackgroundColor:_buttonSelectedColor];
                } else {
                    [foots setBackgroundColor:_footerUnSelectedColor];
                }
                break;
            }
            default:
                break;
        }
        
    }
    
    //滚动对应的视图
    [_subViewScrollView scrollRectToVisible:CGRectMake(_sizeWidth*(index-1000), 0, _sizeWidth, _sizeHeight-_titleScrollViewHeight) animated:YES];
}


#pragma mark - 滚动页面栏添加页面
- (void)setContentForSubviewScrollView
{
    CGFloat viewControllerHeight = _sizeHeight-_titleScrollViewHeight;
    
    if (_titlesCount > 0) {
        for (int i = 0; i < _titlesCount; i++) {
            UIViewController *viewController = (UIViewController *)_controllers[i];
            viewController.view.frame = CGRectMake(_sizeWidth*i, 0, _sizeWidth, viewControllerHeight);
            viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            
            [_subViewScrollView addSubview:viewController.view];
            [self addChildViewController:viewController];
        }
        
    }
}

//动作
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _subViewScrollView) {
        int viewIndexTag = (scrollView.contentOffset.x)/_sizeWidth;
        
        [_titleButtonScrollView scrollRectToVisible:CGRectMake(_sizeWidth*(viewIndexTag-2), 0, _sizeWidth, _titleScrollViewHeight) animated:YES];
        
        for (UIButton *button in _buttons) {
            if (button.tag == (viewIndexTag+1)) {
                [button setTitleColor:_buttonTitleSelectedColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:_buttonTitleUnSelectedColor forState:UIControlStateNormal];
            }
        }
        
        for (UIView *foots in _foots) {
            switch (_selectedType) {
                case TitleSelectedTypeWithFoot:
                {
                    if (foots.tag == viewIndexTag+1000) {
                        [foots setBackgroundColor:_buttonSelectedColor];
                    } else {
                        [foots setBackgroundColor:_footerUnSelectedColor];
                    }                    break;
                }
                case TitleSelectedTypeWithBubble:
                {
                    if (foots.tag == viewIndexTag+1000) {
                        [foots setBackgroundColor:_buttonSelectedColor];
                    } else {
                        [foots setBackgroundColor:_footerUnSelectedColor];
                    }
                    break;
                }
                default:
                    break;
            }
            
        }
    }
}

#pragma mark -

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex) {
        _selectedIndex = selectedIndex;
    } else {
        _selectedIndex = 0;
    }
    
    [self scrollViewSelectedAction:selectedIndex+1000];
    
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(delegateActionForScrollButton:)]) {
        [_myDelegate delegateActionForScrollButton:selectedIndex];
    }
}

@end
