//
//  ShopingCartViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

/********   购物车、猜你喜欢列表 ***********/
#import "ShopingCartViewController.h"
#import "ConfirmOrderViewController.h"
#import "MessageListViewController.h"
#import "GoodsDetailViewController.h"

#import "GoodCartsCell.h"
#import "GuessLikeCell.h"
#import "GoodsCartsHeaderView.h"
#import "GuessLikeCCell.h"
#import "EmptyCartsView.h"
#import "GetCouponPopView.h"
#import "DDXShopCartGoods.h"

#define item_W 170*rating
#define item_H 235*rating

#define empty_headview_height 266*kScreen_Width/375
#define like_footerView_height item_H*3+48+23

@interface ShopingCartViewController () <UITableViewDelegate, UITableViewDataSource, GoodsCartsHeaderViewDelegate, GoodCartsCellDelegate, GuessLikeCCellDelegate, EmptyCartsViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GuessLikeItemDelegate>
{
    BOOL allChooseBool; //全选bool
    BOOL storeChooseBool; //全选bool  未用
    
    float allPrice;
}

@property (nonatomic, strong) UIButton *editingButton;
@property (nonatomic, strong) UIBarButtonItem *messageBarBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *PostBtn;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *allChooseLb;
@property (weak, nonatomic) IBOutlet UILabel *stateLb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) EmptyCartsView *emptyView;
@property (strong, nonatomic)  UIView *likeView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <DDXShopCartGoods *> *goodsArray;
@property (nonatomic, strong) NSMutableArray <DDXLikeGoodsModel *> *likeGoods;
@property (nonatomic, copy) NSString *goodsSkus;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray <DDXShopCartGoods *> *selectedGoods;

@end

@implementation ShopingCartViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _goodsArray = [NSMutableArray new];
    _selectedGoods = [NSMutableArray new];
    _likeGoods = [NSMutableArray new];
    allPrice = 0.0;
    self.allPriceLb.text = @"¥0";
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHex:0x464545];
    [self setlayoutBarbutton];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    
    [self.tableView registerClass:[GoodCartsCell class] forCellReuseIdentifier:GoodsCartsCellIdentifier];
    [self.tableView registerClass:[GuessLikeCCell class] forCellReuseIdentifier:GuessLikeCCellIdentifier];
//    _goodsArray = @[@"cart", @"like"].mutableCopy;
    
    [self judgeShopCat];
    
    //获取数据
    [self.tableView.mj_header beginRefreshing];
    [self fetchDataForShoppingCart:YES];
    
    
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataForShoppingCart:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView hideAllGeneralPage];
        [strongSelf.tableView beginLoading];
        [strongSelf fetchDataForShoppingCart:YES];
        
    }];
    
    [self judgePostBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 判断是否选择了商品结算
- (void)judgePostBtn
{
    if (_selectedGoods.count > 0) {
        [self.PostBtn setBackgroundColor:ThemeColor];
        self.PostBtn.enabled = YES;
    } else {
        
        [self.PostBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.PostBtn.enabled = NO;
    }
}

#pragma mark - 判断购物车是否为空
- (void)judgeShopCat
{
    if (_goodsArray.count == 0) {//只有猜你喜欢，购物车为空
        _BottomViewHeight.constant = 0;
        _bottomView.hidden = YES;
        self.tableView.tableHeaderView = self.emptyView;
        self.editingButton.hidden = YES;
    } else {
        _BottomViewHeight.constant = 50;
        _bottomView.hidden = NO;
        self.tableView.tableHeaderView = nil;
        self.editingButton.hidden = NO;
    }
    self.tableView.tableFooterView = self.likeView;
}

#pragma mark - bar button

- (void)setlayoutBarbutton
{
    self.editingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editingButton.frame = CGRectMake(0, 0, 40, 40);
    [self.editingButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editingButton setTitleColor:[UIColor colorWithHex:0x585757] forState:UIControlStateNormal];
    [self.editingButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.editingButton setTitleColor:ThemeColor forState:UIControlStateSelected];
    
    [self.editingButton setTitle:@"编辑" forState:UIControlStateDisabled];
    [self.editingButton setTitleColor:[UIColor colorWithHex:0x585757] forState:UIControlStateDisabled];
    
    [self.editingButton addTarget:self action:@selector(clickAllEdit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *batbutton = [[UIBarButtonItem alloc] initWithCustomView:self.editingButton];
    self.messageBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bubble"] style:UIBarButtonItemStylePlain target:self action:@selector(messageBarAction:)];
    self.navigationItem.rightBarButtonItems = @[self.messageBarBtn, batbutton];
}

#pragma mark - fetch data
- (void)fetchDataForShoppingCart:(BOOL)refresh
{
    [self fetchLikelist];
    
    self.likeView.hidden = NO;
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_GETSHOPPINGCART, [DDXUserinfo getUserCode]];
   
    [DaHttpTool post:strUrl
              params:nil
             success:^(id json) {
                 //
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 NSMutableArray *models = [NSMutableArray new];
                 if (isSuccess) {
                     NSString *content = json[@"content"];
                     
                     NSArray *array = [Util arrayWithJsonString:[Util jsonDecodeBase64AndUrlEncoder:content]];
                     NSLog(@"content array = %@", array);
                     
                     models = [NSArray osc_modelArrayWithClass:[DDXShopCartGoods class] json:array].mutableCopy;
                     if (models && models.count > 0) {
                         if (refresh) {
                             [self.goodsArray removeAllObjects];
                         }
                         
                         [self.goodsArray addObjectsFromArray:models];
                     }
                     
                 } else {
                     self.likeView.hidden = YES;
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                     hud.mode = MBProgressHUDModeText;
                     hud.margin=10;
                     hud.labelFont=[UIFont boldSystemFontOfSize:13];
                     hud.detailsLabelText = json[@"content"][@"statusMsg"];
                     [hud hide:YES afterDelay:1.5];
                 }
                 NSLog(@"success = %@", json);
                 [self judgeShopCat];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (refresh) {
                         [self.tableView.mj_header endRefreshing];
                     }
                     [self judgePostBtn];
                     [self.tableView reloadData];
                 });
             } failure:^(NSError *error) {
                 NSLog(@"error = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
                 if (refresh) {
                     [self.tableView.mj_header endRefreshing];
                 }
                 [self judgeShopCat];
//                 if (self.goodsArray.count == 0) {
//                     self.tableView.tableHeaderView = nil;
//                     self.likeView.hidden = YES;
//                     [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
//                                                            tip:@"与母星暂时失去联系啦"
//                                                    buttonTitle:@"刷新"];
//                 }
                 
                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                 hud.mode = MBProgressHUDModeText;
                 hud.margin=10;
                 hud.labelFont=[UIFont boldSystemFontOfSize:13];
                 hud.detailsLabelText = @"网络出错啦！";//[NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 [hud hide:YES afterDelay:1.5];
    }];
}

//删除购物车中的商品
- (void)deleteShopCart:(NSInteger)goodIndex
{
    DDXShopCartGoods *goods = self.goodsArray[goodIndex];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@&skus=%@", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_DELSHOPPINGCART, [DDXUserinfo getUserCode], goods.sku];
    
    [DaHttpTool post:strUrl
              params:nil
             success:^(id json) {
                 //
                 
                 if ([json[@"state"] isEqualToString:@"success"]) {
                     
                     [self.goodsArray removeObjectAtIndex:goodIndex];
                     
                     [self judgeShopCat];
                     [self.tableView reloadData];
                 } else {
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                     hud.mode = MBProgressHUDModeText;
                     hud.margin=10;
                     hud.labelFont=[UIFont boldSystemFontOfSize:13];
                     hud.detailsLabelText = json[@"content"][@"statusMsg"];
                     [hud hide:YES afterDelay:1.5];
                 }
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _goodsArray.count > 0 ? _goodsArray.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _goodsArray.count > 0 ? 1 : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodCartsCell *cell = [GoodCartsCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:GoodsCartsCellIdentifier];
    
    cell.delegate = self;
//    cell.goods.isChooseGoods = allChooseBool ? allChooseBool : storeChooseBool;
    if (self.goodsArray.count) {
        DDXShopCartGoods *cartsShop = self.goodsArray[indexPath.section];
        cell.goods = cartsShop;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.goodsArray.count) {
        GoodsCartsHeaderView *headerView = [[GoodsCartsHeaderView alloc]init];;
        headerView.delegate = self;
        headerView.isChooseGoods = allChooseBool ? allChooseBool : storeChooseBool;
        headerView.indexRow = section;
        
        if (self.goodsArray.count) {
            headerView.goods = self.goodsArray[section];
        }
        
        return headerView;
    } else {
        return nil;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodCartsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    NSLog(@"edit = %d", cell.goods.changeEditingStyle);
    if (cell.goods.changeEditingStyle == 1) {
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除 section = %ld, row = %ld \n", (long)indexPath.section, (long)indexPath.row);
        [self deleteShopCart:indexPath.section];
    }
}

#pragma mark - GoodsCartsHeaderViewDelegate

- (void)chooseAllGoodsAction:(GoodsCartsHeaderView *)headView indexSection:(NSInteger)section
{
    NSLog(@"选择该店所有商品");
    storeChooseBool = !storeChooseBool;
    headView.isChooseGoods = storeChooseBool;;
    
    [self judgePostBtn];
    [self.tableView reloadData];
}
- (void)editingAction:(GoodsCartsHeaderView *)headView indexSection:(NSInteger)section
{
    NSLog(@"编辑 section = %ld", (long)section);
    
    GoodCartsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    NSLog(@"edit = %d", cell.goods.changeEditingStyle);
    cell.goods.changeEditingStyle = !cell.goods.changeEditingStyle;
    NSLog(@"价格 = %ld", (long)cell.goods.itemPrice);
    
    [self judgePostBtn];
    
    [self.tableView reloadData];
    
}
- (void)drawGoodCardsAction:(GoodsCartsHeaderView *)headView indexSection:(NSInteger)section
{
    NSLog(@"领券");
    GetCouponPopManager *manager = [GetCouponPopManager popViewManager];
    
    DDXShopCartGoods *cartsShop = self.goodsArray[section];
    
    [manager showPopViewWithCouponData:@[@"", @""] withShopName:cartsShop.storeName];
}

#pragma bottom bar action
//结算
- (IBAction)checkoutAction:(UIButton *)sender {
    NSLog(@"结算");
    ConfirmOrderViewController *orderCtl = [[ConfirmOrderViewController alloc] initWithSelectedGoods:self.selectedGoods withAllPrice:allPrice];
    orderCtl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderCtl animated:YES];
}

//全选按钮
- (IBAction)chooseAction:(UIButton *)sender {
    NSLog(@"全选");
    
    allChooseBool = !allChooseBool;
    [_chooseBtn setImage:(allChooseBool ? [GoodCartsCell goodsSelectedImage] : [GoodCartsCell unGoodsSelectedImage]) forState:UIControlStateNormal];
    
    allPrice = 0;
    [self.selectedGoods removeAllObjects];
    if (allChooseBool) {
        [self.selectedGoods addObjectsFromArray:self.goodsArray];
    }
    
    [self.goodsArray enumerateObjectsUsingBlock:^(DDXShopCartGoods * _Nonnull goods, NSUInteger idx, BOOL * _Nonnull stop) {
        goods.isChooseGoods = allChooseBool;
        if (allChooseBool) {
           allPrice = allPrice + goods.itemPriceNow*goods.itemNum;
        } else {
            allPrice = 0;
        }
        
    }];
    

    self.allPriceLb.text = [NSString stringWithFormat:@"¥%.2f", allPrice];
    self.allChooseLb.text = [NSString stringWithFormat:@"全选（%lu）", (unsigned long)(self.selectedGoods.count > 0 ?  self.selectedGoods.count: 0)];
    [self judgePostBtn];
    [self.tableView reloadData];
}


#pragma mark - barbutton action

- (void)messageBarAction:(UIBarButtonItem *)sender {
    NSLog(@"导航栏消息");
    MessageListViewController *mevc=[[MessageListViewController alloc] init];
    mevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mevc animated:YES];
}

- (void)clickAllEdit:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"导航栏编辑");
    
    [self.goodsArray enumerateObjectsUsingBlock:^(DDXShopCartGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (sender.selected) {
            obj.changeEditingStyle = YES;
        } else {
            obj.changeEditingStyle = NO;
        }
        
    }];
    
    [self judgePostBtn];
    [self.tableView reloadData];
}

#pragma mark - GoodCartsCellDelegate
- (void)chooseGoodsWithGoodCartsCell:(GoodCartsCell *)cell
{
    cell.goods.isChooseGoods = !cell.goods.isChooseGoods;
    
    if (cell.goods.isChooseGoods) {
        allPrice = allPrice + cell.goods.itemPriceNow*cell.goods.itemNum;
        [self.selectedGoods addObject:cell.goods];
    } else {
        allPrice = 0;
        [self.selectedGoods removeObject:cell.goods];
        
        if (_selectedGoods.count > 0) {
            [self.selectedGoods enumerateObjectsUsingBlock:^(DDXShopCartGoods * _Nonnull goods, NSUInteger idx, BOOL * _Nonnull stop) {
                allPrice = allPrice + goods.itemPriceNow*goods.itemNum;

            }];
        } else {
            allPrice = 0;
        }
    }
    
    self.allPriceLb.text = [NSString stringWithFormat:@"¥%.2f", allPrice];
    self.allChooseLb.text = [NSString stringWithFormat:@"全选（%lu）", (unsigned long)(self.selectedGoods.count > 0 ?  self.selectedGoods.count: 0)];
    
    [self judgePostBtn];
    [self.tableView reloadData];
}

- (void)changeGoodsNumActionWithGoodCartsCell:(GoodCartsCell *)cell forTag:(NSInteger)tag
{
    if (tag == 1) {
        NSLog(@"减操作");
        if (cell.goods.itemNum > 1) {
            cell.goods.itemNum--;
        }
        
    } else if (tag == 2) {
        NSLog(@"加操作");
        if (cell.goods.itemNum != 0) {
            cell.goods.itemNum++;
        } else {
            cell.goods.itemNum = 1;
        }
    } else if (tag == 3) {
        NSLog(@"删除操作");
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        [self deleteShopCart:indexPath.section];
    }
    
    if (cell.goods.isChooseGoods) {
        if (_selectedGoods.count > 0) {
            allPrice = 0;
            [self.selectedGoods enumerateObjectsUsingBlock:^(DDXShopCartGoods * _Nonnull goods, NSUInteger idx, BOOL * _Nonnull stop) {
                allPrice = allPrice + goods.itemPriceNow*goods.itemNum;
                
            }];
        } else {
            allPrice = 0;
        }
        
        self.allPriceLb.text = [NSString stringWithFormat:@"¥%.2f", allPrice];
        self.allChooseLb.text = [NSString stringWithFormat:@"全选（%lu）", (unsigned long)(self.selectedGoods.count > 0 ?  self.selectedGoods.count: 0)];
    }
    
    [self judgePostBtn];
    [self.tableView reloadData];
}

#pragma mark - GuessLikeCCellDelegate
- (void)pushGoodsToCartAction
{
    NSLog(@"加入购物车");
}

#pragma mark - EmptyCartsViewDelegate
- (void)clickForJustLookAction
{
    NSLog(@"just Look Action ...");
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ShopingCartViewController class]]) {
            [self.navigationController.tabBarController setSelectedIndex:0];
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
    }
}

#pragma mark - empty headview
- (EmptyCartsView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[EmptyCartsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Height, empty_headview_height)];
        _emptyView.backgroundColor = BackCellColor;
        _emptyView.delegate = self;
    }
    
    return _emptyView;
}

- (UIView *)likeView
{
    if (!_likeView) {
        _likeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, like_footerView_height)];
        _likeView.backgroundColor = [UIColor whiteColor];
        
        [_likeView addSubview:[self customGuessLikeHeaderView]];
        
        [self setupCollectionView];
    }
    return _likeView;
}

#pragma mark - init view
- (UIView *)customGuessLikeHeaderView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 48)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.text = @"猜你喜欢";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = FirstTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelWidth = 74;
    label.frame = CGRectMake(CGRectGetMidX(bottomView.frame) - labelWidth/2, 11, labelWidth, 26);
    
    
    [bottomView addSubview:label];
    
    UIImageView *leftIMG = [UIImageView new];
    leftIMG.image = [UIImage imageNamed:@"bg_left"];
    leftIMG.frame = CGRectMake(CGRectGetMinX(label.frame) - 20 - 51, 20, 51, 8);
    [bottomView addSubview:leftIMG];
    
    UIImageView *rightIMG = [UIImageView new];
    rightIMG.image = [UIImage imageNamed:@"bg_right"];
    rightIMG.frame = CGRectMake(CGRectGetMaxX(label.frame) + 20, 20, 51, 8);
    [bottomView addSubview:rightIMG];
    
    return bottomView;
}

- (void)setupCollectionView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(12*rating, 48, kScreen_Width-24*rating, like_footerView_height-48)];
    [self.likeView addSubview:bottomView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 10*rating;
    layout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bottomView.frame), CGRectGetHeight(bottomView.frame)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    [bottomView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[GuessLikeCell class] forCellWithReuseIdentifier:GuessLikeItemIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.likeGoods.count > 6 ? 6 : (self.likeGoods.count > 0 ? self.likeGoods.count : 0));
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GuessLikeCell *item = [GuessLikeCell returnResueCellFormTableView:self.collectionView indexPath:indexPath identifier:GuessLikeItemIdentifier];
    item.delegate = self;
    item.likeModel = self.likeGoods[indexPath.row];
    
    return item;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);

    return insets;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DDXLikeGoodsModel *likeGoods = self.likeGoods[indexPath.row];
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] initWithGoodsSKU:likeGoods.sku goodsType:@"fs"];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
