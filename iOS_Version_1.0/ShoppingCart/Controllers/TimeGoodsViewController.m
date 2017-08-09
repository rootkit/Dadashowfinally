//
//  TimeGoodsViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "TimeGoodsViewController.h"
#import "ShoptableViewController.h"
#import "SQMenuShowView.h"
#import "UIColor+CustomColor.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define titleWidth SCREEN_WIDTH/5
#define titleHeight 45   //滚动按钮的高度
#define headimageheght  167 //头部图片的高度
#define headHeight    titleHeight+headimageheght //头部视图的高度
#define cellheght  960//底层cell的高度


@interface TimeGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIButton *selectButton;
    UIView *_sliderView;
    UIViewController *_viewController;
    UIScrollView *_scrollView;
    UIScrollView *_scroll;
}

@property (nonatomic, strong) NSArray *titleArray;
@property(nonatomic,strong)UIView* tableviewheadview;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property(nonatomic,strong)UITableView* commoditytableview;
@property (nonatomic, strong) NSArray *controllerArray;
@property (strong, nonatomic)  SQMenuShowView *showView;
@property (assign, nonatomic)  BOOL  isShow;
@property(nonatomic,strong)UIView* blackview;
@end

@implementation TimeGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"限时抢购";
    [self controllerArray];
    [self buttonArray ];
    self.view.backgroundColor=[UIColor grayColor];
    self.titleArray =[NSArray array];
    self.titleArray= @[@"one",@"two",@"stree",@"four", @"five", @"six", @"seven", @"eight"];
    [self setview];
    __weak typeof(self) weakSelf = self;
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分类"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showcategory)];
    [self.showView selectBlock:^(SQMenuShowView *view, NSInteger index) {
        [weakSelf  dismiss];
        NSLog(@"点击%ld",(long)index);
        
    }];

    
}
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- ( NSArray *)controllerArray
{
    if (!_controllerArray) {
        _controllerArray = [NSArray  array];
        ShoptableViewController *oneVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *twoVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *streeVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *fourVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *fiveVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *saxVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *sevenVC = [[ShoptableViewController alloc] init];
        ShoptableViewController *eightVC = [[ShoptableViewController alloc] init];
        self.controllerArray = @[oneVC,twoVC,streeVC,fourVC,fiveVC,saxVC,sevenVC, eightVC];
   }
    return _controllerArray;
}

//前面没照片的
- (SQMenuShowView *)showView{
    
    if (_showView) {
        return _showView;
    }
    NSArray* themearray=@[@"精选",@"女装",@"女鞋",@"包包",@"配饰"];
    _showView = [[SQMenuShowView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-100-20,64+5,111,0}
                                               items:themearray
                                           showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10}];
    _showView.sq_backGroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView];
    
    return _showView;
}



-(void)setview{
    UIView* tableheadview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, headHeight)];
    [self.view addSubview:tableheadview];
    _tableviewheadview=tableheadview;
    UIImageView* headimageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, headimageheght)];
    headimageview.image=[UIImage imageNamed:@"首页"];
    [tableheadview addSubview:headimageview];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headimageheght, kScreen_Width, titleHeight)];
    scroll.contentSize = CGSizeMake(titleWidth*self.titleArray.count, titleHeight);
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.showsHorizontalScrollIndicator = YES;
    [scroll flashScrollIndicators];
    [tableheadview addSubview:scroll];
      _scroll = scroll;
    NSLog(@"%lu",(unsigned long)self.titleArray.count);
    for (int i = 0; i < self.titleArray.count; i++) {
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(titleWidth*i, 0, titleWidth, titleHeight);
//    [titleButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleButton setBackgroundColor:[UIColor colorWithHex:0x360020]];
    titleButton.tag = 100+i;
    UILabel* timelable=[UILabel new];
    timelable.textColor=[UIColor whiteColor];
    timelable.text=@"23:00";
    timelable.frame=CGRectMake(0, 0, titleButton.frame.size.width, titleButton.frame.size.height/2);
    timelable.textAlignment=NSTextAlignmentCenter;
    timelable.font=[UIFont systemFontOfSize:13.0];
    [titleButton addSubview:timelable];
    UILabel* timestatuslable=[UILabel new];
    timestatuslable.textColor=[UIColor whiteColor];
    timestatuslable.text=@"已开抢";
    timestatuslable.frame=CGRectMake(0, titleButton.frame.size.height/2, titleButton.frame.size.width, titleButton.frame.size.height/2);
    timestatuslable.textAlignment=NSTextAlignmentCenter;
    timestatuslable.font=[UIFont systemFontOfSize:13.0];
    [titleButton addSubview:timestatuslable];
    [titleButton addTarget:self action:@selector(scrollViewSelectToIndex:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:titleButton];
    if (i == 0) {
       selectButton = titleButton;
       [selectButton setImage:[UIImage imageNamed:@"bg_jiantou"] forState:UIControlStateNormal];
    }
       [_buttonArray addObject:titleButton];
        
    }
    UIView *sliderV=[[UIView alloc]initWithFrame:CGRectMake(0, titleHeight-1, titleWidth, 1)];
    [scroll addSubview:sliderV];
    _sliderView=sliderV;
    [self commoditytableview];

}
- (UITableView *)commoditytableview
{
    if (!_commoditytableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableHeaderView =_tableviewheadview;
        tableView.rowHeight=cellheght;
        [self.view addSubview:tableView];
        _commoditytableview = tableView;
    }
    return _commoditytableview;
}
- (void)scrollViewSelectToIndex:(UIButton *)button
{
    
    [self selectButton:button.tag-100];
    
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH*(button.tag-100), 0);
        
    }];
}

//选择某个标题
- (void)selectButton:(NSInteger)index
{
    
    [selectButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    selectButton = _buttonArray[index];
    [selectButton setImage:[UIImage imageNamed:@"bg_jiantou"] forState:UIControlStateNormal];
    CGRect rect = [selectButton.superview convertRect:selectButton.frame toView:self.view];
    
    [UIView animateWithDuration:0 animations:^{
        _sliderView.frame = CGRectMake(titleWidth*index, titleHeight-1, titleWidth, 1);
        CGPoint contentOffset = _scroll.contentOffset;
        if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-titleWidth/2)<=0) {
            [_scroll setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
//            [self.commoditytableview reloadData];
        } else if (contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-titleWidth/2)+SCREEN_WIDTH>=_titleArray.count*titleWidth) {
            [_scroll setContentOffset:CGPointMake(_titleArray.count*titleWidth-SCREEN_WIDTH, contentOffset.y) animated:YES];
//            [self.commoditytableview reloadData];
        } else {
            [_scroll setContentOffset:CGPointMake(contentOffset.x - (SCREEN_WIDTH/2-rect.origin.x-titleWidth/2), contentOffset.y) animated:YES];
//            [self.commoditytableview reloadData];
        }
    }];
    
}

//监听滚动事件判断当前拖动到哪一个了
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _scrollView) {
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self selectButton:index];
    } else {
//        NSLog(@"滚动小滚动试图");
    }
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Commodity";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
      NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    NSDictionary *userInfo = @{@"rowheight":@cellheght};
    [notificationCenter postNotificationName:@"changetable"object:nil userInfo:userInfo];
      [self initWithController:cell.contentView];
    return cell;
    
}

- (void)initWithController:(UIView*)cellview
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    if (self.navigationController.navigationBar) {
//        scrollView.frame = CGRectMake(0, titleHeight+191, SCREEN_WIDTH, SCREEN_HEIGHT-titleHeight-64);
//    } else {
        scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH,  cellheght);
//    }
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_controllerArray.count,  cellheght);
    [cellview addSubview:scrollView];
    _scrollView = scrollView;
    for (int i = 0; i < self.controllerArray.count; i++) {
        UIView *viewcon = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIViewController *viewcontroller = self.controllerArray[i];
        viewcon = viewcontroller.view;
        viewcon.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [scrollView addSubview:viewcon];
    }
}

-(void)showcategory{
    NSLog(@"展开小列表");
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
            [self.view insertSubview:self.blackview belowSubview:self.showView];
        } completion:^(BOOL finished) {
            //动画结束后弹出弹出view
            [self.showView showView];
        }];
    }else{
        //弹出view和背景blackview一起消失
        
        [UIView animateWithDuration: 0.35 animations: ^{
            [self.showView dismissView];
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration: 0.01 animations: ^{
                
                self.blackview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                
            }completion:nil];
            
        }];
    }
}
-(void)dismiss{
    _isShow = NO;
    [UIView animateWithDuration: 0.35 animations: ^{
        [self.showView dismissView];
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration: 0.01 animations: ^{
            
            self.blackview.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
            
            
        }completion:nil];
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
