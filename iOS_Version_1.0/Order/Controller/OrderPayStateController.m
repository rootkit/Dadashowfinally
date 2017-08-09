//
//  OrderPayStateController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 支付失败/成功 ****/
#import "OrderPayStateController.h"
#import "GoodsDetailViewController.h"
#import "GuessLikeCell.h"

#define rating kScreen_Width/375
#define item_W 170*rating
#define item_H 235*rating

#define like_footerView_height item_H*3+48+23

#define item_padding 10*rating

@interface OrderPayStateController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL payState;

@property (nonatomic, assign) float orderPrice;
@property (nonatomic, strong) DDXConsignee *consignee;
@property (nonatomic, strong) NSMutableArray <DDXLikeGoodsModel *> *likeGoods;

@end

@implementation OrderPayStateController

- (instancetype)initWithPayState:(BOOL)isSuccess withConsigNee:(DDXConsignee *)consignee withPrice:(float)price
{
    self = [super init];
    if (self) {
        _payState = isSuccess;
        self.orderPrice = price;
        self.consignee = consignee;
        
        _likeGoods = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _payState ? @"支付成功" : @"支付失败";
    
    self.view.backgroundColor = BackCellColor;
    [self setorderdetailheadview];
    [self fetchLikelist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 猜你喜欢data
- (void)fetchLikelist
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_likeList];
    
    [DaHttpTool get:strUrl
             params:@{}.mutableCopy
            success:^(id json) {
                //
                NSLog(@"success = %@", json);
                
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                NSDictionary *contentDic = json[@"content"];
                NSMutableArray *models = [NSMutableArray new];
                if (isSuccess) {
                    models = [NSArray osc_modelArrayWithClass:[DDXLikeGoodsModel class] json:json[@"content"][@"rows"]].mutableCopy;
                    
                    [self.likeGoods removeAllObjects];
                    [self.likeGoods addObjectsFromArray:models];
                } else {
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                    hud.mode = MBProgressHUDModeText;
                    hud.margin=10;
                    hud.labelFont=[UIFont boldSystemFontOfSize:13];
                    hud.detailsLabelText = contentDic[@"statusMsg"];
                    [hud hide:YES afterDelay:1.5];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.collectionView reloadData];
                });
            } failure:^(NSError *error) {
                //
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                hud.mode = MBProgressHUDModeText;
                hud.margin=10;
                hud.labelFont=[UIFont boldSystemFontOfSize:13];
                hud.detailsLabelText = @"网络出错啦！";//[NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                [hud hide:YES afterDelay:1.5];
            }];
}

#pragma mark - UICollectionDataSource

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headclotcell" forIndexPath:indexPath];
    [reusableView addSubview:self.headView];
    
    return reusableView;
}

-(void)setorderdetailheadview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize=CGSizeMake(kScreen_Width, 384*rating);//头部视图的尺寸
    layout.minimumInteritemSpacing = item_padding;
    layout.sectionInset = UIEdgeInsetsMake(0, 12*rating, 0, 12*rating);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreen_Width, kScreen_Height) collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headclotcell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[GuessLikeCell class] forCellWithReuseIdentifier:GuessLikeItemIdentifier];
}

#pragma mark  - <UICollectionViewDataSource>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.likeGoods.count > 6 ? 6 : (self.likeGoods.count > 0 ? self.likeGoods.count : 0));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuessLikeCell *item = [GuessLikeCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:GuessLikeItemIdentifier];
    
    if (self.likeGoods.count) {
        item.likeModel = self.likeGoods[indexPath.row];
    }
    
    return item;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DDXLikeGoodsModel *likeGoods = self.likeGoods[indexPath.row];
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] initWithGoodsSKU:likeGoods.sku goodsType:@"fs"];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - init
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 384*rating)];
        _headView.backgroundColor = BackCellColor;
        [self layoutCustomHeadView];
    }
    return _headView;
}

- (void)layoutCustomHeadView
{
    //
    UIView *stateview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100*rating)];
    UIImage* headbackimage=[UIImage imageNamed:@"背景底色"];
    stateview.layer.contents = (id)headbackimage.CGImage;
    [_headView addSubview:stateview];
    
    UILabel *statelabel = [UILabel new];
    statelabel.text = _payState ? @"买家已付款" : @"支付失败";
    statelabel.font = [UIFont systemFontOfSize:15*rating];
    statelabel.textColor = [UIColor whiteColor];
    [stateview addSubview:statelabel];
    [statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(32*rating));
        make.left.equalTo(@(40*rating));
    }];
    
    UILabel *reasonlabel = [UILabel new];
    reasonlabel.text = _payState ? @"你的包裹正整装待发" : @"查看订单再次支付";
    reasonlabel.font = [UIFont systemFontOfSize:11*rating];
    reasonlabel.textColor = [UIColor whiteColor];
    [stateview addSubview:reasonlabel];
    [reasonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statelabel.mas_bottom).equalTo(@(9*rating));
        make.left.equalTo(statelabel.mas_left);
    }];
    
    UIImageView *stateImg = [UIImageView new];
    stateImg.image = [UIImage imageNamed:(_payState ? @"ico_pay_succeed" : @"ico_pay_failure")];
    [stateview addSubview:stateImg];
    [stateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(stateview);
        make.right.equalTo(stateview.mas_right).with.offset(-48*rating);
        make.width.equalTo(@(110*rating));
        make.height.equalTo(@(100*rating));
    }];
    
    //
    UIView *locationView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stateview.frame), kScreen_Width, 80*rating)];
    locationView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:locationView];
    
    UIImageView *iconImg = [UIImageView new];
    iconImg.image = [UIImage imageNamed:@"location"];
    [locationView addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(8));
        make.centerY.equalTo(locationView);
        make.width.equalTo(@(23*rating));
        make.height.equalTo(@(23*rating));
    }];
    
    UIView *addressView = [UIView new];
    [locationView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(0);
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *buyerAddressTagLb = [UILabel new];
    buyerAddressTagLb.textColor = InfoTextColor;
    buyerAddressTagLb.text = @"收货地址：";
    buyerAddressTagLb.font = [UIFont systemFontOfSize:12*rating];
    [addressView addSubview:buyerAddressTagLb];
    [buyerAddressTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView.mas_left);
        make.centerY.equalTo(addressView);
        make.width.equalTo(@(64*rating));
    }];
    
    NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",
                            self.consignee.province.length ? self.consignee.province : @"",
                            self.consignee.city.length ? self.consignee.city : @"",
                            self.consignee.district.length ? self.consignee.district : @"",
                            self.consignee.address.length ? self.consignee.address : @""];
    
    UILabel *buyerAddressLb = [UILabel new];
    buyerAddressLb.textColor = InfoTextColor;
//    buyerAddressLb.text = @"广东省 深圳市 南山区 粤海街道 科兴科技园 A4栋 401";
    buyerAddressLb.text = addressStr;
    buyerAddressLb.font = [UIFont systemFontOfSize:12*rating];
    buyerAddressLb.numberOfLines = 2;
    buyerAddressLb.lineBreakMode = NSLineBreakByWordWrapping;
    [addressView addSubview:buyerAddressLb];
    [buyerAddressLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyerAddressTagLb.mas_right);
        make.top.equalTo(buyerAddressTagLb.mas_top);
        make.right.equalTo(addressView.mas_right).with.offset(-12*rating);
    }];
    
    
    UILabel *buyerPhomeNumLb = [UILabel new];
    buyerPhomeNumLb.textColor = InfoTextColor;
//    buyerPhomeNumLb.text = @"13211133122";
    buyerPhomeNumLb.text = self.consignee.mobile;
    buyerPhomeNumLb.textAlignment = NSTextAlignmentRight;
    buyerPhomeNumLb.font = [UIFont systemFontOfSize:14*rating];
    [addressView addSubview:buyerPhomeNumLb];
    [buyerPhomeNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(buyerAddressLb.mas_top).with.offset(-7*rating);
        make.right.equalTo(addressView.mas_right).with.offset(-12*rating);
    }];
    
    UILabel *buyerNameTagLb = [UILabel new];
    buyerNameTagLb.textColor = InfoTextColor;
    buyerNameTagLb.text = @"收货人  ：";
    buyerNameTagLb.font = [UIFont systemFontOfSize:12*rating];
    [addressView addSubview:buyerNameTagLb];
    [buyerNameTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressView.mas_left);
        make.centerY.equalTo(buyerPhomeNumLb);
        make.width.equalTo(@(64*rating));
        make.bottom.equalTo(buyerAddressTagLb.mas_top).with.offset(-7*rating);
    }];
    
    UILabel *buyerNameLb = [UILabel new];
    buyerNameLb.textColor = InfoTextColor;
//    buyerNameLb.text = @"全凯";
    buyerNameLb.text = self.consignee.consignee;
    buyerNameLb.font = [UIFont systemFontOfSize:12*rating];
    [addressView addSubview:buyerNameLb];
    [buyerNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyerNameTagLb.mas_right);
        make.centerY.equalTo(buyerPhomeNumLb);
        make.right.equalTo(buyerPhomeNumLb.mas_left).with.offset(-13*rating);
    }];
    
    //
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(locationView.frame)+10*rating, kScreen_Width, 110*rating)];
    infoView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:infoView];
    
    UILabel *payStateLabel = [UILabel new];
    payStateLabel.text = _payState ? @"实付款（含运费）" : @"待付款";
    payStateLabel.textColor = InfoTextColor;
    payStateLabel.font = [UIFont systemFontOfSize:12*rating];
    [infoView addSubview:payStateLabel];
    [payStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(@(10*rating));
    }];
    
    UILabel *payPriceLabel = [UILabel new];
//    payPriceLabel.text = @"¥65.00";
    payPriceLabel.text = [NSString stringWithFormat:@"¥%.2f", self.orderPrice];
    payPriceLabel.textColor = ThemeColor;
    payPriceLabel.font = [UIFont systemFontOfSize:12*rating];
    [infoView addSubview:payPriceLabel];
    [payPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12*rating));
        make.centerY.equalTo(payStateLabel);
    }];
    
    UILabel *topLine = [UILabel new];
    topLine.backgroundColor = BackCellColor;
    [infoView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(payStateLabel.mas_bottom).with.offset(10*rating);
        make.right.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *infoTagLabel = [UILabel new];
    infoTagLabel.text = @"安全提醒";
    infoTagLabel.textColor = InfoTextColor;
//    infoTagLabel.font = [UIFont systemFontOfSize:12*rating];
    infoTagLabel.font = [UIFont systemFontOfSize:12*rating weight:1.5];
    [infoView addSubview:infoTagLabel];
    [infoTagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(topLine.mas_bottom).with.offset(12*rating);
    }];
    
    UILabel *infoLabel = [UILabel new];
    infoLabel.text = @"付款成功后，搭搭秀不会以付款异常、卡单、系统升级为由联系您。请勿泄露银行卡号、手机验证码。否则会造成欠款损失、谨防电话诈骗！";
    infoLabel.textColor = ThemeColor;
    infoLabel.font = [UIFont systemFontOfSize:11*rating];
    infoLabel.numberOfLines = 0;
    infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [infoView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoTagLabel.mas_left);
        make.right.equalTo(infoTagLabel.mas_right);
        make.top.equalTo(infoTagLabel.mas_bottom).with.offset(7*rating);
    }];
    
    UILabel *bottomLine = [UILabel new];
    bottomLine.backgroundColor = BackCellColor;
    [infoView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(infoLabel.mas_bottom).with.offset(12*rating);
        make.right.equalTo(@(0));
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(@(0));
    }];
    
    //
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoView.frame), kScreen_Width, 44*rating)];
    btnView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:btnView];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = BackCellColor;
    [btnView addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(0.5));
        make.centerX.equalTo(btnView);
    }];
    
    UIButton *leftBtn = [UIButton new];
    [btnView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(clickWatchOrder) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.right.equalTo(hLine.mas_left);
    }];
    
    UIButton *rightBtn = [UIButton new];
    [btnView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clickBackToHome) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hLine.mas_right);
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
    
    //
    UIImageView *contactIcon = [UIImageView new];
    contactIcon.image = [UIImage imageNamed:@"ico_pay_indent"];
    [leftBtn addSubview:contactIcon];
    [contactIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftBtn);
        make.left.equalTo(@(57*rating));
        make.width.equalTo(@(15*rating));
        make.height.equalTo(@(15*rating));
    }];
    
    //
    UILabel* contactlabel = [UILabel new];
    contactlabel.text = @"查看订单";
    contactlabel.font = [UIFont systemFontOfSize:12*rating];
    contactlabel.textColor = InfoTextColor;
    [leftBtn addSubview:contactlabel];
    [contactlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftBtn);
        make.left.equalTo(contactIcon.mas_right).equalTo(@(7*rating));
    }];
    //////
    //
    UILabel* callphone = [UILabel new];
    callphone.text = @"返回首页";
    callphone.font = [UIFont systemFontOfSize:12*rating];
    callphone.textColor = InfoTextColor;
    [rightBtn addSubview:callphone];
    [callphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView);
        make.right.equalTo(@(-57*rating));
    }];
    //
    UIImageView *callphoneIcon = [UIImageView new];
    callphoneIcon.image = [UIImage imageNamed:@"ico_pay_home"];
    [rightBtn addSubview:callphoneIcon];
    [callphoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView);
        make.right.equalTo(callphone.mas_left).equalTo(@(-8*rating));
        make.width.equalTo(@(15*rating));
        make.height.equalTo(@(15*rating));
    }];
    
    ////
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btnView.frame), kScreen_Width, 40*rating)];
    bottomView.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    [_headView addSubview:bottomView];
    
    UILabel *label = [UILabel new];
    label.text = @"猜你喜欢";
    label.font = [UIFont systemFontOfSize:14*rating];
    label.textColor = FirstTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelWidth = 74*rating;
    label.frame = CGRectMake(CGRectGetMidX(bottomView.frame) - labelWidth/2, 11*rating, labelWidth, 26*rating);
    
    
    [bottomView addSubview:label];
    
    UIImageView *leftIMG = [UIImageView new];
    leftIMG.image = [UIImage imageNamed:@"bg_left"];
    leftIMG.frame = CGRectMake(CGRectGetMinX(label.frame) - 71*rating, 20*rating, 51*rating, 8*rating);
    [bottomView addSubview:leftIMG];
    
    UIImageView *rightIMG = [UIImageView new];
    rightIMG.image = [UIImage imageNamed:@"bg_right"];
    rightIMG.frame = CGRectMake(CGRectGetMaxX(label.frame) + 20*rating, 20*rating, 51*(kScreen_Height/667), 8*rating);
    [bottomView addSubview:rightIMG];
}

- (void)clickWatchOrder
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[OrderPayStateController class]]) {
            [self.navigationController.tabBarController setSelectedIndex:4];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
    }
}

- (void)clickBackToHome
{
    NSLog(@"返回首页");
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[OrderPayStateController class]]) {
            [self.navigationController.tabBarController setSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
    }
}

@end
