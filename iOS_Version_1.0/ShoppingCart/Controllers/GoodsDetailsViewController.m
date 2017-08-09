//
//  GoodsDetailsViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/23.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "TitleViewController.h"
#import "DiyroomgoodsViewController.h"
#import "TextRoomViewController.h"
#import "AllGoodsViewController.h"
#import "ZXRollView.h"
#define Couponviewwidth (kScreen_Width/2-22*(kScreen_Height/667))
#define Couponheigth 450*(kScreen_Height/667)//头部视图的高度
#define Couponbrandheigth 150*(kScreen_Height/667)//首张image的高度


@interface GoodsDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,ZXRollViewDelegate>
{
    NSArray *_titles;
    NSArray *_controllers;
}
@property (nonatomic, weak) UITableView *goodsdetailtableview;
@property(nonatomic,strong)UIView* headview;
@property(nonatomic,strong)UIView* footview;
@property(nonatomic,strong)NSNotificationCenter *notificationCenter;
@property(nonatomic,strong)NSNotificationCenter *allnotificationCenter;
@property (nonatomic, strong) ZXRollView *rollViewColor;

@end

@implementation GoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self footview];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setgoodsdetailview];
    [self notificationCenter];
    [self allnotificationCenter];
    UIBarButtonItem *morebtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"fashion_more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreclick)];
    UIBarButtonItem *goshopingbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageRendingMode:@"ico_store"] style:UIBarButtonItemStylePlain target:self action:@selector(goshoclick)];
    NSArray *arr=[[NSArray alloc]initWithObjects:morebtn, goshopingbtn, nil];
    self.navigationItem.rightBarButtonItems=arr;
    
}


-(NSNotificationCenter*)notificationCenter{
    if (!_notificationCenter) {
        _notificationCenter= [NSNotificationCenter defaultCenter];
    }
    return _notificationCenter;
}
-(NSNotificationCenter*)allnotificationCenter{
    if (!_allnotificationCenter) {
        _allnotificationCenter= [NSNotificationCenter defaultCenter];
    }
    return _allnotificationCenter;
}


- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tablescorllable) name:@"detailtablescorllable" object:nil];
           [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subscorllabled) name:@"subscorllable" object:nil];
        
    }
    return self;
}


-(void)setgoodsdetailview{
    
    //头部视图
    UIView* headview=[UIView new];
    headview.frame=CGRectMake(0, 0, kScreen_Width, Couponheigth);
    [self.view addSubview:headview];
    _headview=headview;
    
    UIImageView* brandimageview=[UIImageView new];
    brandimageview.userInteractionEnabled=YES;
    brandimageview.frame=CGRectMake(0, 0, kScreen_Width, Couponbrandheigth);
    brandimageview.image=[UIImage imageNamed:@"goodsdetails"];
    [headview addSubview:brandimageview];
    
    UIImageView* logoimageview=[UIImageView new];
    logoimageview.image=[UIImage imageNamed:@"detaillogo"];
    logoimageview.contentMode = UIViewContentModeScaleToFill;
    [brandimageview addSubview:logoimageview];
    [logoimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.bottom.equalTo(@(-6*(kScreen_Height/667)));
        make.width.equalTo(@(78*(kScreen_Height/667)));
        make.height.equalTo(@(48*(kScreen_Height/667)));
    }];
    
    UILabel* selllabel = [UILabel new];
    selllabel.text = @"销量31225";
    selllabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    selllabel.textColor = [UIColor whiteColor];
    [brandimageview addSubview:selllabel];
    [selllabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(logoimageview.mas_bottom);
        make.left.equalTo(logoimageview.mas_right).equalTo(@(7*(kScreen_Height/667)));
    }];
    
    UILabel* brandlabel = [UILabel new];
    brandlabel.text = @"Shinena";
    brandlabel.font = [UIFont systemFontOfSize:17*(kScreen_Height/667)];
    brandlabel.textColor = [UIColor whiteColor];
    [brandimageview addSubview:brandlabel];
    [brandlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(selllabel.mas_top).equalTo(@(-6*(kScreen_Height/667)));
        make.left.equalTo(logoimageview.mas_right).equalTo(@(7*(kScreen_Height/667)));
    }];
    
    UILabel* collectlabel = [UILabel new];
    collectlabel.text = @"收藏6065";
    collectlabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    collectlabel.textColor = [UIColor whiteColor];
    [brandimageview addSubview:collectlabel];
    [collectlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(logoimageview.mas_bottom);
        make.left.equalTo(selllabel.mas_right).equalTo(@(7*(kScreen_Height/667)));
    }];
    
    UILabel* clothesnamelabel = [UILabel new];
    clothesnamelabel.text = @"夏娜旗舰店";
    clothesnamelabel.font = [UIFont systemFontOfSize:17*(kScreen_Height/667)];
    clothesnamelabel.textColor = [UIColor whiteColor];
    [brandimageview addSubview:clothesnamelabel];
    [clothesnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(collectlabel.mas_top).equalTo(@(-6*(kScreen_Height/667)));
        make.left.equalTo( brandlabel.mas_right).equalTo(@(7*(kScreen_Height/667)));
    }];
    
    UIButton *collectbtn = [UIButton new];
    [collectbtn setBackgroundImage:[UIImage imageNamed:@"未收藏"] forState:UIControlStateNormal];
    [collectbtn setBackgroundImage:[UIImage imageNamed:@"已收藏"]  forState:UIControlStateSelected];
    [collectbtn addTarget:self action:@selector(iscollect:) forControlEvents:UIControlEventTouchUpInside];
    [brandimageview  addSubview:collectbtn];
    [collectbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-8*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));
        make.bottom.equalTo(@(-15*(kScreen_Height/667)));
        make.width.equalTo(@(70*(kScreen_Height/667)));
    }];
    
    
    
    
    //第二个分区视图
    UIView* limtsellview=[[UIView alloc]init];
    limtsellview.backgroundColor=[UIColor whiteColor];
    limtsellview.layer.shadowOffset = CGSizeMake(1, 1);
    limtsellview.frame=CGRectMake(12, 150*(kScreen_Height/667), kScreen_Width-24, 166*(kScreen_Height/667));//这边滚动横坐标不能缩小比例 否则会崩溃
    limtsellview.layer.shadowOpacity = 0.7; //设置阴影的不透明度
    limtsellview.layer.shadowRadius = 4.0;  //设置阴影的半径
    [headview addSubview:limtsellview];
    
    // 创建指示器为自定义颜色的 ZXRollView.
    self.rollViewColor = [[ZXRollView alloc] init];
    self.rollViewColor.frame=CGRectMake(12, 150*(kScreen_Height/667), kScreen_Width-24, 166*(kScreen_Height/667));//这边滚动横坐标不能缩小比例 否则会崩溃
    [headview addSubview:self.rollViewColor];
    self.rollViewColor.pageIndicatorColor = [UIColor colorWithHex:0xf6f6f6];
    self.rollViewColor.currentPageIndicatorColor = [UIColor colorWithHex:0xfc5c98];
    self.rollViewColor.delegate = self;
    self.rollViewColor.autoRolling = NO;
    self.rollViewColor.hideIndicatorForSinglePage = YES;
    self.rollViewColor.interitemSpacing = 0;
    [self.rollViewColor reloadViews];
    
    UIView* leftCouponview=[[UIView alloc]init];
    leftCouponview.backgroundColor=[UIColor whiteColor];
    leftCouponview.layer.cornerRadius=5*(kScreen_Height/677);
    leftCouponview.layer.masksToBounds=YES;
    leftCouponview.layer.borderColor=[UIColor colorWithHex:0xa6a6a6].CGColor;
    leftCouponview.layer.borderWidth=1.0*(kScreen_Height/677);
    [headview addSubview:leftCouponview];
    [leftCouponview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rollViewColor.mas_bottom).equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(@(16*(kScreen_Height/667)));
        make.width.equalTo(@(Couponviewwidth));
        make.height.equalTo(@(115*(kScreen_Height/667)));
    }];
    
    UILabel* leftpricelabel = [UILabel new];
    leftpricelabel.text = @"￥20.00";
    leftpricelabel.font = [UIFont systemFontOfSize:24*(kScreen_Height/667)];
    leftpricelabel.textColor = [UIColor colorWithHex:0xfc5c98];
    [leftCouponview addSubview:leftpricelabel];
    [leftpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16*(kScreen_Height/667)));
        make.left.equalTo(@(35*(kScreen_Height/667)));
    }];
    
    UILabel* leftconformlabel = [UILabel new];
    leftconformlabel.text = @"满289元可用";
    leftconformlabel.textAlignment=NSTextAlignmentCenter;
    leftconformlabel.font = [UIFont systemFontOfSize:14*(kScreen_Height/667)];
    leftconformlabel.textColor = [UIColor colorWithHex:0xfc5c98];
    [leftCouponview addSubview:leftconformlabel];
    [leftconformlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftpricelabel.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        
    }];
    
    UIButton *immediatelybutton = [UIButton new];
    immediatelybutton.titleLabel.font = [UIFont systemFontOfSize:11];
    [immediatelybutton setTitle:@"立即使用" forState:UIControlStateNormal];
    immediatelybutton.backgroundColor = ThemeColor;
    [immediatelybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    immediatelybutton.layer.cornerRadius = 2;
    [immediatelybutton addTarget:self action:@selector(immediatelone) forControlEvents:UIControlEventTouchUpInside];
    [leftCouponview addSubview:immediatelybutton];
    [immediatelybutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(50*(kScreen_Height/667)));
        make.right.equalTo(@(-50*(kScreen_Height/667)));
        make.height.equalTo(@(16*(kScreen_Height/667)));
        make.top.equalTo(leftconformlabel.mas_bottom).equalTo(@(11*(kScreen_Height/667)));
         }];
    
    UIView* rightCouponview=[[UIView alloc]init];
    rightCouponview.backgroundColor=[UIColor whiteColor];
    rightCouponview.layer.cornerRadius=5*(kScreen_Height/677);
    rightCouponview.layer.masksToBounds=YES;
    rightCouponview.layer.borderColor=[UIColor colorWithHex:0xa6a6a6].CGColor;
    rightCouponview.layer.borderWidth=1.0*(kScreen_Height/677);
    [headview addSubview:rightCouponview];
    [rightCouponview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rollViewColor.mas_bottom).equalTo(@(5*(kScreen_Height/667)));
        make.right.equalTo(@(-16*(kScreen_Height/667)));
        make.width.equalTo(@(Couponviewwidth));
        make.height.equalTo(@(115*(kScreen_Height/667)));
    }];
    
    UILabel* rightpricelabel = [UILabel new];
    rightpricelabel.text = @"￥40.00";
    rightpricelabel.font = [UIFont systemFontOfSize:24*(kScreen_Height/667)];
    rightpricelabel.textColor = [UIColor colorWithHex:0x53d0f4];
    [rightCouponview addSubview:rightpricelabel];
    [rightpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16*(kScreen_Height/667)));
        make.left.equalTo(@(35*(kScreen_Height/667)));
    }];
    
    UILabel* rightconformlabel = [UILabel new];
    rightconformlabel.text = @"满389元可用";
    rightconformlabel.textAlignment=NSTextAlignmentCenter;
    rightconformlabel.font = [UIFont systemFontOfSize:14*(kScreen_Height/667)];
    rightconformlabel.textColor = [UIColor colorWithHex:0x53d0f4];
    [rightCouponview addSubview:rightconformlabel];
    [rightconformlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightpricelabel.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        
    }];
    
    UIButton *rightbutton = [UIButton new];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightbutton setTitle:@"立即使用" forState:UIControlStateNormal];
    rightbutton.backgroundColor = [UIColor colorWithHex:0x53d0f4];
    [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbutton.layer.cornerRadius = 2;
    [rightbutton addTarget:self action:@selector(rightimmediatelone) forControlEvents:UIControlEventTouchUpInside];
    [rightCouponview  addSubview:rightbutton];
    [rightbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(50*(kScreen_Height/667)));
        make.right.equalTo(@(-50*(kScreen_Height/667)));
        make.height.equalTo(@(16*(kScreen_Height/667)));
        make.top.equalTo(rightconformlabel.mas_bottom).equalTo(@(11*(kScreen_Height/667)));
    }];
  
    //第三个分区
    [self goodsdetailtableview];
}

-(void)immediatelone{
    NSLog(@"立即使用");
}
-(void)rightimmediatelone{
     NSLog(@"立即使用");
}
-(void)iscollect:(UIButton*)btn{
    btn.selected=!btn.selected;
    NSLog(@"收藏");
}
-(void)moreclick{
    NSLog(@"更多");
}

-(void)goshoclick{
    NSLog(@"前往购物车");
}


#pragma mark <ZXRollViewDelegate>
- (NSInteger)numberOfItemsInRollView:(ZXRollView *)rollView {
  
    return 3;
   
}

- (void)rollView:(nonnull ZXRollView *)rollView setViewForRollView:(nonnull UIView *)view atIndex:(NSInteger)index {
    switch (index) {
        case 0:
            [self setsubscollview:view];
            view.backgroundColor=[UIColor whiteColor];
            break;
        case 1:
            [self setsubscollview:view];
             view.backgroundColor=[UIColor whiteColor];
            break;
        case 2:
           [self setsubscollview:view];
            view.backgroundColor=[UIColor whiteColor];
            break;

            
        default:
            [self setsubscollview:view];
            view.backgroundColor=[UIColor whiteColor];
            break;
    }
}

-(void)setsubscollview:(UIView*)zxrollview{
    
        UILabel* titlelabel = [UILabel new];
        titlelabel.text = @"限时特卖·CHOOSE FOR YOU";
        titlelabel.textAlignment=NSTextAlignmentCenter;
        titlelabel.font = [UIFont systemFontOfSize:12];
        titlelabel.textColor = [UIColor colorWithHex:0x353434];
        [zxrollview addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5*(kScreen_Height/667)));
            make.left.equalTo(@0);
            make.right.equalTo(@(-0));
        }];
    
        UIImageView* lineview=[[UIImageView alloc]init];
        lineview.frame=CGRectMake(45*(kScreen_Height/667), 23*(kScreen_Height/667), kScreen_Width-90*(kScreen_Height/667), 2*(kScreen_Height/667));
        lineview.image = [self drawLineOfDashByImageView:lineview];
        [zxrollview addSubview: lineview];
    
        UIImageView* clothesimage=[UIImageView new];
        clothesimage.image=[UIImage imageNamed:@"chanpin"];
        [zxrollview addSubview:clothesimage];
        [clothesimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineview.mas_bottom).equalTo(@1);
            make.left.equalTo(@(12*(kScreen_Height/667)));
            make.width.equalTo(@(128*(kScreen_Height/667)));
            make.height.equalTo(@(128*(kScreen_Height/667)));
        }];
    
        UILabel* describelabel = [UILabel new];
        describelabel.text = @"夏娜2017春装新款欧美个性印华西装,帅气中性独特印花撞色外套";
          describelabel.numberOfLines=2;
        describelabel.font = [UIFont systemFontOfSize:12];
        describelabel.textColor = [UIColor colorWithHex:0x353434];
        [zxrollview addSubview: describelabel];
        [describelabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(lineview.mas_bottom).equalTo(@(13*(kScreen_Height/667)));
           make.left.equalTo(clothesimage.mas_right).equalTo(@(19*(kScreen_Height/667)));
           make.right.equalTo(@(-14*(kScreen_Height/667)));
       }];
    
       UILabel *historyprice= [[UILabel alloc] init];
       historyprice.font = [UIFont systemFontOfSize:11.0];
       historyprice.text=@"$576.00";
       historyprice.textColor=[UIColor colorWithHex:0xa8a8a8];
       [zxrollview addSubview:historyprice];
       [historyprice mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(describelabel.mas_bottom).equalTo(@(24*(kScreen_Height/667)));
           make.left.equalTo(clothesimage.mas_right).equalTo(@(19*(kScreen_Height/667)));
        
        }];
    
        UILabel* line=[UILabel new];
        line.backgroundColor=[UIColor colorWithHex:0xa8a8a8];
        [historyprice addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(6*(kScreen_Height/667)));
        make.left.equalTo(historyprice.mas_left);
        make.height.equalTo(@0.5);
        make.right.equalTo(historyprice.mas_right);
        }];
    
       UILabel *priceslabel= [[UILabel alloc] init];
       priceslabel.font = [UIFont systemFontOfSize:17.0*(kScreen_Height/667)];
       priceslabel.text=@"限时$288.00";
       priceslabel.textColor=[UIColor colorWithHex:0xfc5c98];
       [zxrollview addSubview:priceslabel];
       [priceslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(historyprice.mas_bottom).equalTo(@(11*(kScreen_Height/667)));
        make.left.equalTo(clothesimage.mas_right).equalTo(@(19*(kScreen_Height/667)));
        
       }];
    
    // 还剩下的数量
       UILabel *remain= [[UILabel alloc] init];
       remain.font = [UIFont systemFontOfSize:12.0];
    //    shopnames.backgroundColor=[UIColor greenColor];
       remain.text=@"仅剩50件";
       remain.textColor=[UIColor colorWithHex:0xa8a8a8];
       remain.textAlignment=NSTextAlignmentRight;
       [zxrollview addSubview:remain];
       [remain mas_makeConstraints:^(MASConstraintMaker *make) {
          make.bottom.equalTo(priceslabel.mas_bottom);
          make.right.equalTo(@(-14*(kScreen_Height/667)));
        
        }];
    
       UIImageView* timeicon=[UIImageView new];
       timeicon.image=[UIImage imageNamed:@"ico_time"];
       [zxrollview addSubview:timeicon];
       [timeicon mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.equalTo(remain.mas_left).equalTo(@(-4*(kScreen_Height/667)));
          make.width.equalTo(@(10*(kScreen_Height/667)));
          make.height.equalTo(@(10*(kScreen_Height/667)));
          make.bottom.equalTo(priceslabel.mas_bottom);
       }];
}



- (void)rollView:(ZXRollView *)rollView didTapItemAtIndex:(NSInteger)index {
  
        NSLog(@"*** Tap the rollViewColor index %ld", index);
  
}



- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {2,2};
    
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithHex:0xaeaeae].CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 300, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"goodsdetailcell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    return cell;

}
#pragma mark - init tableview
- (UITableView *)goodsdetailtableview
{
    if (!_goodsdetailtableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.tableHeaderView=_headview;
        tableView.tableFooterView=_footview;
        [self.view addSubview:tableView];
        _goodsdetailtableview = tableView;
    }
    return _goodsdetailtableview;
}


-(UIView*)footview{
    if (!_footview) {
        _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    //        _footview.backgroundColor=[UIColor blueColor];
        [self settablefootview:_footview];
        
    }
    return _footview;
}

-(void)settablefootview:(UIView*)footview{
    self.automaticallyAdjustsScrollViewInsets = NO;
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)
                                                                        titles:@[@"全部商品",@"试衣间",@"DIY"]
                                                               viewControllers:@[[AllGoodsViewController new],
                                                                                 [TextRoomViewController new],
                                                                                 [DiyroomgoodsViewController new]
                                                                                 ]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:NO
                                                                  andHasTabbar:NO];
   
    titleCtl.titleScrollViewHeight = 30*(kScreen_Height/667);
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 2;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14];
    [self addChildViewController:titleCtl];
    [footview addSubview:titleCtl.view];
  
    
}


#pragma -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    if ([scrollView isKindOfClass:[_goodsdetailtableview class]]){
         NSLog(@" --== %f",scrollView.contentOffset.y);
        if (_goodsdetailtableview.contentOffset.y<0) {
            NSLog(@"不做操作");
        }
        if (_goodsdetailtableview.contentOffset.y>=Couponheigth) {
            _goodsdetailtableview.scrollEnabled=NO;
            CGPoint position = CGPointMake(0, Couponheigth);
            [_goodsdetailtableview setContentOffset:position animated:NO];
            [_notificationCenter postNotificationName:@"changescorllable"object:nil userInfo:nil];
        }
}
}
-(void)subscorllabled{
    NSLog(@"通知子视图");
    [_allnotificationCenter postNotificationName:@"allscorllable"object:nil userInfo:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.rollViewColor invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tablescorllable{
    _goodsdetailtableview.scrollEnabled=YES;
    [UIView animateWithDuration:0.8 animations:^{
        _goodsdetailtableview.contentOffset = CGPointMake(0, 0);

    }];
  
}

@end
