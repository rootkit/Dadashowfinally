//
//  LimitedGoodsViewController.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

/****** 滴搭秒 ******/
#import "LimitedGoodsViewController.h"
#import "GoodsLimtedListController.h"
#import "LimitedGoodsPageView.h"
#import "LimitedGoodsTimePageView.h" //标题滚动栏
//#import "NewPagedFlowView.h"

#import "CardScrollView.h"

#define kScreen_Width  [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define card_heigth 111*kScreen_Width/375
#define card_width 350*kScreen_Width/375
#define left_card_padding 6
#define card_padding 8

#define kHeadView_Height 150*kScreen_Width/375
#define kTitleView_Height 50*kScreen_Width/375
#define naviBar_height 64

@interface LimitedGoodsViewController () <CardScrollViewDelegate>//NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,
{
    UIView *bottomView;
}

@property (nonatomic, strong) LimitedGoodsTimePageView *titleView;
@property (nonatomic, strong) LimitedGoodsPageView *pageView;
@property (nonatomic, strong) UIImageView *headView;
//@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@property (nonatomic, strong) CardScrollView *topView;

@property (nonatomic, strong) NSMutableArray *childVCs;
@property (nonatomic, strong) UITableViewController *currentVC;
@property (nonatomic, assign) CGFloat oldOffsetY;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;

@end

@implementation LimitedGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"滴搭秒";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titles = @[@"23:00 已结束", @"00:00 已结束", @"09:00 抢购中", @"10:00 即将开始", @"11:00 即将开始", @"12:00 即将开始", @"13:00 即将开始", @"14:00 即将开始"];
    _images = @[@"Yosemite00", @"Yosemite01", @"Yosemite02", @"Yosemite03", @"Yosemite04"];
    
    [self setupInit];
}

- (void)setupInit {

    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, naviBar_height, kScreen_Width, kScreen_Height-naviBar_height)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView addSubview:self.pageView];
    [bottomView addSubview:self.titleView];
    [bottomView addSubview:self.headView];
    
    [self.pageView setCurrentIndex:2];//从0开始
    [self.titleView setCurrentTitleIndex:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CardScrollViewDelegate
- (void)cardScrollViewDidSelectedAt:(NSInteger)index
{
    NSLog(@"选中了：%zd",index);
    
}

#pragma mark - init

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kHeadView_Height)];
        _headView.backgroundColor = [UIColor whiteColor];
        _headView.clipsToBounds = YES;
        _headView.userInteractionEnabled = YES;
        [_headView addSubview:self.topView];
    }
    return _headView;
}

- (CardScrollView *)topView
{
    if (!_topView) {
        _topView = [[CardScrollView alloc] initWithFrame:CGRectMake(left_card_padding, 0, kScreen_Width-left_card_padding, kHeadView_Height)
                                            forItemWidth:card_width
                                           forItemHeight:card_heigth
                                          forItemSpacing:card_padding];
        _topView.delegate = self;
    }
    return _topView;
}

- (LimitedGoodsTimePageView *)titleView
{
    if (!_titleView) {
        _titleView = [[LimitedGoodsTimePageView alloc] initWithFrame:(CGRect){0, kHeadView_Height, kScreen_Width, kTitleView_Height} titles:_titles];
        __weak LimitedGoodsViewController *weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            [weakSelf.pageView setCurrentIndex:index];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kChangeTableViewOffSetYNotification" object:@(index)];
        };
    }
    return _titleView;
}

- (LimitedGoodsPageView *)pageView
{
    if (!_pageView) {
        _pageView = [[LimitedGoodsPageView alloc] initWithFrame:bottomView.bounds childVC:self.childVCs];
        __weak LimitedGoodsViewController *weakSelf = self;
        _pageView.didEndScrollView = ^(NSInteger index) {
            [weakSelf.titleView setCurrentTitleIndex:index];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kChangeTableViewOffSetYNotification" object:@(index)];
        };
    }
    return _pageView;
}

- (NSMutableArray *)childVCs
{
    if (!_childVCs) {
        _childVCs = [NSMutableArray new];
        __weak LimitedGoodsViewController *weakSelf = self;
        void(^offset)(CGFloat, UITableViewController *) = ^(CGFloat offsetY, UITableViewController *VC) {
            
            CGRect titleFrame = weakSelf.titleView.frame;
            
            titleFrame.origin.y = kHeadView_Height - offsetY;
            if (titleFrame.origin.y <= 0) {
                titleFrame.origin.y = 0;
            }
            
            weakSelf.titleView.frame = titleFrame;
            
            CGRect imageViewFrame = weakSelf.headView.frame;
            imageViewFrame.size.height = titleFrame.origin.y;
            weakSelf.headView.frame = imageViewFrame;
            
            weakSelf.currentVC = VC;
            weakSelf.oldOffsetY = offsetY;
            [weakSelf.childVCs enumerateObjectsUsingBlock:^(SecondBaseController *VC, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![weakSelf.currentVC.description isEqualToString:VC.description]) {
                    [VC setTableViewOffSetY:offsetY];
                }
            }];
            NSLog(@"%f", offsetY);
        };
        
        
        for (int i = 0; i < _titles.count; i++) {
            GoodsLimtedListController *heihei = [GoodsLimtedListController new];
            heihei.offSet = offset;
            
            [self addChildViewController:heihei];
            [_childVCs addObject:heihei];
        }
    }
    return _childVCs;
}

@end
