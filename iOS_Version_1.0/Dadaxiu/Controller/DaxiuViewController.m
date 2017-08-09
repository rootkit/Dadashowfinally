//
//  DaxiuViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DaxiuViewController.h"

#import "UIColor+CustomColor.h"
#import "UIColorHF.h"
#import "UIImage+image.h"
#import "BannerModel.h"
#import "UIImageView+Dimage.h"

#import "OSCModelHandler.h"
#import "DDXHomeModel.h"
#import "DDXShopCartGoods.h"

#import "BrandsViewController.h"
#import "LocationViewController.h"
#import "MyopenshopsViewController.h"
#import "GoodReclassifyViewController.h"
#import "ShopClassifyViewController.h"
#import "GoodsWebsViewController.h"//test web
#import "GoodsShopListViewController.h" //店铺
#import "BannerSecondImgController.h"//首页banner二级界面

//tableview headview view
#import "XRCarouselView.h"
#import "KindClothesCollectionViewCell.h"
#import "BrandsView.h"
#import "FlashSaleView.h"
#import "FifthHeaderView.h"

//cell
#import "OptimazBrandCell.h"
#import "BrandsHeaderCell.h"
#import "AccessoryCell.h"
#import "HomeVedioCell.h"
#import "DPlayCell.h"
#import "SmallViewScrollVCell.h"
#import "AdvertisementCell.h"
#import "SmallViewScrollMusicCell.h"
#import "GuessLikeCCell.h"
#import "GuessLikeCell.h"

//cell Headview
#import "HomeModeDadaHeadView.h"
#import "HomeModeShopsHeadView.h"
#import "HomeModeOfficialHeadView.h"

//甄大牌和惠来购
#import "FamousbrandViewController.h"
#import "PrivilegeViewController.h"

//爆款女装
#import "GirlClothesViewController.h"
//商品详情
#import "GoodsDetailsViewController.h"
//滴搭秒
#import "LimitedGoodsViewController.h"
//门店地图定位
#import "DDXMapLocationViewController.h"

#import "AppDelegate.h"

#import "TimeGoodsViewController.h"
#import "FiveCommentViewController.h"
#import "NotificationMessageViewController.h"
#import "MessageListViewController.h"
#import "LogistListViewController.h"

#import "AdvertiseView.h"

#import <CoreLocation/CoreLocation.h>
#import "UIImageView+WebCache.h"
#import "ShopListViewController.h"
#import "GoodsShopListViewController.h"
#import "GoodsDetailViewController.h"


#define rating kScreen_Width/375

#define searchBar_W kScreen_Width
#define searchBar_H 25

//view
#define banner_H 165*rating
#define good_item_W 82*rating
#define good_item_H 85*rating
#define flash_sale_H 149*rating//149
#define fifth_H (251+15)*rating

//cell
#define optimazBrand_H 260*rating
#define accessory_H 333*rating
#define homeVedio_H 148*rating
#define DPlay_H (215*rating)+30*rating
#define scrollV_H (135*rating)+30*rating
#define advertise_H 140*rating
#define scrollVMusice_H 196*rating
//header view
#define Head_H 40*rating


#define footer_Height (235*3+20)*rating
#define footer_item_H 235*rating
#define footer_item_W 170*rating

//各个模块的编码
#define BrandCode @"sy010"
#define GirlanddoorCode @"SY020"
#define BrandchooseCode @"sy030"
#define CarcenterCode  @"SY040"
#define HotPeopleCode @"SY050"
//#define TammtangsCode @"sy100"
#define DplayCode @"sy070"
#define Wonderful @"sy060"
#define CGCoCode  @"SY080"
#define FashionCode @"SY090"
#define ELLYCode     @"SY100"
#define BraCode      @"SY110"
#define ShowCode      @"SY120"



@interface DaxiuViewController ()<UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate,
                                  UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate,
                                  XRCarouselViewDelegate, BrandsViewDelegate, FlashSaleViewDelegate, FifthHeaderViewDelegate,
                                  OptimazBrandCellDelegate, AccessoryCellDelegate, HomeVedioCellDelegate, DPlayCellDelegate, SmallViewScrollVCellDelegate, AdvertisementCellDelegate, SmallViewScrollMusicCellDelegate, GuessLikeCCellDelegate, BrandsHeaderCellDelegate, GuessLikeItemDelegate>

@property (nonatomic, weak) UIButton *locationButton;
@property (nonatomic, weak) UITableView *infoTableView;
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UISearchBar *customSearchBar;
@property (nonatomic, weak) UIButton *storeButton;
@property (nonatomic, weak) UIButton *messageButton;

@property (nonatomic,assign) NSUInteger imageindex;
@property (nonatomic,strong) UIView* headview;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property(nonatomic,strong)BrandsView *brandsView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) NSString *reLocationCityName;

@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, copy) NSString *strUrl;
@property (nonatomic, assign) NSInteger pageIndex;

@property(nonatomic,strong)UIBarButtonItem* leftloctionbtn;

@property (nonatomic, strong) NSMutableArray <DDXHomeModel *> *homeModes;

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *> *brannermodel;//首页滚动模块解析模型

@property(nonatomic,strong)NSMutableArray* allmutablearray;/**首页模块全部数组*/

@property(nonatomic,strong)NSMutableArray* brandallarray;/**首页第一个模块的总数据数组*/

@property(nonatomic,strong)NSMutableDictionary* plateIddic;/**首页各个编码对应的ID的字典*/

@property (nonatomic,strong) NSMutableArray* bannerimagearray;//首页第一个模块的图片数组

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* girldoormodel;//品牌街，爆款女装, 门店解析模型

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* brandchoosemodel;//品牌优选模型

@property (nonatomic,strong) NSMutableArray* brandchoosearray;//品牌优选的数组

@property (nonatomic, strong) NSMutableArray <GoodsFirstClassifyModel *> *goodsFirstClassifyModels;

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* cartiermodel;//Cartier 模型

@property(nonatomic,strong)NSMutableArray <DDXPlateModel *>* hotpeoplemodel;//人气新款模型

@property(nonatomic,strong)NSMutableArray <DDXPlateModel *>* tammtangsmodel;//TAMMTANGS模型

@property(nonatomic,strong)NSMutableArray <DDXPlateModel *>* dplaymodel;//DPLAY模型

@property(nonatomic,strong)NSMutableArray <DDXSortModel *>* sortmodel;//上衣，裤子，包包模型
@property(nonatomic,strong)NSMutableDictionary* sortddic;/**上衣，裤子，包包模型对应的ID的字典*/
@property (nonatomic,strong) NSMutableArray* sortarray;//上衣，裤子，包包模型对应的ID的数组

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* wonderfulmodel;//wonderfulurl解析模型

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* cgcomodel;//CGCoCode解析模型

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* fashionmodel;//FashionCode解析模型

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* ellymodel;//ELLYCode解析模型

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* bramodel;//BraCode解析模型

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* showmodel;//ShowCode解析模型

@property (strong, nonatomic)  UIView *likeView;
@property (nonatomic, strong) UICollectionView *likeCollectionView;
@property (nonatomic, strong) NSMutableArray <DDXLikeGoodsModel *> *likeGoods;

@end

@implementation DaxiuViewController
{
    NSArray *_sectionTitles;
    NSArray *_sectionTypes;
    NSArray *_sectionHeadViewTypes;
    NSArray *_sectionHeadViewImages;
    NSArray *_sectionUI;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHex:0x464545];
    // 初始化各个数组
    [self plateIddic];
    [self bannerimagearray];
    [self girldoormodel];
    [self brandchoosemodel];
    [self brandchoosearray];
    [self cartiermodel];
    [self hotpeoplemodel];
    [self tammtangsmodel];
    [self dplaymodel];
    [self sortmodel];
    [self sortddic];
    [self sortarray];
    [self wonderfulmodel];
    [self cgcomodel];
    [self fashionmodel];
    [self ellymodel];
    [self bramodel];
    [self showmodel];
    
    _strUrl = [NSString stringWithFormat:@"%@%@", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS];
    _pageIndex = 0;
    _homeModes = [NSMutableArray new];
    _brannermodel = [NSMutableArray new];
    _goodsFirstClassifyModels = [NSMutableArray new];
    _likeGoods = [NSMutableArray new];
  
    [self fetchLikelist]; //猜你喜欢
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self setcarouselView];
    [self customNavigationView];
    [self infoTableView];
    [self.infoTableView registerClass:[OptimazBrandCell class] forCellReuseIdentifier:OptimazBrandCellIdentifier];
    [self.infoTableView registerClass:[BrandsHeaderCell class] forCellReuseIdentifier:BrandsHeaderCellIdentifier];
    [self.infoTableView registerClass:[AccessoryCell class] forCellReuseIdentifier:AccessoryCellIdentifier];
    [self.infoTableView registerClass:[HomeVedioCell class] forCellReuseIdentifier:HomeVedioCellIdentifier];
    [self.infoTableView registerClass:[DPlayCell class] forCellReuseIdentifier:DPlayCellIdentifier];
    [self.infoTableView registerClass:[SmallViewScrollVCell class] forCellReuseIdentifier:SmallViewScrollVCellIdentifier];
    [self.infoTableView registerClass:[AdvertisementCell class] forCellReuseIdentifier:AdvertisementCellIdentifier];
    [self.infoTableView registerClass:[SmallViewScrollMusicCell class] forCellReuseIdentifier:SmallViewScrollMusicCellIdentifier];
    [self.infoTableView registerClass:[GuessLikeCCell class] forCellReuseIdentifier:GuessLikeCCellIdentifier];

    [self localtionCityAction];//暂时关闭定位
    /*
    _sectionTypes = @[@(HometypeForUpOneDownFour), @(HometypeForUpOneDownThree),// @(HometypeForDaDaVedio),
                      @(HometypeDPLAY), @(HometypeForLeftOneRightTwo),//, @(HometypeForDaDaFood)
                      @(HometypeForAdvertisement), @(HometypeTAMMYANGX), @(HometypeForAdvertisement),//, @(HometypeForDaDaVedio), @(HometypeForUpOneDownThree)
                      @(HometypeForLeftOneRightTwo), @(HometypeForUpOneDownThree),//, @(HometypeForDaDaMusic)
                      @(HometypeForLeftOneRightTwo), @(HometypeForAdvertisement),//, @(HometypeForUpOneDownThree)
                      @(HometypeForNone)];
    
    _sectionTitles = @[@"品牌.优选", @"Cartier",// @"搭搭影视",
                       @"D.PLAY", @"人气.新款",//, @"搭搭吃货"
                       @"", @"TAMMY TANGS", @"",//, @"搭搭旅游", @"搭搭娱乐"
                       @"美妆.推荐", @"品质.生活",//, @"搭搭音乐"
                       @"简易.家居", @"",//, @"搭搭男神"
                       @"猜你.喜欢"];
    _sectionHeadViewTypes = @[@(HomeModetypeForOfficial), @(HomeModetypeForShops),// @(HomeModetypeForDaDa),
                              @(HomeModetypeForShops), @(HomeModetypeForOfficial),//, @(HomeModetypeForDaDa)
                              @(HomeModetypeForNone), @(HomeModetypeForShops), @(HomeModetypeForNone),//, @(HomeModetypeForDaDa), @(HomeModetypeForDaDa)
                              @(HomeModetypeForOfficial), @(HomeModetypeForOfficial),//, @(HomeModetypeForDaDa)
                              @(HomeModetypeForOfficial), @(HomeModetypeForNone),//, @(HomeModetypeForDaDa)
                              @(HomeModetypeForOfficial)];
    _sectionHeadViewImages = @[@" ", @" ",// @"icon_dadamovie_Home",
                               @" ", @" ",//, @"icon_dadaeat_Home"
                               @" ", @" ", @" ",//, @"ico_dadatravel_Home", @"icon_dada-recreation_Home"
                               @" ", @" ",//, @"icon_dadamusic_Home"
                               @" ", @" ",//, @"icon_dadaman_Home"
                               @" "];
    */
    
    _sectionTypes = @[@(HometypeForUpOneDownFour), @(HometypeBigBrands), @(HometypeForUpOneDownThree),
                     @(HometypeForLeftOneRightTwo), @(HometypeForAdvertisement), @(HometypeForLeftOneRightTwo),
                     @(HometypeForUpOneDownThree), @(HometypeForAdvertisement), @(HometypeForUpOneDownThree),
                     @(HometypeForLeftOneRightTwo), @(HometypeForAdvertisement), @(HometypeForUpOneDownThree),
                     @(HometypeForLeftOneRightTwo), @(HometypeForAdvertisement), @(HometypeForUpOneDownThree),
                     @(HometypeForNone)];
    _sectionUI = @[
                   @(0), @(0), @(HometypeForUpOneDownThreeSortOne),
                   @(HometypeForLeftOneRightTwoSortOne), @(HometypeForAdvertisementSortOne), @(HometypeForLeftOneRightTwoSortTwo),
                   @(HometypeForUpOneDownThreeSortTwo), @(HometypeForAdvertisementSortTwo), @(HometypeForUpOneDownThreeSortThree),
                   @(HometypeForLeftOneRightTwoSortThree), @(HometypeForAdvertisementSortThree), @(HometypeForUpOneDownThreeSortFour),
                   @(HometypeForLeftOneRightTwoSortFour), @(HometypeForAdvertisementSortFour), @(HometypeForUpOneDownThreeSortFive),
                   @(0)
                   ];//区别同一种ui不同数据
    
    _sectionTitles = @[@"品牌·优选", @"", @"茜诗迪品牌旗舰店",
                       @"香港慕之淇品牌旗舰店", @"", @"Wonderful品牌旗舰店",
                       @"hurst品牌旗舰店", @"", @"COCO旗舰店",
                       @"Fashiom旗舰店", @"", @"Elly旗舰店",
                       @"潮Bra旗舰店", @"", @"Show包旗舰店",
                       @"猜你·喜欢"];
    
    _sectionHeadViewTypes = @[@(HomeModetypeForOfficial), @(HomeModetypeForNone), @(HomeModetypeForShops),
                              @(HomeModetypeForShops), @(HomeModetypeForNone), @(HomeModetypeForShops),
                              @(HomeModetypeForShops), @(HomeModetypeForNone), @(HomeModetypeForShops),
                              @(HomeModetypeForShops), @(HomeModetypeForNone), @(HomeModetypeForShops),
                              @(HomeModetypeForShops), @(HomeModetypeForNone), @(HomeModetypeForShops),
                              @(HomeModetypeForOfficial)];
    
    _sectionHeadViewImages = @[@"", @"", @"",
                               @"", @"", @"",
                               @"", @"", @"",
                               @"", @"", @"",
                               @"", @"", @"",
                               @""];
    
    __weak typeof(self) weakSelf = self;
    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    myAppDelegate.clickblock=^(NSInteger index){
        if (index==2) {
            NSLog(@"猜你喜欢");
//            [weakSelf.infoTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
            [weakSelf.infoTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_sectionTypes.count-2]  atScrollPosition:UITableViewScrollPositionTop animated:NO];//这边要设置成NO
            } else {
            NSLog(@"顶部");
            CGPoint position = CGPointMake(0, -64);
            [weakSelf.infoTableView setContentOffset:position animated:YES];
        }
    };
    //* //获取数据
    [self fetchData];
    [self getsorthttpload];
    //*/
    [self setrightbtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.searchController.active) {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init button

-(void)setrightbtn{
    
    UIButton* rightfirstbtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightfirstbtn setBackgroundImage:[UIImage imageNamed:@"bubble"] forState:UIControlStateNormal];
    [rightfirstbtn setTarget:self action:@selector(talksendmessage) forControlEvents:UIControlEventTouchUpInside];
    rightfirstbtn.frame= CGRectMake(0, 0, 23*(kScreen_Height/667),23*(kScreen_Height/667));
    UIBarButtonItem *rightmessagebtn = [[UIBarButtonItem alloc] initWithCustomView: rightfirstbtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    UIButton* rightsecondebtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [rightsecondebtn setBackgroundImage:[UIImage imageNamed:@"shop"] forState:UIControlStateNormal];
    [rightsecondebtn setTarget:self action:@selector(goingtoshop) forControlEvents:UIControlEventTouchUpInside];
    rightsecondebtn.frame= CGRectMake(0, 0, 23*(kScreen_Height/667), 23*(kScreen_Height/667));
    
    
    UIBarButtonItem *rightshopbtn= [[UIBarButtonItem alloc] initWithCustomView:rightsecondebtn];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightmessagebtn,rightshopbtn,nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"深圳市" style:UIBarButtonItemStylePlain target:self action:@selector(locatingAction)];
    
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14] , NSFontAttributeName, nil] forState:UIControlStateNormal];
    _leftloctionbtn=self.navigationItem.leftBarButtonItem;
   
    
}

#pragma mark - fetch data

-(void)getsorthttpload{
    
    NSString* categorystr=[NSString stringWithFormat:@"%@%@", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_Sort];
    [DaHttpTool get:categorystr
             params:nil
            success:^(id json) {
                if ( [json isKindOfClass:[NSDictionary class]]) {
                    if ([json[@"state"] isEqualToString:@"success"]) {
                        NSArray *contents = json[@"content"];
                        self.sortmodel=[[NSArray osc_modelArrayWithClass:[DDXSortModel class] json:contents] mutableCopy];
                        NSLog(@"分类modle%@",self.sortmodel);
                        [self.sortarray addObjectsFromArray:self.sortmodel];
                        [self.sortarray enumerateObjectsUsingBlock:^(DDXSortModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            
                            [self.sortddic setObject:[NSString stringWithFormat:@"%d",obj.id] forKey:obj.categoryName];
                            NSLog(@"分类字典 %@",self.sortddic);
                        }];
                    }else{
                        NSLog(@"请求错误");
                    }
                }
            } failure:^(NSError *error) {
            }];
    
}

- (void)fetchData
{
    [DaHttpTool get:_strUrl
             params:nil
            success:^(id json) {
            if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                 NSArray *contents = json[@"content"];
                  NSLog(@"%@",contents);
                 _homeModes = [[NSArray osc_modelArrayWithClass:[DDXHomeModel class] json:contents] mutableCopy];
                 [self.allmutablearray addObjectsFromArray: _homeModes];
                 [self.allmutablearray enumerateObjectsUsingBlock:^(DDXHomeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                     [weakSelf fetchDataForPlateId:obj.id pageIndex:1 platecodes:obj.plateCode];
                     [self.plateIddic setObject:[NSString stringWithFormat:@"%d",obj.id] forKey:obj.plateCode];
                 }];
                NSLog(@"字典%@",self.plateIddic);
                [self fetchDataSubview];
        
                }else{
                 NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
 }];
}

-(void)fetchDataSubview{
    
//branner模块
  
   _strUrl = [NSString stringWithFormat:@"%@%@/%d/1", _strUrl, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:BrandCode] intValue]];
    NSLog(@"Banner");
    [DaHttpTool get:_strUrl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                _brannermodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                [self.brandallarray addObjectsFromArray:_brannermodel];
                NSLog(@"%@",self.brandallarray);
                [self.brandallarray enumerateObjectsUsingBlock:^(DDXPlateModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.bannerimagearray addObject:obj.imageUrl];
                    self.carouselView.imageArray =  self.bannerimagearray;
                }];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];

//品牌街模块
    NSString* girlanddoorurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:GirlanddoorCode] intValue]];
    NSLog(@"%@",girlanddoorurl);
    [DaHttpTool get:girlanddoorurl params:nil success:^(id json) {
            NSLog(@"json=%@",json);
     if ( [json isKindOfClass:[NSDictionary class]]) {
            if([json[@"state"] isEqualToString:@"success"]){
                    NSArray *contents = json[@"content"][@"rows"];
          _girldoormodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                [Tammytangs sharedTcount].tammycount=self.girldoormodel.count;
          [self refreshbrandview];
            }
        else{
            NSLog(@"请求错误");
            }
        }
        } failure:^(NSError *error) {
                NSLog(@"%@", error);
        }];

//品牌优选
    NSString* brandchooseurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:BrandchooseCode] intValue]];
            [DaHttpTool get:brandchooseurl params:nil success:^(id json) {
                NSLog(@"json=%@",json);
                if ( [json isKindOfClass:[NSDictionary class]]) {
    
                    if ([json[@"state"] isEqualToString:@"success"]) {
    
                        NSArray *contents = json[@"content"][@"rows"];
                        self.brandchoosemodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                        [self.brandchoosearray addObjectsFromArray:self.brandchoosemodel];
                        NSLog(@"品牌优选数组%@",self.brandchoosearray);
                        [self.infoTableView reloadData];
                        
                        
                    }
                    else{
                        NSLog(@"请求错误");
                    }
                }
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
         }];

 //Cartier
 NSString* carcenterurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:CarcenterCode] intValue]];
            [DaHttpTool get:carcenterurl params:nil success:^(id json) {
                NSLog(@"json=%@",json);
                if ( [json isKindOfClass:[NSDictionary class]]) {
                    if ([json[@"state"] isEqualToString:@"success"]) {
                        NSArray *contents = json[@"content"][@"rows"];
                        _cartiermodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                         [Carcenter sharedCount].carcentercount=self.cartiermodel.count;
                         [self.infoTableView reloadData];
    
                    }
                    else{
                        NSLog(@"请求错误");
                    }
                }
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
    
//人气新款
    NSString* hotpeopleurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:HotPeopleCode] intValue]];
    [DaHttpTool get:hotpeopleurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                self.hotpeoplemodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                 [self.infoTableView reloadData];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
//wonderful
    
    NSString* wonderfulurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:Wonderful] intValue]];
    [DaHttpTool get:wonderfulurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
               self.wonderfulmodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                 [self.infoTableView reloadData];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    //ELLY
//    NSString* tammtangsurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:TammtangsCode] intValue]];
//    [DaHttpTool get:tammtangsurl params:nil success:^(id json) {
//        NSLog(@"json=%@",json);
//        if ( [json isKindOfClass:[NSDictionary class]]) {
//            if ([json[@"state"] isEqualToString:@"success"]) {
//                NSArray *contents = json[@"content"][@"rows"];
//               self.tammtangsmodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
//             
//                [Tammytangs sharedTcount].tammycount=self.tammtangsmodel.count;
//            }
//            else{
//                NSLog(@"请求错误");
//            }
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
  //D-PLAY
    NSString* dplayurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:DplayCode] intValue]];
    [DaHttpTool get:dplayurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                _dplaymodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                [self.infoTableView reloadData];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
// CGCoCode
    NSString* cgcourl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:CGCoCode] intValue]];
    [DaHttpTool get:cgcourl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
               _cgcomodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                 [self.infoTableView reloadData];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
 // FashionCode
    NSString* fashionurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:FashionCode] intValue]];
    [DaHttpTool get:fashionurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                _fashionmodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                 [self.infoTableView reloadData];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
   // ELLYCode
    NSString* ellyurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:ELLYCode] intValue]];
    [DaHttpTool get:ellyurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                _ellymodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                 [self.infoTableView reloadData];
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    //BraCode
    NSString* brayurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:BraCode] intValue]];
    [DaHttpTool get:brayurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                _bramodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    //ShowCode
    NSString* showurl= [NSString stringWithFormat:@"%@%@%@/%d/1", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_SHOPMMS_MMS, DDXAPI_SHOPMMS_MMS_PLATEDETAIL, [[_plateIddic objectForKey:ShowCode] intValue]];
    [DaHttpTool get:showurl params:nil success:^(id json) {
        NSLog(@"json=%@",json);
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                NSArray *contents = json[@"content"][@"rows"];
                _showmodel=[[NSArray osc_modelArrayWithClass:[DDXPlateModel class] json:contents] mutableCopy];
                
            }
            else{
                NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)refreshbrandview{
    switch (_girldoormodel.count) {
        case 0:
            break;
        case 1:{
        [_brandsView.brandsIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        }
            break;
        case 2:{
        [_brandsView.brandsIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        [_brandsView.hotIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        }
            break;
        case 3:{
        [_brandsView.brandsIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        [_brandsView.hotIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        [_brandsView.privateIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[2].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        }
            break;
        case 4:{
        [_brandsView.brandsIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[0].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        [_brandsView.hotIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[1].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        [_brandsView.privateIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[2].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        [_brandsView.shopsIMG  sd_setImageWithURL:[NSURL URLWithString:_girldoormodel[3].imageUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        }
            break;
            
        default:
            break;
    }
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
                    
                    [self.likeCollectionView reloadData];
                });
            } failure:^(NSError *error) {
                //
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                hud.mode = MBProgressHUDModeText;
                hud.margin=10;
                hud.labelFont=[UIFont boldSystemFontOfSize:13];
                hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                [hud hide:YES afterDelay:1.5];
            }];
}

#pragma mark - custom searchbar

- (void)customNavigationView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, searchBar_W, searchBar_H)];//allocate titleView
//    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    _customSearchBar = [[UISearchBar alloc] init];
//    _customSearchBar.frame = CGRectMake(0, 0, titleView.width, searchBar_H);
    _customSearchBar.backgroundColor = [UIColor clearColor];
    _customSearchBar.layer.masksToBounds = YES;
    [_customSearchBar handleCornerRadiusWithRadius:5];
    [_customSearchBar handleBoardWidth:0 andBorderColor:[UIColor whiteColor]];
    UITextField *searchField = [_customSearchBar valueForKey:@"searchField"];
    if (searchField) {
        searchField.backgroundColor = BackCellColor;
        searchField.clipsToBounds = YES;
        searchField.font=[UIFont systemFontOfSize:12*kScreen_Height/667];
        [searchField handleCornerRadiusWithRadius:5];
    
        [searchField handleBoardWidth:0 andBorderColor:[UIColor whiteColor]];
    }
    [searchField resignFirstResponder];
     _customSearchBar.delegate = self;
    _customSearchBar.placeholder = @"连衣裙";
    [titleView addSubview:_customSearchBar];
    [_customSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@(searchBar_H));
        make.right.equalTo(@-0);
    }];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}




- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
   
    NSLog(@"开始搜索");
    ShopListViewController * shopvc = [ShopListViewController new];
      shopvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopvc animated:YES];
  
   return  NO;
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.navigationController.navigationBarHidden=NO;
//    self.tabBarController.tabBar.hidden=NO;
//    [self.homeserachview removeFromSuperview];
//}


#pragma mark - banner layout

-(void)setcarouselView {
    
    UIView *headview = [UIView new];//顶部头view
    _viewHeight = 0;
    
    NSArray* arr = @[[UIImage imageNamed:@"敢秀_首页banner"],[UIImage imageNamed:@"女神注册_首页banner"],[UIImage imageNamed:@"千万流量_首页banner"]];
    /**
     *  通过代码创建      */
    self.carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, _viewHeight, kScreen_Width, banner_H)];
    _viewHeight = banner_H;
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageWithColor:DefaultImgBgColor];
    
    //设置图片数组及图片描述文字
    _carouselView.imageArray = arr;
    //    _carouselView.describeArray = describeArray;
    
    //用代理处理图片点击
    _carouselView.delegate = self;
    
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _carouselView.time = 3;
    
    
    //设置分页控件的图片,不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
       _carouselView.pagePosition = PositionBottomCenter;
    
    /**
     *  修改图片描述控件的外观，不需要修改的传nil
     *
     *  参数一 字体颜色，默认为白色
     *  参数二 字体，默认为13号字体
     *  参数三 背景颜色，默认为黑色半透明
     */
    UIColor *bgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    UIFont *font = [UIFont systemFontOfSize:15];
    UIColor *textColor = [UIColor greenColor];
    [_carouselView setDescribeTextColor:textColor font:font bgColor:bgColor];
    self.view.backgroundColor=[UIColor whiteColor];
    [headview addSubview:_carouselView]; //banner
    
    //二 商品一级分类
    [self initForCollectView];
    [headview addSubview:_collectionView]; //goodsReclassify
    
    //三 品牌街，爆款女装等
    BrandsView *brandsView = [[BrandsView alloc] initWithFrame:CGRectMake(0, _viewHeight, kScreen_Width, 199*rating)];
    _viewHeight += 199*rating;
    brandsView.delegate = self;
    [headview addSubview:brandsView]; //brandsView
    _brandsView=brandsView;
    
    //四 滴搭秒
    /*
//    FlashSaleView *flashSaleView = [[FlashSaleView alloc] initWithFrame:CGRectMake(0, _viewHeight, kScreen_Width, flash_sale_H)];
    UIView *flashSaleView = [[UIView alloc] initWithFrame:CGRectMake(0, _viewHeight, kScreen_Width, flash_sale_H)];
    _viewHeight += flash_sale_H;
    flashSaleView.backgroundColor = [UIColor whiteColor];
//    flashSaleView.delegate = self;
    [headview addSubview:flashSaleView];
    */
    //五 甄大牌，惠来购
    /*
    FifthHeaderView *fifthHeadeView = [[FifthHeaderView alloc] initWithFrame:CGRectMake(0, _viewHeight, kScreen_Width, fifth_H)];
//    _viewHeight += fifth_H;
    fifthHeadeView.backgroundColor = [UIColor whiteColor];
//    fifthHeadeView.delegate = self;
    [headview addSubview:fifthHeadeView];
    */
    /*********/
    headview.frame = CGRectMake(0, 0, kScreen_Width, _viewHeight);
    _headview = headview;
}

#pragma mark - init collectionview
/** 商品一级分类滚动 **/
- (void)initForCollectView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, _viewHeight , kScreen_Width , good_item_H) collectionViewLayout:flowLayout];
    _viewHeight += good_item_H;
    collectionView.showsHorizontalScrollIndicator=NO;//隐藏滚动条
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    //注册Cell，必须要有
    [collectionView registerClass:[KindClothesCollectionViewCell class] forCellWithReuseIdentifier:KindClothesCollectionViewCellIdentifier];
    _collectionView = collectionView;
    
    //获取plist文件内容
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"goodsFirstClassify" ofType:@"plist"];
    NSMutableArray *data1 = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    [data1 enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        GoodsFirstClassifyModel *model = [GoodsFirstClassifyModel new];
        model.title = [dic valueForKey:@"title"];
        model.icon = [dic valueForKey:@"icon"];
        model.dicArray = [dic valueForKey:@"secondClassify"];
        model.goodsId=[dic valueForKey:@"id"];
        
        [_goodsFirstClassifyModels addObject:model];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionTypes.count;//1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {//

    if (section == _sectionTypes.count-1) {
        return 0;
    } else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"分区类型%ld",(long)[_sectionTypes[indexPath.section] integerValue]);
    UITableViewCell *cell = [self distributionHomeListCurrentCellWithItem:[_sectionTypes[indexPath.section] integerValue] toTableView:self.infoTableView indexPaht:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self distributionHomeListCurrentCellHeigthWithItem:[_sectionTypes[indexPath.section] integerValue] toTableView:self.infoTableView indexPaht:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch ([_sectionHeadViewTypes[section] integerValue]) {
        case HomeModetypeForOfficial:
        {
            HomeModeOfficialHeadView *officView = [[HomeModeOfficialHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Head_H+10*rating)];
            officView.title = _sectionTitles[section];
            return officView;
            break;
        }
//        case HomeModetypeForDaDa:
//        {
//            HomeModeDadaHeadView *dadaView = [[HomeModeDadaHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Head_H+10)];
//            dadaView.title = _sectionTitles[section];
//            dadaView.iconName = _sectionHeadViewImages[section];
//            return dadaView;
//            break;
//        }
        case HomeModetypeForShops:
        {
            HomeModeShopsHeadView *shopsView = [[HomeModeShopsHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, Head_H+10*rating)];
            shopsView.title = _sectionTitles[section];
            return shopsView;
            break;
        }
        default:
        {
            UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10*rating)];
            headV.backgroundColor = BackCellColor;
            return headV;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch ([_sectionHeadViewTypes[section] integerValue]) {
        case HomeModetypeForOfficial:
//        case HomeModetypeForDaDa:
        case HomeModetypeForShops:
            return Head_H+10;
        default:
            return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

#pragma mark - currentCellWithType
- (__kindof UITableViewCell* )distributionHomeListCurrentCellWithItem:(Hometype)homeType
                                                          toTableView:(UITableView* )tableView
                                                            indexPaht:(NSIndexPath* )indexPath
{
    switch (homeType) {
        case HometypeForUpOneDownFour:
        {
             NSLog(@"%@",[Brandsselectarray sharedArray].brandselectarray);
           
             [Brandsselectarray sharedArray].brandselectarray = self.brandchoosearray;
            OptimazBrandCell *cell = [OptimazBrandCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:OptimazBrandCellIdentifier];
            
            cell.delegate = self;
            return cell;
            break;
        }
        case HometypeForUpOneDownThree:
        {
         
            AccessoryCell *cell = [AccessoryCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:AccessoryCellIdentifier];
            NSInteger index = [_sectionUI[indexPath.section] integerValue];
            if (index==0) {
                cell.cartiermodel=_cartiermodel;
            }else if (index==1){
                cell.cartiermodel=_dplaymodel;
            }else if(index==2){
                cell.cartiermodel=_cgcomodel;
            }else if(index==3){
                cell.cartiermodel=_ellymodel;
            }else if(index==4){
                cell.cartiermodel=_showmodel;
            }else{
                cell.cartiermodel=_showmodel;
            }
            cell.tag=index;
            cell.delegate = self;
            return cell;
            break;
        }
        case HometypeForLeftOneRightTwo:
        {
            DPlayCell *cell = [DPlayCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:DPlayCellIdentifier];
            NSInteger index = [_sectionUI[indexPath.section] integerValue];
            if (index==0) {
                cell.hotpeoplemodel=_hotpeoplemodel;
            }else if (index==1){
                cell.hotpeoplemodel=_wonderfulmodel;
            }else if(index==2){
                cell.hotpeoplemodel=_fashionmodel;
            }else if(index==3){
                cell.hotpeoplemodel=_bramodel;
            }else{
                cell.hotpeoplemodel=_bramodel;
            }
            cell.tag=index;
            cell.delegate = self;
          
           
            return cell;
            break;
        }
//        case HometypeForDaDaVedio:
//        {
//            HomeVedioCell *cell = [HomeVedioCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:HomeVedioCellIdentifier];
//            
//            cell.delegate = self;
//            
//            return cell;
//            break;
//        }
//        case HometypeForDaDaFood:
//        {
//            SmallViewScrollVCell *cell = [SmallViewScrollVCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:SmallViewScrollVCellIdentifier];
//            
//            cell.delegate = self;
//            
//            return cell;
//            break;
//        }
//        case HometypeForDaDaMusic:
//        {
//            SmallViewScrollMusicCell *cell = [SmallViewScrollMusicCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:SmallViewScrollMusicCellIdentifier];
//            
//            cell.delegate = self;
//            
//            return cell;
//            break;
//        }
        case HometypeForAdvertisement:
        {
            AdvertisementCell *cell = [AdvertisementCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:AdvertisementCellIdentifier];
            
            cell.delegate = self;
            NSInteger index = [_sectionUI[indexPath.section] integerValue];
            cell.advertisementImage = [UIImage imageNamed:@[@"advertisement_01", @"advertisement_02", @"advertisement_03", @"advertisement_04"][index]];
            
            return cell;
            break;
        }
        case HometypeForNone:{
//            GuessLikeCCell *cell = [GuessLikeCCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:GuessLikeCCellIdentifier];
//            cell.delegate = self;
//            
//            return cell;
            return [UITableViewCell new];
        }
//        case HometypeTAMMYANGX:{
//            
//            AccessoryCell *cell = [AccessoryCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:AccessoryCellIdentifier];
////            cell.tammymodel = self.tammtangsmodel;
//            cell.delegate = self;
//            return cell;
//            break;
//        }
//        case HometypeDPLAY:{
//            DPlayCell *cell = [DPlayCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:DPlayCellIdentifier];
////            cell.dplaymodel=_dplaymodel;
//            cell.delegate = self;
//            return cell;
//            break;
//        }
        case HometypeBigBrands: {
            BrandsHeaderCell *brandsHeaderCell = [BrandsHeaderCell returnResueCellFormTableView:self.infoTableView indexPath:indexPath identifier:BrandsHeaderCellIdentifier];
            brandsHeaderCell.delegate = self;
            return brandsHeaderCell;
            break;
        }
        default:
        {
            return [UITableViewCell new];
            break;
        }
    }
}

- (CGFloat)distributionHomeListCurrentCellHeigthWithItem:(Hometype)homeType
                                                          toTableView:(UITableView* )tableView
                                                            indexPaht:(NSIndexPath* )indexPath
{
    switch (homeType) {
        case HometypeForUpOneDownFour:
        {
            return optimazBrand_H;
            break;
        }
        case HometypeForUpOneDownThree:
        {
            return accessory_H;
            break;
        }
        case HometypeForLeftOneRightTwo:
        {
            return DPlay_H;
            break;
        }
        case HometypeForDaDaVedio:
        {
            return homeVedio_H;
            break;
        }
        case HometypeForDaDaFood:
        {
            return scrollV_H;
            break;
        }
        case HometypeForDaDaMusic:
        {
            return scrollVMusice_H;
            break;
        }
        case HometypeForAdvertisement:
        {
            return advertise_H;
            break;
        }
        case HometypeForNone:
        {
            return 0;
        }
        case  HometypeTAMMYANGX:
        {
            return accessory_H;
            break;
        }
        case HometypeDPLAY:{
            return DPlay_H;
            break;
        }
        case HometypeBigBrands:
        {
            return fifth_H;
            break;
        }
        default:
        {
            return 0;
            break;
        }
    }
}
//scrollViewWillBeginDragging
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_customSearchBar resignFirstResponder];
}

#pragma mark - UISearchControllerDelegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.likeCollectionView) {
        return (self.likeGoods.count > 6 ? 6 : (self.likeGoods.count > 0 ? self.likeGoods.count : 0));
    } else {
        if (_goodsFirstClassifyModels.count) {
            return _goodsFirstClassifyModels.count;
        }
        return 1;
    }
    return 0;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.likeCollectionView) {
        GuessLikeCell *item = [GuessLikeCell returnResueCellFormTableView:self.likeCollectionView indexPath:indexPath identifier:GuessLikeItemIdentifier];
        item.delegate = self;
        item.likeModel = self.likeGoods[indexPath.row];
        
        return item;
    } else {
        KindClothesCollectionViewCell *cell = [KindClothesCollectionViewCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:KindClothesCollectionViewCellIdentifier];
        
        GoodsFirstClassifyModel *model = _goodsFirstClassifyModels[indexPath.row];
        cell.model = model;
        
        return cell;
    }
    
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.likeCollectionView) {
        return CGSizeMake(footer_item_W, footer_item_H);
    } else {
        return CGSizeMake(good_item_W, good_item_H);
    }
    
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.likeCollectionView) {
        return 10*rating;
    } else {
        return 0;
    }
    
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//定义每个UICollectionView 的 margin缝隙
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.likeCollectionView) {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        DDXLikeGoodsModel *likeGoods = self.likeGoods[indexPath.row];
        GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] initWithGoodsSKU:likeGoods.sku goodsType:@"fs"];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else {
        GoodsFirstClassifyModel *model = _goodsFirstClassifyModels[indexPath.row];
        //
        //    GoodReclassifyViewController *ctl = [[GoodReclassifyViewController alloc] initWithDictionaryArrays:model.dicArray];
        //    ctl.hidesBottomBarWhenPushed = YES;
        //    [self.navigationController pushViewController:ctl animated:YES];
        
        //针对一级界面是死的数据，后台其实暂时并没有这么多分类且不安顺序的数据 必须的一一对应
        NSLog(@"%@",model.goodsId);
        GoodsWebsViewController *goodsWebCtl = [[GoodsWebsViewController alloc] initWithGoodsType:[_sortddic objectForKey:model.title] goodsId:  [model.goodsId integerValue] ];
        goodsWebCtl.hidesBottomBarWhenPushed = YES;
        goodsWebCtl.titlestring=model.title;
        [self.navigationController pushViewController:goodsWebCtl animated:YES];
    }
    
}

#pragma mark - 定位
- (void)localtionCityAction
{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager startUpdatingLocation];
    } else {
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"home_cannot_locate", comment:@"无法进行定位") message:NSLocalizedString(@"home_cannot_locate_message", comment:@"请检查您的设备是否开启定位功能") preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCtl addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"common_confirm",comment:@"确定") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }]];
        
        [self presentViewController:alertCtl animated:YES completion:nil];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    _reLocationCityName = @"定位失败";
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations firstObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            
            _reLocationCityName = placeMark.locality;
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_reLocationCityName style:UIBarButtonItemStylePlain target:self action:@selector(locatingAction)];
            
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14] , NSFontAttributeName, nil] forState:UIControlStateNormal];

          if (!_reLocationCityName) {
                _reLocationCityName = NSLocalizedString(@"home_cannot_locate_city", comment:@"无法定位当前城市");
            }
        }
        
        [_locationManager stopUpdatingLocation];
    }];
}


#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
    
    BannerSecondImgController *bannerSecImgVc = [[BannerSecondImgController alloc] initWithBannerIndex:index];
    bannerSecImgVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bannerSecImgVc animated:YES];
}

#pragma mark - BrandsViewDelegate
- (void)clickIMGWithTags:(HomeBrandsType)brandType
{
    switch (brandType) {
        case HomeBrandsTypeBrand:
        {
            NSLog(@"品牌街");
//            BrandsViewController* brandvc=[[BrandsViewController alloc]init];
//            brandvc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:brandvc animated:YES];
            
            GirlClothesViewController* girlvc = [[GirlClothesViewController alloc] initWithActivityType:ActivityTypesForBrands
                                                                                           withBanner:[UIImage imageNamed:@"ico_activity_brands"]
                                                                                              withTitle:@"品牌街"
                                                                                    withBannerGoodsType:@"9999"];
            girlvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:girlvc animated:YES];
            
            break;
        }
        case HomeBrandsTypeHot:
        {
            NSLog(@"爆款女装");
            GirlClothesViewController* girlvc=[[GirlClothesViewController alloc] initWithActivityType:ActivityTypesForHots
                                                                                           withBanner:[UIImage imageNamed:@"ico_activity_hots"]
                                                                                            withTitle:@"爆款女装"
                                                                                  withBannerGoodsType:@"9999"];
            girlvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:girlvc animated:YES];
            break;
        }
        case HomeBrandsTypePrivate:
        {
            NSLog(@"私人订制");
            GoodsDetailsViewController* goodvc=[[GoodsDetailsViewController alloc]init];
            goodvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:goodvc animated:YES];
            break;
        }
        case HomeBrandsTypeShops:
        {
            NSLog(@"门店");
            DDXMapLocationViewController* doorvc=[[DDXMapLocationViewController alloc]init];
            doorvc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:doorvc animated:YES];
            break;
        }
        default:
            break;
    }
}
/*
#pragma mark - FlashSaleViewDelegate
- (void)clickSaleGoodsWithTags:(NSInteger)brandType
{
    NSLog(@"click === %ld", (long)brandType);
//    TimeGoodsViewController* timevc=[TimeGoodsViewController new];
//    [self.navigationController pushViewController:timevc animated:YES];
    
    
    LimitedGoodsViewController * timevc = [LimitedGoodsViewController new];
    timevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:timevc animated:YES];
}
*/
#pragma mark - FifthHeaderViewDelegate
- (void)clickPerferGoodsWithTags:(NSInteger)indexRow
{
    
}

#pragma mark - BrandsHeaderCellDelegate
- (void)clickActionWithBrandsHeaderCellDelegate:(BrandsHeaderCell *)cell forIndexTags:(NSInteger)indexTag
{
    if (indexTag == 0) {
        NSLog(@"左边图");
        //          NSLog(@"品牌优选数组%@",self.brandchoosearray);
        //        FamousbrandViewController* favc=[[FamousbrandViewController alloc]init];
        //        [self.navigationController pushViewController:favc animated:YES];
        
        GirlClothesViewController* girlvc = [[GirlClothesViewController alloc] initWithActivityType:ActivityTypesForBigBrands
                                                                                         withBanner:[UIImage imageNamed:@"ico_activity_bigBrands"]
                                                                                          withTitle:@"甄大牌"
                                                                                withBannerGoodsType:@"9999"];
        girlvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:girlvc animated:YES];
        
    } else if (indexTag == 1) {
        NSLog(@"右边图");
        //        PrivilegeViewController* pvc=[[PrivilegeViewController alloc]init];
        //        [self.navigationController pushViewController:pvc animated:YES];
        
        GirlClothesViewController* girlvc = [[GirlClothesViewController alloc] initWithActivityType:ActivityTypesForFavoBrands
                                                                                         withBanner:[UIImage imageNamed:@"ico_activity_favoBrands"]
                                                                                          withTitle:@"惠来购"
                                                                                withBannerGoodsType:@"9999"];
        girlvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:girlvc animated:YES];
    }
}

#pragma mark - OptimazBrandCellDelegate
- (void)clickOptimazBrandPickWith:(OptimazBrandCell *)cell forIndexTags:(NSInteger)indexTag
{
    switch (indexTag-99) {
        case 1:
        {
            if (self.brandchoosemodel.count>=1) {
               [self SetGoodShopControllerPush: [_brandchoosemodel[0].imageLinkId integerValue]title:@"茜诗迪"];
            }
            NSLog(@"上一下四  11111");
            break;
        }
        case 2:
        {
            if (self.brandchoosemodel.count>=2) {
                
                [self SetGoodShopControllerPush: [_brandchoosemodel[1].imageLinkId integerValue]title:@"景欣荟"];

            }
            
            NSLog(@"上一下四 22222");
            break;
        }
        case 3:
        {
            if (self.brandchoosemodel.count>=3) {
                
                  [self SetGoodShopControllerPush: [_brandchoosemodel[2].imageLinkId integerValue]title:@"香港慕之琪"];
            }
            NSLog(@"上一下四 33333");
            break;
        }
        case 4:
        {
            NSLog(@"%lu",(unsigned long)self.brandchoosemodel.count);
            if (self.brandchoosemodel.count>=4) {
                
                [self SetGoodShopControllerPush: [_brandchoosemodel[3].imageLinkId integerValue]title:@"赫斯特"];
            }
            NSLog(@"上一下四 44444");
            break;
        }
        default:
            break;
    }
}


- (void)clickOptimazBrandBannerPicWith:(OptimazBrandCell *)cell forIndexTags:(NSInteger)indexTag
{
    NSLog(@"上一下四--------- %ld", (long)indexTag);
    GirlClothesViewController* girlvc = [[GirlClothesViewController alloc] initWithActivityType:ActivityTypesForChooseBrands
                                                                                     withBanner:[UIImage imageNamed:@"ico_activity_favoBrands"]
                                                                                      withTitle:@"品牌优选"
                                                                            withBannerGoodsType:@"9999"];
    girlvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:girlvc animated:YES];
}

#pragma mark - AccessoryCellDelegate
- (void)clickActionWithAccessoryCell:(AccessoryCell *)cell forIndexTags:(NSInteger)indexTag
{
    
    NSLog(@"%ld",(long)cell.tag);
    if (cell.tag==0) {
    NSLog(@"%@",_cartiermodel);
        switch (indexTag-99) {
            case 0:
                if (_cartiermodel.count>=1) {
                    [self SetGoodShopControllerPush:[_cartiermodel[0].imageLinkId integerValue] title:@"茜诗迪品牌旗舰店"];
                }
                break;
            case 1:
                if (_cartiermodel.count>=2) {
                    [self SetPushGoodsDetail:_cartiermodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_cartiermodel.count>=3) {
                    [self SetPushGoodsDetail:_cartiermodel[2].imageLinkId];
                    
                }
                
                break;
            case 3:
                if (_cartiermodel.count>=4) {
                    [self SetPushGoodsDetail:_cartiermodel[3].imageLinkId];
                    
                }
                
                break;
                
            default:
                break;
        }
    }else if (cell.tag==1){
        switch (indexTag-99) {
            case 0:
                if (_dplaymodel.count>=1) {
                   
                    [self SetGoodShopControllerPush:[_dplaymodel[0].imageLinkId integerValue]title:@" hurst品牌旗舰店"];
                }
                break;
            case 1:
                if (_dplaymodel.count>=2) {
                    [self SetPushGoodsDetail:_dplaymodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_dplaymodel.count>=3) {
                    [self SetPushGoodsDetail:_dplaymodel[2].imageLinkId];
                    
                }
                
                break;
            case 3:
                if (_dplaymodel.count>=4) {
                    [self SetPushGoodsDetail:_dplaymodel[3].imageLinkId];
                    
                }
                
                break;
                
            default:
                break;
        }
   
    }
    else if (cell.tag==2){
        switch (indexTag-99) {
            case 0:
                if (_cgcomodel.count>=1) {
                    
                    [self SetGoodShopControllerPush:[_cgcomodel[0].imageLinkId integerValue]title:@"COCO旗舰店"];
                }
                break;
            case 1:
                if (_cgcomodel.count>=2) {
                    [self SetPushGoodsDetail:_cgcomodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_cgcomodel.count>=3) {
                    [self SetPushGoodsDetail:_cgcomodel[2].imageLinkId];
                    
                }
                
                break;
            case 3:
                if (_cgcomodel.count>=4) {
                    [self SetPushGoodsDetail:_cgcomodel[3].imageLinkId];
                    
                }
                
                break;
                
            default:
                break;
        }

    }
    else if (cell.tag==3){
        switch (indexTag-99) {
            case 0:
                if (_ellymodel.count>=1) {
                    [self SetGoodShopControllerPush:[_ellymodel[0].imageLinkId integerValue]title:@"Elly旗舰店"];
                }
                break;
            case 1:
                if (_ellymodel.count>=2) {
                    [self SetPushGoodsDetail:_ellymodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_ellymodel.count>=3) {
                    [self SetPushGoodsDetail:_ellymodel[2].imageLinkId];
                    
                }
                
                break;
            case 3:
                if (_ellymodel.count>=4) {
                    [self SetPushGoodsDetail:_ellymodel[3].imageLinkId];
                    
                }
                
                break;
                
            default:
                break;
        }
    }
    else if (cell.tag==4){
        switch (indexTag-99) {
            case 0:
                if (_showmodel.count>=1) {
                    [self SetGoodShopControllerPush:[_showmodel[0].imageLinkId integerValue]title:@"Show包旗舰店"];
                }
                break;
            case 1:
                if (_showmodel.count>=2) {
                    [self SetPushGoodsDetail:_showmodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_showmodel.count>=3) {
                    [self SetPushGoodsDetail:_showmodel[2].imageLinkId];
                    
                }
                
                break;
            case 3:
                if (_showmodel.count>=4) {
                    [self SetPushGoodsDetail:_showmodel[3].imageLinkId];
                    
                }
                
                break;
                
            default:
                break;
        }
    }
//   GoodsDetailViewController* goodvc=[[ GoodsDetailViewController alloc]initWithGoodsSKU:[NSString stringWithFormat:@"%d",_cartiermodel[1].plateId]];
   NSLog(@"上一下三--------- %ld", (long)indexTag);
}

-(void)SetGoodShopControllerPush:(NSInteger)shopSKu title:(NSString*)titile{

    GoodsShopListViewController* shopvc=[[GoodsShopListViewController alloc]initWithGoodsStoreSKU:shopSKu];
    shopvc.hidesBottomBarWhenPushed = YES;
    shopvc.title=titile;
    [self.navigationController pushViewController:shopvc animated:YES];
}

#pragma mark -  HomeVedioCellDelegate
- (void)clickActionWithHomeVedioCell:(HomeVedioCell *)cell forIndexTags:(NSInteger)indexTag
{
    NSLog(@"搭搭影视--------- %ld", (long)indexTag);
}

#pragma mark - DPlayCellDelegate

- (void)clickActionWithDPlayCellDelegate:(DPlayCell *)cell forIndexTags:(NSInteger)indexTag
{
    NSLog(@"%ld",(long)indexTag);
    if (cell.tag==0) {
        switch (indexTag-99) {
            case 0:
                if (_hotpeoplemodel.count>=1) {
                    [self SetGoodShopControllerPush:[_hotpeoplemodel[0].imageLinkId integerValue]title:@"香港慕之淇品牌旗舰店"];
                }
                break;
            case 1:
                if (_hotpeoplemodel.count>=2) {
                    [self SetPushGoodsDetail:_hotpeoplemodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_hotpeoplemodel.count>=3) {
                    [self SetPushGoodsDetail:_hotpeoplemodel[2].imageLinkId];
                    
                }
                
                break;
            default:
                break;
        }
    }
    else if (cell.tag==1){
        switch (indexTag-99) {
            case 0:
                if (_wonderfulmodel.count>=1) {
                    [self SetGoodShopControllerPush:[_wonderfulmodel[0].imageLinkId integerValue]title:@"Wonderful品牌旗舰店"];
                }
                break;
            case 1:
                if (_wonderfulmodel.count>=2) {
                    [self SetPushGoodsDetail:_wonderfulmodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_wonderfulmodel.count>=3) {
                    [self SetPushGoodsDetail:_wonderfulmodel[2].imageLinkId];
                    
                }
                
                break;
            default:
                break;
        }
        
    }
    else if (cell.tag==2){
        switch (indexTag-99) {
            case 0:
                if (_fashionmodel.count>=1) {
                    [self SetGoodShopControllerPush:[_fashionmodel[0].imageLinkId integerValue]title:@"Fashion旗舰店"];
                }
                break;
            case 1:
                if (_fashionmodel.count>=2) {
                    [self SetPushGoodsDetail:_fashionmodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_fashionmodel.count>=3) {
                    [self SetPushGoodsDetail:_fashionmodel[2].imageLinkId];
                    
                }
                
                break;
            default:
                break;
        }
        
    }
    else if (cell.tag==3){
        switch (indexTag-99) {
            case 0:
                if (_bramodel.count>=1) {
                    [self SetGoodShopControllerPush: [_bramodel[0].imageLinkId integerValue]title:@"潮Bra旗舰店"];
                }
                break;
            case 1:
                if (_bramodel.count>=2) {
                    [self SetPushGoodsDetail:_bramodel[1].imageLinkId];
                    
                }
                
                break;
            case 2:
                if (_bramodel.count>=3) {
                    [self SetPushGoodsDetail:_bramodel[2].imageLinkId];
                    
                }
                
                break;
            default:
                break;
        }
    }
    NSLog(@"左一右二--------- %ld", (long)indexTag);
}

-(void)SetPushGoodsDetail:(NSString*)goodsku{
    NSLog(@"商品sku==%@",goodsku);
    GoodsDetailViewController* goodvc=[[GoodsDetailViewController alloc] initWithGoodsSKU:goodsku goodsType:@"fs"];
    goodvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goodvc animated:YES];
}




#pragma mark - SmallViewScrollVCellDelegate
- (void)clickActionWithSmallViewScrollVCellDelegate:(SmallViewScrollVCell *)cell forIndexTags:(NSInteger)indexTag
{
    NSLog(@"搭搭吃货--------- %ld", (long)indexTag);
}

#pragma mark - AdvertisementCellDelegate
- (void)clickActionWithAdvertisementCellDelegate:(AdvertisementCell *)cell forIndexTags:(NSInteger)indexTag
{
    NSLog(@"广告--------- %ld", (long)indexTag);
    
    NSIndexPath *indePath = [self.infoTableView indexPathForCell:cell];
    NSInteger index = [_sectionUI[indePath.section] integerValue];
    UIImage *advertisementImage = [UIImage imageNamed:@[@"advertisement_01", @"advertisement_02", @"advertisement_03", @"advertisement_04"][index]];
    NSInteger actionType = [@[@(ActivityTypesForActFirst),  @(ActivityTypesForActSecond), @(ActivityTypesForActThird), @(ActivityTypesForActFour)][index] intValue];
    NSString *goodsType = @[@"61", @"64", @"9999", @"56"][index];
    GirlClothesViewController* girlvc = [[GirlClothesViewController alloc] initWithActivityType:actionType
                                                                                     withBanner:advertisementImage
                                                                                      withTitle:@""
                                                                            withBannerGoodsType:goodsType];
    girlvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:girlvc animated:YES];
}

#pragma mark- SmallViewScrollMusicCellDelegate
- (void)clickActionWithSmallViewScrollMusicCellDelegate:(SmallViewScrollMusicCell *)cell forIndexTags:(NSInteger)indexTag
{
    NSLog(@"搭搭音乐--------- %ld", (long)indexTag);
}

#pragma mark - GuessLikeCCellDelegate
- (void)pushGoodsToCartAction
{
    NSLog(@"添加进购物车");
}

//#pragma mark - bar action
-(void)goingtoshop{
    
    NSLog(@"菜单");
    if (self.brandchoosemodel.count>=1) {
        [self SetGoodShopControllerPush: [_brandchoosemodel[0].imageLinkId integerValue]title:@"茜诗迪"];

    }
}

//// location
- (void)locatingAction {
    NSLog(@"location");
    LocationViewController *VC = [LocationViewController new];
    VC.locationCity = _reLocationCityName;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
//
-(void)talksendmessage{
//    
    NSLog(@"message ... ");
    MessageListViewController *mevc=[[MessageListViewController alloc]init];
    mevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mevc animated:YES];

}

#pragma mark - GuessLikeItemDelegate
- (void)pushGoodsToCart
{
    NSLog(@"添加至购物车");
}

#pragma mark - clickIrrImageView
- (void)clickIrrImageView:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap = %ld", tap.view.tag);
}

#pragma mark - lazy init

//模块1的图片数组
- (NSMutableArray *)bannerimagearray
{
    if (!_bannerimagearray) {
        _bannerimagearray = [NSMutableArray array];
    }
    return _bannerimagearray;
}

//模块1的全部数组
- (NSMutableArray *)brandallarray
{
    if (!_brandallarray) {
        _brandallarray = [NSMutableArray array];
    }
    return _brandallarray;
}

//17个模块的数组
- (NSMutableArray *)allmutablearray
{
    if (!_allmutablearray) {
        _allmutablearray = [NSMutableArray array];
    }
    return _allmutablearray;
}

- (NSMutableArray *)girldoormodel
{
    if (!_girldoormodel) {
        _girldoormodel = [NSMutableArray array];
    }
    return _girldoormodel;
}

- (NSMutableArray *)brandchoosemodel

{
    if (!_brandchoosemodel) {
        _brandchoosemodel= [NSMutableArray array];
    }
    return _brandchoosemodel;
}

- (NSMutableDictionary*)plateIddic

{
    if (!_plateIddic) {
        _plateIddic= [NSMutableDictionary dictionary];
    }
    return _plateIddic;
}


- (NSMutableArray *)brandchoosearray
{
    if (!_brandchoosearray) {
        _brandchoosearray= [NSMutableArray array];
    }
    return _brandchoosearray;
}

- (NSMutableArray*)cartiermodel
{
    if (!_cartiermodel) {
        _cartiermodel= [NSMutableArray new];
    }
    return _cartiermodel;
}


- (NSMutableArray*)hotpeoplemodel
{
    if (!_hotpeoplemodel) {
        _hotpeoplemodel= [NSMutableArray new];
    }
    return _hotpeoplemodel;
}

- (NSMutableArray*)tammtangsmodel
{
    if (!_tammtangsmodel) {
        _tammtangsmodel= [NSMutableArray new];
    }
    return _tammtangsmodel;
}

- (NSMutableArray*)dplaymodel
{
    if (!_dplaymodel) {
        _dplaymodel= [NSMutableArray new];
    }
    return _dplaymodel;
}

- (NSMutableArray*)sortmodel
{
    if (!_sortmodel) {
        _sortmodel= [NSMutableArray new];
    }
    return _sortmodel;
}

- (NSMutableDictionary*)sortddic
{
    if (!_sortddic) {
        _sortddic= [NSMutableDictionary new];
    }
    return _sortddic;
}

- (NSMutableArray*)sortarray
{
    if (!_sortarray) {
        _sortarray= [NSMutableArray new];
    }
    return _sortarray;
}


- (NSMutableArray*)wonderfulmodel
{
    if (!_wonderfulmodel) {
        _wonderfulmodel= [NSMutableArray new];
    }
    return _wonderfulmodel;
}


- (NSMutableArray*)cgcomodel
{
    if (!_cgcomodel) {
        _cgcomodel= [NSMutableArray new];
    }
    return _cgcomodel;
}

- (NSMutableArray*)fashionmodel
{
    if (!_fashionmodel) {
        _fashionmodel= [NSMutableArray new];
    }
    return _fashionmodel;
}


- (NSMutableArray*)ellymodel
{
    if (!_ellymodel) {
        _ellymodel= [NSMutableArray new];
    }
    return _ellymodel;
}

- (NSMutableArray*)bramodel
{
    if (!_bramodel) {
        _bramodel= [NSMutableArray new];
    }
    return _bramodel;
}

- (NSMutableArray*)showmodel
{
    if (!_showmodel) {
        _showmodel= [NSMutableArray new];
    }
    return _showmodel;
}

#pragma mark - init tableview
- (UITableView *)infoTableView
{
    if (!_infoTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableView.tableFooterView = self.likeView;
        tableView.tableHeaderView =_headview;
        
        tableView.backgroundColor = BackCellColor ;
        [self.view addSubview:tableView];
        _infoTableView = tableView;
    }
    return _infoTableView;
}

- (UIView *)likeView
{
    if (!_likeView) {
        _likeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, footer_Height)];
        _likeView.backgroundColor = [UIColor whiteColor];
        
        [self setupCollectionView];
    }
    return _likeView;
}

- (void)setupCollectionView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(12*rating, 0, kScreen_Width-24*rating, footer_Height)];
    [self.likeView addSubview:bottomView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.likeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-24*rating, footer_Height) collectionViewLayout:layout];
    self.likeCollectionView.delegate = self;
    self.likeCollectionView.dataSource = self;
    self.likeCollectionView.bounces = NO;
    self.likeCollectionView.backgroundColor = [UIColor whiteColor];
    [self.likeCollectionView registerClass:[GuessLikeCell class] forCellWithReuseIdentifier:GuessLikeItemIdentifier];
    [bottomView addSubview:self.likeCollectionView];
}


@end

