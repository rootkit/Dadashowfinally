//
//  AlreadyPayViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****  已付款未发货  ****/
#import "AlreadyPayViewController.h"
#import "GuessLikeCell.h"
#define  headheight 100*(kScreen_Height/667)
#define addressheight 82*(kScreen_Height/667)
#define goodsviewheght 225*(kScreen_Height/667)
#define ordercodeheight 130*(kScreen_Height/667)
#define likeviewheight 40*(kScreen_Height/667)

#define item_W 170 * kScreen_Width / 375
#define item_H 234 * kScreen_Width / 375

#define item_padding kScreen_Width-24-item_W*2
@interface AlreadyPayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)UIView* collectheadview;
@property (nonatomic, assign) CGFloat viewHeight;
@end

@implementation AlreadyPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewHeight = 0;
    self.view.backgroundColor=BackCellColor;
    self.navigationItem.title=@"订单详情";
    [self setordergoodsview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    statelabel.text = @"买家已付款";
    statelabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    statelabel.textColor = [UIColor whiteColor];
    [headview addSubview:statelabel];
    [statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(32*(kScreen_Height/667)));
        make.left.equalTo(@(36*(kScreen_Height/667)));
    }];
    
    UIImageView* reasonimageview=[[UIImageView alloc]init];
    reasonimageview.image=[UIImage imageNamed:@"ico_paid"];
    [headview addSubview:reasonimageview];
    [reasonimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0*(kScreen_Height/667)));
        make.width.equalTo(@(110*(kScreen_Height/667)));
        make.height.equalTo(@(100*(kScreen_Height/667)));
        make.right.equalTo(@(-45*(kScreen_Height/667)));
    }];
    
    
    /*物流信息提示**/
    UIView* logisticsview=[[UIView alloc]init];
    logisticsview.backgroundColor=[UIColor whiteColor];
    [collectheadview addSubview: logisticsview];
    [logisticsview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headview.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(60*(kScreen_Height/667)));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(entermyorder)];
    [logisticsview addGestureRecognizer:tap];
    _viewHeight=_viewHeight+60*(kScreen_Height/667);
    
    UIImageView* caricon=[[UIImageView alloc]init];
    caricon.image=[UIImage imageNamed:@"ico_Courier"];
    [logisticsview addSubview:caricon];
    [caricon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(17*(kScreen_Height/667)));
        make.top.equalTo(@(23*(kScreen_Height/667)));
    }];
    
    UILabel* definitelabel = [UILabel new];
    definitelabel.text = @"你的订单开始处理";
    definitelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    definitelabel.numberOfLines=3;
    definitelabel.textColor = [UIColor colorWithHex:0x5bc7cb];
    [logisticsview addSubview:definitelabel];
    [definitelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(caricon.mas_right).equalTo(@(10*(kScreen_Height/667)));
        make.width.equalTo(@(300*(kScreen_Height/667)));
    }];
    
    UILabel* timelabel = [UILabel new];
    timelabel.text = @"2017-05-05";
    timelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    timelabel.textColor = [UIColor colorWithHex:0xc5c3c3];
    [logisticsview addSubview:timelabel];
    [timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(definitelabel.mas_bottom).equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(definitelabel.mas_left);
        
    }];
    
    UIImageView* backimageview=[[UIImageView alloc]init];
    backimageview.image=[UIImage imageNamed:@"ico_arrows"];
    [logisticsview addSubview:backimageview];
    [backimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-13*(kScreen_Height/667)));
        make.top.equalTo(@(25*(kScreen_Height/667)));
    }];
    
    /*第二个分区 **/
    UIView* addressview=[[UIView alloc]init];
    addressview.backgroundColor=[UIColor whiteColor];
    [collectheadview addSubview: addressview];
    [addressview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logisticsview.mas_bottom).equalTo(@1);
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
    consigneelabel.text = @"收货人:小梁";
    consigneelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    consigneelabel.textColor = [UIColor colorWithHex:0x353535];
    [addressview addSubview:consigneelabel];
    [consigneelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(addressicon.mas_right).equalTo(@(13*(kScreen_Height/667)));
    }];
    
    UILabel*  phonelabel = [UILabel new];
    phonelabel.text = @"15118130757";
    phonelabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    phonelabel.textColor = [UIColor colorWithHex:0x353535];
    [addressview addSubview:phonelabel];
    [phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(consigneelabel.mas_bottom);
        make.right.equalTo(@(-12*(kScreen_Height/667)));
    }];
    
    UILabel*  receiveraddress = [UILabel new];
    receiveraddress.text = @"收货地址:广东省深圳市南山区粤海街道科兴科学园";
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
    shopnamelabel.text = @"乐町旗舰店";
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
    shopgoodsimage.image=[UIImage imageNamed:@"allgoods"];
    [goodsdetailview addSubview:shopgoodsimage];
    [shopgoodsimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopnameimageview.mas_bottom).equalTo(@(17*(kScreen_Height/667)));
        make.left.equalTo(shopnameimageview.mas_left);
        make.width.equalTo(@(70*(kScreen_Height/667)));
        make.height.equalTo(@(70*(kScreen_Height/667)));
        
    }];
    
    UILabel* travellinglabel = [UILabel new];
    travellinglabel.text = @"运费";
    travellinglabel.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
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
    //
    UILabel* describelabel = [UILabel new];
    describelabel.text = @"乐町2017夏季新款女装绿色短款刺绣宽松短袖T桖女夏韩版纯色上衣";
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
    priceslabel.text=@"$118.00";
    priceslabel.textColor=[UIColor colorWithHex:0x353535];
    [goodsdetailview addSubview:priceslabel];
    [priceslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describelabel.mas_top);
        make.right.equalTo(@(-13*(kScreen_Height/667)));
        
    }];
    //
    UILabel *historyprice= [[UILabel alloc] init];
    historyprice.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
    historyprice.text=@"$118.00";
    historyprice.textColor=[UIColor colorWithHex:0x949393];
    [goodsdetailview  addSubview:historyprice];
    [historyprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(describelabel.mas_bottom);
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
    colorlabel.text = @"颜色:橙色;";
    colorlabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    colorlabel.textColor = [UIColor colorWithHex:0x949393];
    [goodsdetailview addSubview:colorlabel];
    [colorlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describelabel.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(describelabel.mas_left);
    }];
    
    UILabel* sizelabel = [UILabel new];
    sizelabel.text = @"尺码:M;";
    sizelabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    sizelabel.textColor = [UIColor colorWithHex:0x949393];
    [goodsdetailview addSubview:sizelabel];
    [sizelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(describelabel.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(colorlabel.mas_right).equalTo(@(10*(kScreen_Height/667)));
    }];
    
    UILabel* numberlabel = [UILabel new];
    numberlabel.text = @"X1";
    numberlabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    numberlabel.textColor = [UIColor colorWithHex:0x949393];
    numberlabel.textAlignment=NSTextAlignmentRight;
    [goodsdetailview addSubview:numberlabel];
    [numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(colorlabel.mas_bottom);
        make.right.equalTo(priceslabel.mas_right);
    }];
    
    UILabel* arrivemoneylabel = [UILabel new];
    arrivemoneylabel.text = @"$0.00";
    arrivemoneylabel.font = [UIFont systemFontOfSize:11*(kScreen_Height/667)];
    arrivemoneylabel.textColor = [UIColor blackColor];
    [goodsdetailview addSubview:arrivemoneylabel];
    [arrivemoneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(travellinglabel.mas_top);
        make.right.equalTo(priceslabel.mas_right);
    }];
    //
    UILabel* allmoney = [UILabel new];
    allmoney .text = @"$65.00";
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
        make.top.equalTo(realitycostlabel.mas_bottom).equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
        
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
    ordernumber.text = @"订单编号:10647149711605820";
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
    createtimes.text = @"创建时间:2017-05-05 19:30:00";
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
    
    UIButton * warnbtn=[[UIButton alloc]init];
    warnbtn.titleLabel.font=[UIFont systemFontOfSize:13*(kScreen_Height/667)];
    [warnbtn setTitle:@"提醒发货"forState:UIControlStateNormal];
    [warnbtn setTitleColor:[UIColor colorWithHex:0x353535] forState:UIControlStateNormal];
    warnbtn.layer.cornerRadius = 4*(kScreen_Height/667);
    warnbtn.layer.borderWidth = 0.4;
    warnbtn.layer.borderColor = [UIColor colorWithHex:0x3e3e3e].CGColor;
    warnbtn.layer.masksToBounds=YES;
    [warnbtn addTarget:self action:@selector(clickwarn) forControlEvents:UIControlEventTouchUpInside];
    [extraview addSubview:warnbtn];
    [warnbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottleline.mas_bottom).equalTo(@(12*(kScreen_Height/667)));
        make.right.equalTo(@(-12*(kScreen_Height/667)));
        make.width.equalTo(@(80*(kScreen_Height/667)));
        make.height.equalTo(@(26*(kScreen_Height/667)));
    }];
    //
    
    
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
//设置头部视图 尾部视图的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//
//}


-(void)setorderdetailheadview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize=CGSizeMake(kScreen_Width,_viewHeight);//头部视图的尺寸
    layout.minimumInteritemSpacing = item_padding;
    layout.sectionInset = UIEdgeInsetsMake(6, 12, 6, 12);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreen_Width,kScreen_Height) collectionViewLayout:layout];
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
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GuessLikeCell *cell = [GuessLikeCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:GuessLikeItemIdentifier];
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - action

-(void)clickcontact{
    
    NSLog(@"联系买家");
    
}

-(void)clickcall{
    
    NSLog(@"拨打电话");
    
}

-(void)clickwarn{
    NSLog(@"提醒发货");
}

-(void)entermyorder{
    NSLog(@"我的订单开始处理");
}


@end
