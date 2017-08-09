//
//  WaitPayViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****  等待付款  ****/
#import "WaitPayViewController.h"
#import "GoodsDetailViewController.h"

#import "GuessLikeCell.h"

#define headheight 100*(kScreen_Height/667)
#define addressheight 82*(kScreen_Height/667)
#define goodsviewheght 300*(kScreen_Height/667)
#define ordercodeheight 130*(kScreen_Height/667)
#define likeviewheight 40*(kScreen_Height/667)

#define rating kScreen_Width/375
#define item_W 170*rating
#define item_H 235*rating

#define item_padding 10*rating

@interface WaitPayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)UIView* collectheadview;
@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, strong) DDXGoodsOrderModel *model;
@property (nonatomic, strong) DDXShopCartGoods *shopGoods;
@property (nonatomic, strong) DDXConsignee *consignee;

@property (nonatomic, strong) NSMutableArray <DDXLikeGoodsModel *> *likeGoods;

@end

@implementation WaitPayViewController

- (instancetype)initWithOrderInfo:(DDXGoodsOrderModel *)goodsOrder withAddress:(DDXConsignee *)consignee
{
    self = [super init];
    if (self) {
        self.model = goodsOrder;
        self.shopGoods = [DDXShopCartGoods osc_modelWithDictionary:goodsOrder.items[0]];
        self.consignee = consignee;
        
        _likeGoods = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewHeight = 0;
    self.view.backgroundColor=BackCellColor;
    self.navigationItem.title = @"订单详情";
    [self setordergoodsview];
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

#pragma mark - layout

-(void)setordergoodsview{
    
    UIView* collectheadview=[[UIView alloc]init];
    collectheadview.backgroundColor=BackCellColor;
    //    collectheadview.frame=CGRectMake(0, 0, kScreen_Width,collectheadheght);
    //    [self.view addSubview:collectheadview];
    _collectheadview=collectheadview;
    
    /*第一个分区 **/
    UIView* headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, headheight)];
    UIImage* headbackimage=[UIImage imageNamed:@"背景底色"];
    headview.layer.contents = (id)headbackimage.CGImage;
    [collectheadview addSubview:headview];
    _viewHeight=_viewHeight+headheight;
    
    UILabel* statelabel = [UILabel new];
    statelabel.text = @"等待付款";
    statelabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    statelabel.textColor = [UIColor whiteColor];
    [headview addSubview:statelabel];
    [statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(32*(kScreen_Height/667)));
        make.left.equalTo(@(36*(kScreen_Height/667)));
    }];
    
    UILabel* reasonlabel = [UILabel new];
    reasonlabel.text = @"剩2天2小时自动关闭";
    reasonlabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    reasonlabel.textColor = [UIColor whiteColor];
    [headview addSubview:reasonlabel];
    [reasonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statelabel.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.left.equalTo(@(35*(kScreen_Height/667)));
    }];
    
    UIImageView* reasonimageview=[[UIImageView alloc]init];
    reasonimageview.image=[UIImage imageNamed:@"ico_payment"];
    [headview addSubview:reasonimageview];
    [reasonimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0*(kScreen_Height/667)));
        make.width.equalTo(@(92*(kScreen_Height/667)));
        make.height.equalTo(@(100*(kScreen_Height/667)));
        make.right.equalTo(@(-46*(kScreen_Height/667)));
    }];
    
    /*第二个分区 **/
    
    UIView* addressview=[[UIView alloc]init];
    addressview.backgroundColor=[UIColor whiteColor];
    [collectheadview addSubview: addressview];
    [addressview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headview.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(addressheight));
    }];
    _viewHeight=_viewHeight+addressheight;
    
    UIImageView* addressicon=[[UIImageView alloc]init];
    addressicon.image=[UIImage imageNamed:@"定位图标"];
    [addressview addSubview:addressicon];
    [addressicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(17*(kScreen_Height/667)));
        //        make.top.equalTo(@(32*(kScreen_Height/667)));
        //        make.bottom.equalTo(@(-32*(kScreen_Height/667)));
        make.width.equalTo(@(12*(kScreen_Height/667)));
        make.height.equalTo(@(16*(kScreen_Height/667)));
        make.centerY.equalTo(addressview);
    }];
    
    UILabel*  consigneelabel = [UILabel new];
    consigneelabel.text = [NSString stringWithFormat:@"收货人:%@", self.consignee.consignee];
    consigneelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    consigneelabel.textColor = [UIColor colorWithHex:0x353535];
    [addressview addSubview:consigneelabel];
    [consigneelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(addressicon.mas_right).equalTo(@(13*(kScreen_Height/667)));
    }];
    
    UILabel*  phonelabel = [UILabel new];
    phonelabel.text = self.consignee.mobile.length ? self.consignee.mobile : (self.consignee.tel.length ? self.consignee.tel : @"无联系号码");
    phonelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    phonelabel.textColor = [UIColor colorWithHex:0x353535];
    [addressview addSubview:phonelabel];
    [phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(consigneelabel.mas_bottom);
        make.right.equalTo(@(-12*(kScreen_Height/667)));
    }];
    
    NSString *addressStr = [NSString stringWithFormat:@"收货地址:%@ %@ %@ %@",
                            self.consignee.province.length ? self.consignee.province : @"",
                            self.consignee.city.length ? self.consignee.city : @"",
                            self.consignee.district.length ? self.consignee.district : @"",
                            self.consignee.address.length ? self.consignee.address : @""];
    
    UILabel*  receiveraddress = [UILabel new];
    receiveraddress.text = addressStr;
    receiveraddress.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    receiveraddress.textColor = [UIColor colorWithHex:0x353535];
    [addressview addSubview:receiveraddress];
    [receiveraddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(consigneelabel.mas_bottom).equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(consigneelabel.mas_left);
    }];
    
    
    /*第三个个分区 **/
    
    UIView* goodsdetailview=[[UIView alloc]init];
    goodsdetailview.backgroundColor=[UIColor whiteColor];
    [collectheadview addSubview:goodsdetailview];
    [goodsdetailview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(goodsviewheght));
        
    }];
    _viewHeight=_viewHeight+10*(kScreen_Height/667)+goodsviewheght;
    
    UIImageView* shopnameimageview=[[UIImageView alloc]init];
    shopnameimageview.image=[UIImage imageNamed:@"店铺图标"];
    [goodsdetailview addSubview:shopnameimageview];
    [shopnameimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(17*(kScreen_Height/667)));
        make.top.equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(13*(kScreen_Height/667)));
        make.height.equalTo(@(12*(kScreen_Height/667)));
        
    }];
    
    UILabel* shopnamelabel = [UILabel new];
    shopnamelabel.text = self.shopGoods.storeName;//@"乐町旗舰店";
    shopnamelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    shopnamelabel.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:shopnamelabel];
    [shopnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopnameimageview);
        make.left.equalTo(shopnameimageview.mas_right).equalTo(@(7*(kScreen_Height/667)));
    }];
    
    UIImageView* lastimageview=[[UIImageView alloc]init];
    lastimageview.image=[UIImage imageNamed:@"ico_arrows"];
    [goodsdetailview addSubview:lastimageview];
    [lastimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopnamelabel.mas_right).equalTo(@(5*(kScreen_Height/667)));
        make.top.equalTo(@(12*(kScreen_Height/667)));
        
        
    }];
    
    
    UIView* backview=[UIView new];
    backview.backgroundColor=[UIColor colorWithHex:0xf9f9f9];
    [goodsdetailview addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopnameimageview.mas_bottom).equalTo(@(12*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@(-0));
        make.height.equalTo(@(80*(kScreen_Height/667)));
    }];
    
    UIImageView* shopgoodsimage=[[UIImageView alloc]init];
    shopgoodsimage.backgroundColor = DefaultImgBgColor;
    [goodsdetailview addSubview:shopgoodsimage];
    [shopgoodsimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopnameimageview.mas_bottom).equalTo(@(17*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
        make.width.equalTo(@(70*(kScreen_Height/667)));
        make.height.equalTo(@(70*(kScreen_Height/667)));
        
    }];
    [shopgoodsimage loadPicture:[NSURL URLWithString:self.shopGoods.imageUrl]];
    
    UILabel* travellinglabel = [UILabel new];
    travellinglabel.text = @"运费";
    travellinglabel.font = [UIFont systemFontOfSize:13*(kScreen_Height/667)];
    travellinglabel.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:travellinglabel];
    [travellinglabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopgoodsimage.mas_bottom).equalTo(@(18*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
    }];
    
    UILabel* realitycostlabel = [UILabel new];
    realitycostlabel.text = @"实付款(含运费)";
    realitycostlabel.font = [UIFont systemFontOfSize:13*(kScreen_Height/667)];
    realitycostlabel.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:realitycostlabel];
    [realitycostlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(travellinglabel.mas_bottom).equalTo(@(6*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
    }];
    
    UILabel* arrivelinelabel=[[UILabel alloc]init];
    arrivelinelabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [goodsdetailview addSubview: arrivelinelabel];
    [arrivelinelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realitycostlabel.mas_bottom).equalTo(@(7*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        
    }];
    
    UILabel* extractlabel = [UILabel new];
    extractlabel.text = @"到店自提";
    extractlabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    extractlabel.textColor = [UIColor colorWithHex:0x323131];
    [goodsdetailview addSubview:extractlabel];
    [extractlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(arrivelinelabel.mas_bottom).equalTo(@(7*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
    }];
    
    UILabel* bottominelabel=[[UILabel alloc]init];
    bottominelabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [goodsdetailview addSubview: bottominelabel];
    [bottominelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(extractlabel.mas_bottom).equalTo(@(7*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        
    }];
    
    UILabel* shorenickname= [UILabel new];
    shorenickname.text = self.shopGoods.storeName;//@"cherrykoko 南山店";
    shorenickname.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    shorenickname.textColor = [UIColor colorWithHex:0x323131];
    [goodsdetailview addSubview:shorenickname];
    [shorenickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( bottominelabel.mas_bottom).equalTo(@(7*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
    }];
    
    UILabel* shoreaddress= [UILabel new];
    shoreaddress.text = [NSString stringWithFormat:@"店铺地址:%@", self.shopGoods.storeAddress.length ? self.shopGoods.storeAddress : @"无"];//@"店铺地址:广东省南山市南山区海岸城A栋401";
    shoreaddress.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    shoreaddress.textColor = [UIColor colorWithHex:0x949393];
    [goodsdetailview addSubview:shoreaddress];
    [shoreaddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shorenickname.mas_bottom).equalTo(@(7*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
    }];
    
    //
    UILabel* describelabel = [UILabel new];
    describelabel.text = self.shopGoods.itemName;//@"乐町2017夏季新款女装绿色短款刺绣宽松短袖T桖女夏韩版纯色上衣";
    describelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    describelabel.numberOfLines=2;
    describelabel.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:describelabel];
    [describelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopgoodsimage.mas_top);
        make.left.equalTo(shopgoodsimage.mas_right).equalTo(@(10*(kScreen_Height/667)));
        make.width.equalTo(@(190*(kScreen_Height/667)));
    }];
    //
    UILabel *priceslabel= [[UILabel alloc] init];
    priceslabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    priceslabel.text = [NSString stringWithFormat:@"¥%.2f", self.shopGoods.itemPriceNow];//@"$118.00";
    priceslabel.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:priceslabel];
    [priceslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describelabel.mas_top);
        make.right.equalTo(@(-13*(kScreen_Height/667)));
        
    }];
    //
    UILabel *historyprice= [[UILabel alloc] init];
    historyprice.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    historyprice.text = [NSString stringWithFormat:@"¥%.2f", self.shopGoods.itemPrice];//@"$118.00";
    historyprice.textColor=[UIColor colorWithHex:0x949393];
    [goodsdetailview  addSubview:historyprice];
    [historyprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceslabel.mas_bottom).with.offset(5*rating);
        make.right.equalTo(@(-13*(kScreen_Height/667)));
        
    }];
    UILabel* line=[UILabel new];
    line.backgroundColor=[UIColor colorWithHex:0xa8a8a8];
    [historyprice addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(8*(kScreen_Height/667)));
        make.left.equalTo(historyprice.mas_left);
        make.height.equalTo(@(0.5*(kScreen_Height/667)));
        make.right.equalTo(historyprice.mas_right);
        
    }];
    //
    UILabel* colorlabel = [UILabel new];
    colorlabel.text = [NSString stringWithFormat:@"颜色：%@；", self.shopGoods.itemColor.length ? self.shopGoods.itemColor : @"随机"];//@"颜色:橙色;";
    colorlabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    colorlabel.textColor = [UIColor colorWithHex:0x949393];
    [goodsdetailview addSubview:colorlabel];
    [colorlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describelabel.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(describelabel.mas_left);
    }];
    
    UILabel* sizelabel = [UILabel new];
    sizelabel.text = [NSString stringWithFormat:@"尺码：%@", self.shopGoods.itemSize.length ? self.shopGoods.itemSize : @"均码"];//@"尺码:M;";
    sizelabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    sizelabel.textColor = [UIColor colorWithHex:0x949393];
    [goodsdetailview addSubview:sizelabel];
    [sizelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describelabel.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(colorlabel.mas_right).equalTo(@(10*(kScreen_Height/667)));
    }];
    
    UILabel* numberlabel = [UILabel new];
    numberlabel.text = [NSString stringWithFormat:@"x%ld", (long)self.shopGoods.itemNum];//@"X1";
    numberlabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    numberlabel.textColor = [UIColor colorWithHex:0x949393];
    numberlabel.textAlignment=NSTextAlignmentRight;
    [goodsdetailview addSubview:numberlabel];
    [numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(historyprice.mas_bottom).with.offset(5*rating);
        make.right.equalTo(priceslabel.mas_right);
    }];
    
    UILabel* arrivemoneylabel = [UILabel new];
    arrivemoneylabel.text = @"¥0.00";
    arrivemoneylabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    arrivemoneylabel.textColor = [UIColor blackColor];
    [goodsdetailview addSubview:arrivemoneylabel];
    [arrivemoneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(travellinglabel.mas_top);
        make.right.equalTo(priceslabel.mas_right);
    }];
    //
    UILabel* allmoney = [UILabel new];
    allmoney .text = [NSString stringWithFormat:@"¥%.2f", self.shopGoods.itemPriceNow*self.shopGoods.itemNum];//@"¥65.00";
    allmoney .font = [UIFont systemFontOfSize:14*(kScreen_Height/667)];
    allmoney .textColor = [UIColor colorWithHex:0xfa458b];
    [goodsdetailview addSubview:allmoney];
    [allmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realitycostlabel.mas_top);
        make.right.equalTo(priceslabel.mas_right);
    }];
    //
    UILabel* linelabel=[[UILabel alloc]init];
    linelabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [goodsdetailview addSubview: linelabel];
    [linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realitycostlabel.mas_bottom).equalTo(@(85*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        
    }];
    
    UIImageView* backimageview=[[UIImageView alloc]init];
    backimageview.image=[UIImage imageNamed:@"ico_arrows"];
    [goodsdetailview addSubview:backimageview];
    [backimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(historyprice.mas_right);
        make.bottom.equalTo(linelabel.mas_top).equalTo(@(-15*(kScreen_Height/667)));
    }];
    
    UILabel* chooselabel = [UILabel new];
    chooselabel.text = @"已选择";
    chooselabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    chooselabel.textColor = [UIColor colorWithHex:0x666666];
    [goodsdetailview addSubview:chooselabel];
    [chooselabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backimageview.mas_left).equalTo(@(-5*(kScreen_Height/667)));
        make.bottom.equalTo(linelabel.mas_top).equalTo(@(-15*(kScreen_Height/667)));
    }];
    
    
    
    //
    UIButton * contactbtn=[[UIButton alloc]init];
    [contactbtn setBackgroundImage:[UIImage imageNamed:@"联系卖家图标"] forState:UIControlStateNormal];
    [contactbtn addTarget:self action:@selector(clickcontact) forControlEvents:UIControlEventTouchUpInside];
    [goodsdetailview addSubview:contactbtn];
    [contactbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.left.equalTo(@(55*(kScreen_Height/667)));
        make.width.equalTo(@(26*(kScreen_Height/667)));
        make.height.equalTo(@(26*(kScreen_Height/667)));
    }];
    //
    UILabel* contactlabel = [UILabel new];
    contactlabel.text = @"联系卖家";
    contactlabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    contactlabel.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:contactlabel];
    [contactlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.mas_bottom).equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(contactbtn.mas_right).equalTo(@(8*(kScreen_Height/667)));
    }];
    ////
    UILabel* centerline= [UILabel new];
    centerline.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [goodsdetailview addSubview:centerline];
    [centerline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.mas_bottom).equalTo(@0);
        make.left.equalTo(@(kScreen_Width/2-1));
        make.width.equalTo(@1);
        make.bottom.equalTo(@-0);
    }];
    
    
    
    //////
    //
    UILabel* callphone = [UILabel new];
    callphone.text = @"拨打电话";
    callphone.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    callphone.textColor = [UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:callphone];
    [callphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.mas_bottom).equalTo(@(15*(kScreen_Height/667)));
        make.right.equalTo(@(-55*(kScreen_Height/667)));
    }];
    //
    UIButton * callphonebtn=[[UIButton alloc]init];
    [callphonebtn setBackgroundImage:[UIImage imageNamed:@"拨打电话图标"] forState:UIControlStateNormal];
    [callphonebtn addTarget:self action:@selector(clickcall) forControlEvents:UIControlEventTouchUpInside];
    [goodsdetailview addSubview:callphonebtn];
    [callphonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(linelabel.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.right.equalTo(callphone.mas_left).equalTo(@(-8*(kScreen_Height/667)));
        make.width.equalTo(@(26*(kScreen_Height/667)));
        make.height.equalTo(@(26*(kScreen_Height/667)));
    }];
    //
    
    /**********/
    contactbtn.hidden = YES;
    contactlabel.hidden = YES;
    centerline.hidden = YES;
    callphone.hidden = YES;
    callphonebtn.hidden = YES;
    
    /*********/
    
    //    /*第四个个分区 **/
    UIView* extraview=[[UIView alloc]init];
    extraview.backgroundColor=[UIColor whiteColor];
    [collectheadview addSubview:extraview];
    [extraview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsdetailview.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(ordercodeheight));
    }];
    _viewHeight=_viewHeight+9*(kScreen_Height/667)+ordercodeheight;
    UILabel* ordernumber = [UILabel new];
    ordernumber.text = [NSString stringWithFormat:@"订单编号:%@", self.model.tradeOrderDate];//@"订单编号:10647149711605820";
    ordernumber.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    ordernumber.textColor = [UIColor colorWithHex:0x949393];
    [extraview addSubview:ordernumber];
    [ordernumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(@(13*(kScreen_Height/667)));
    }];
    
    UILabel* dealnumber = [UILabel new];
    dealnumber.text = @"搭搭交易号:10647149711605820";
    dealnumber.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    dealnumber.textColor = [UIColor colorWithHex:0x949393];
    [extraview addSubview:dealnumber];
    [dealnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ordernumber.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.left.equalTo(ordernumber.mas_left);
    }];
    
    UILabel* createtimes = [UILabel new];
    createtimes.text = @"创建时间:2017-07-01 19:30:00";
    createtimes.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    createtimes.textColor = [UIColor colorWithHex:0x949393];
    [extraview addSubview:createtimes];
    [createtimes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dealnumber.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.left.equalTo(ordernumber.mas_left);
    }];
    
    UILabel* bottleline= [UILabel new];
    bottleline.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [extraview addSubview:bottleline];
    [bottleline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(createtimes.mas_bottom).equalTo(@(9*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@1);
    }];
    
    UIButton * paybtn=[[UIButton alloc]init];
    paybtn.titleLabel.font=[UIFont systemFontOfSize:13*(kScreen_Height/667)];
    [paybtn setTitle:@"付款"forState:UIControlStateNormal];
    [paybtn setTitleColor:[UIColor colorWithHex:0xfc5c98] forState:UIControlStateNormal];
    paybtn.layer.cornerRadius = 4*(kScreen_Height/667);
    paybtn.layer.borderWidth = 0.4;
    paybtn.layer.borderColor = [UIColor colorWithHex:0xfc5c98].CGColor;
    paybtn.layer.masksToBounds=YES;
    [paybtn addTarget:self action:@selector(clickpay) forControlEvents:UIControlEventTouchUpInside];
    [extraview addSubview:paybtn];
    [paybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottleline.mas_bottom).equalTo(@(12*(kScreen_Height/667)));
        make.right.equalTo(@(-11*(kScreen_Height/667)));
        make.width.equalTo(@(80*(kScreen_Height/667)));
        make.height.equalTo(@(26*(kScreen_Height/667)));
    }];
    //
    UIButton * delegatebtn=[[UIButton alloc]init];
    delegatebtn.titleLabel.font=[UIFont systemFontOfSize:13*(kScreen_Height/667)];
    [delegatebtn setTitle:@"删除订单"forState:UIControlStateNormal];
    [delegatebtn setTitleColor:[UIColor colorWithHex:0x353535] forState:UIControlStateNormal];
    delegatebtn.layer.cornerRadius = 4*(kScreen_Height/667);
    delegatebtn.layer.borderWidth = 0.4;
    delegatebtn.layer.borderColor = [UIColor colorWithHex:0x333333].CGColor;
    delegatebtn.layer.masksToBounds=YES;
    [delegatebtn addTarget:self action:@selector(clickdeletadeorder) forControlEvents:UIControlEventTouchUpInside];
    [extraview addSubview:delegatebtn];
    [delegatebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottleline.mas_bottom).equalTo(@(12*(kScreen_Height/667)));
        make.right.equalTo(paybtn.mas_left).equalTo(@(-10*(kScreen_Height/667)));
        make.width.equalTo(@(80*(kScreen_Height/667)));
        make.height.equalTo(@(26*(kScreen_Height/667)));
    }];
    
    UIView* headsectionview=[[UIView alloc]init];
    headsectionview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [collectheadview addSubview:headsectionview];
    [headsectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(extraview.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@(likeviewheight));
    }];
    _viewHeight=_viewHeight+likeviewheight;
    [headsectionview addSubview:[self customGuessLikeHeaderView]];
    _collectheadview.frame=CGRectMake(0, 0, kScreen_Width,_viewHeight);
    NSLog(@"头部视图高度%f",_viewHeight);
    [self setorderdetailheadview];
}

- (UIView *)customGuessLikeHeaderView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40*(kScreen_Height/667))];
    bottomView.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    UILabel *label = [UILabel new];
    label.text = @"猜你喜欢";
    label.font = [UIFont systemFontOfSize:14*(kScreen_Height/667)];
    label.textColor = FirstTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelWidth = 74*(kScreen_Height/667);
    label.frame = CGRectMake(CGRectGetMidX(bottomView.frame) - labelWidth/2, 11, labelWidth, 26*(kScreen_Height/667));
    
    
    [bottomView addSubview:label];
    
    UIImageView *leftIMG = [UIImageView new];
    leftIMG.image = [UIImage imageNamed:@"bg_left"];
    leftIMG.frame = CGRectMake(CGRectGetMinX(label.frame) - 71*(kScreen_Height/667), 20*(kScreen_Height/667), 51*(kScreen_Height/667), 8*(kScreen_Height/667));
    [bottomView addSubview:leftIMG];
    
    UIImageView *rightIMG = [UIImageView new];
    rightIMG.image = [UIImage imageNamed:@"bg_right"];
    rightIMG.frame = CGRectMake(CGRectGetMaxX(label.frame) + 20*(kScreen_Height/667), 20*(kScreen_Height/667), 51*(kScreen_Height/667), 8*(kScreen_Height/667));
    [bottomView addSubview:rightIMG];
    
    return bottomView;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headclotcell" forIndexPath:indexPath];
    [reusableView addSubview:_collectheadview];
    return reusableView;
}


-(void)setorderdetailheadview{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize=CGSizeMake(kScreen_Width,_viewHeight);//头部视图的尺寸
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

#pragma mark <UICollectionViewDataSource>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.likeGoods.count > 6 ? 6 : (self.likeGoods.count > 0 ? self.likeGoods.count : 0));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuessLikeCell *cell = [GuessLikeCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:GuessLikeItemIdentifier];
    
    if (self.likeGoods.count) {
        cell.likeModel = self.likeGoods[indexPath.row];
    }
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DDXLikeGoodsModel *likeGoods = self.likeGoods[indexPath.row];
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] initWithGoodsSKU:likeGoods.sku goodsType:@"fs"];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - action

-(void)clickcontact{
    
    NSLog(@"联系买家");
    
}

-(void)clickcall{
    
    NSLog(@"拨打电话");
    
}
-(void)clickpay{
    NSLog(@"付款");
}

-(void)clickdeletadeorder{
    NSLog(@"删除订单");
}


@end
