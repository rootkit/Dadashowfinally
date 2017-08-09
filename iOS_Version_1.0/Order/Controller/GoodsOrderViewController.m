//
//  GoodsOrderViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 订单页面 ****/
#import "GoodsOrderViewController.h"
#import "OrderListViewController.h"
#import "TitleViewController.h"
#import "MessageListViewController.h"
#import "OpinionViewController.h"

#import "SQimageMenuShowView.h"

#define rating kScreen_Width/375

@interface GoodsOrderViewController ()

@property (nonatomic, assign) GoodsOrderTypes orderTypes;
@property (nonatomic, strong) SQimageMenuShowView *sideShowView;
@property (nonatomic, assign) BOOL isShow;
@property(nonatomic,strong)UIView* blackview;

@end

@implementation GoodsOrderViewController

- (instancetype)initWithOrderType:(GoodsOrderTypes)orderType
{
    self = [super init];
    if (self) {
        _orderTypes = orderType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = BackCellColor;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"fashion_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    [self layoutScrollTitle];
    
    __weak typeof(self) weakSelf = self;
    [self.sideShowView selectBlock:^(SQimageMenuShowView *view, NSInteger index) {
        weakSelf.isShow = NO;
        [self spliteAction:index];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 弹出框 ACTION
- (void)spliteAction:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [self.navigationController pushViewController:[MessageListViewController new] animated:YES];
            [self dismiss];
            break;
        }
        case 1:
        {
            NSLog(@"个人中心");
            [self.navigationController popViewControllerAnimated:YES];
            [self dismiss];
            break;
        }
        case 2:
        {
            NSLog(@"反馈");
            [self.navigationController pushViewController:[OpinionViewController new] animated:YES];
            [self dismiss];
            break;
        }
        default:
            break;
    }
}


#pragma mark - back action

- (void)moreAction
{
    NSLog(@"我的订单右导航栏按钮...");
    
    _isShow = !_isShow;
    NSLog(@"%d",_isShow);
    
    if (_isShow) {
        //点击后弹出背景透明view
        [UIView animateWithDuration:0.0005 animations:^{
            if(!self.blackview){
                //添加各种滑动手势
                self.blackview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swipeup = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                UISwipeGestureRecognizer *swipedown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
                [swipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
                [swiperight setDirection:UISwipeGestureRecognizerDirectionRight];
                [swipeup setDirection:UISwipeGestureRecognizerDirectionUp];
                [swipedown setDirection:UISwipeGestureRecognizerDirectionDown];
                [self.blackview addGestureRecognizer:swipeleft];
                [self.blackview addGestureRecognizer:swiperight];
                [self.blackview addGestureRecognizer:swipeup];
                [self.blackview addGestureRecognizer:swipedown  ];
                [self.blackview addGestureRecognizer:tap];
            }
            self.blackview.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height);
            self.blackview.backgroundColor=[UIColor clearColor];
            //把背景blackview放的弹出view的下面
            [self.view insertSubview:self.blackview belowSubview:self.sideShowView];
        } completion:^(BOOL finished) {
            //动画结束后弹出弹出view
            [self.sideShowView showView];
        }];
    } else {
        //弹出view和背景blackview一起消失
        
        [UIView animateWithDuration: 0.35
                         animations: ^{
                             [self.sideShowView dismissView];
                         } completion:^(BOOL finished) {
            
                             [UIView animateWithDuration: 0.01
                                              animations: ^{
                                                  self.blackview.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                                              }completion:nil];
                         }];
    }
}

-(void)dismiss{
    _isShow = NO;
    [UIView animateWithDuration: 0.35
                     animations: ^{
                         [self.sideShowView dismissView];
                     } completion:^(BOOL finished) {
        
                        [UIView animateWithDuration: 0.01
                                         animations: ^{
                            self.blackview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);

                        } completion:nil];
    }];
}

- (void)layoutScrollTitle
{
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"订单", @"待付款", @"待收货", @"待评价", @"售后"]
                                                               viewControllers:@[[[OrderListViewController alloc] initWithOrderType:GoodsOrderTypesWithAll],
                                                                                 [[OrderListViewController alloc] initWithOrderType:GoodsOrderTypesWithObligation],
                                                                                 [[OrderListViewController alloc] initWithOrderType:GoodsOrderTypesWithWaitForReceiv],
                                                                                 [[OrderListViewController alloc] initWithOrderType:GoodsOrderTypesWithRemainTobeEvaluated],
                                                                                 [[OrderListViewController alloc] initWithOrderType:GoodsOrderTypesWithAfterSale],]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = 45*rating;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 1;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14*rating];
    
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
    titleCtl.selectedIndex = _orderTypes;
}

- (SQimageMenuShowView *)sideShowView
{
    if (!_sideShowView) {
        _sideShowView = [[SQimageMenuShowView alloc] initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-125*rating, 65, 111*rating, 0}
                                                             items:@[@"消息", @"个人中心", @"反馈"]
                                                         imagearry:@[@"bubble",@"myOrder_sideView_myCenter",@"myOrder_sideView_feedBack"]
                                                         showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-30*rating, 5*rating}];
        _sideShowView.sq_backGroundColor = [UIColor whiteColor];
        _sideShowView.layer.shadowOffset = CGSizeMake(0.3, 0.3);
        _sideShowView.layer.shadowOpacity = 0.3; //设置阴影的不透明度
        _sideShowView.layer.shadowRadius = 3;  //设置阴影的半径
        
        [self.view addSubview:_sideShowView];
    }
    return _sideShowView;
}

@end
