//
//  LeadingViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "LeadingViewController.h"
#import "AdvertiseView.h"
#import "AppDelegate.h"
@interface LeadingViewController () <UIScrollViewDelegate>

#define top_jump_padding 30* kScreen_Width / 375
#define right_jump_padding 18* kScreen_Width / 375
#define jump_Btn_H 24* kScreen_Width / 375
#define jump_Btn_W 55* kScreen_Width / 375

#define start_Btn_H 40* kScreen_Width / 375
#define start_Btn_W 188* kScreen_Width / 375
#define start_bottom_padding 23* kScreen_Width / 375
@property (nonatomic, strong) UIScrollView *imgScrollView;//guidePage_1
@property (nonatomic, strong) UIImageView *lastImg;
@property (nonatomic, strong) UIButton *jumpButton;//
@property (nonatomic, strong) UIButton *startButton;//
@property (nonatomic, strong) UIPageControl *pageControl;//guidePage_moren guidePage_point_selected

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation LeadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    _currentIndex = 0;
    [self setLayoutSubviews];
    [self setaddvertiseview];
  
 

}
/**加载广告视图*/
-(void)setaddvertiseview{
    /**加载广告试图*/
    AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    advertiseView.backgroundColor=[UIColor whiteColor];
     [advertiseView show:self];
   
}


- (void)setLayoutSubviews
{
    UIScrollView *scr = [UIScrollView new];
    scr.backgroundColor = DefaultImgBgColor;
    scr.contentSize = CGSizeMake(kScreen_Width*3, kScreen_Height);
    scr.showsVerticalScrollIndicator = NO;
    scr.showsHorizontalScrollIndicator = NO;
    scr.pagingEnabled = YES;
    scr.bounces = NO;
    scr.delegate = self;
    [self.view addSubview:scr];
    _imgScrollView = scr;
    
    [scr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width*i, 0, kScreen_Width, kScreen_Height)];
        img.userInteractionEnabled=YES;
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"guidePage_%d", i+1]];
        if (i == 2) {
            _lastImg = img;
            
            UIButton *startBtn = [UIButton new];
            [startBtn setImage:[UIImage imageNamed:@"guidePage_start"] forState:UIControlStateNormal];
            [_lastImg addSubview:startBtn];
            [startBtn addTarget:self action:@selector(quitGuidePage) forControlEvents:UIControlEventTouchUpInside];
            [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_lastImg.mas_bottom).with.offset(-start_bottom_padding);
                make.width.equalTo(@(start_Btn_W));
                make.height.equalTo(@(start_Btn_H));
                make.centerX.equalTo(_lastImg);
            }];
            
        } else { }
        
        [scr addSubview:img];
    }
    
    UIButton *jumpBtn = [UIButton new];
    [jumpBtn setImage:[UIImage imageNamed:@"guidePage_jump"] forState:UIControlStateNormal];
    [self.view addSubview:jumpBtn];
    [jumpBtn addTarget:self action:@selector(quitGuidePage) forControlEvents:UIControlEventTouchUpInside];
    [jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(top_jump_padding);
        make.right.equalTo(self.view.mas_right).with.offset(-right_jump_padding);
        make.width.equalTo(@(jump_Btn_W));
        make.height.equalTo(@(jump_Btn_H));
    }];
    
    UIPageControl *page = [UIPageControl new];
    page.numberOfPages = 3;
    page.currentPage = 0;
    page.pageIndicatorTintColor = IconTextColor;
    page.currentPageIndicatorTintColor = ThemeColor;
    [self.view addSubview:page];
    _pageControl = page;
    [page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-start_bottom_padding));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(start_Btn_H));
    }];
}

- (void)quitGuidePage
{
    NSLog(@"跳过");
     AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     [myAppDelegate setTabbarSubviews];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    
    if (_currentIndex == 2) {
        _pageControl.hidden = YES;
    } else {
        _pageControl.hidden = NO;
    }
    _pageControl.currentPage = _currentIndex;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSInteger integer = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    
    if (integer == 1) {
        _pageControl.hidden = YES;
    } else {
        _pageControl.hidden = NO;
    }
}
@end
