//
//  GirlClothesViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GirlClothesViewController.h"
#import "GoodListCell.h"
#import "DDXHomeModel.h"
#import "GoodsDetailViewController.h"

#define item_W 170 * kScreen_Width / 375
#define item_H 227 * kScreen_Width / 375
#define headheght 205*kScreen_Width/375
@interface GirlClothesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIImageView *bannerImageView;

@property (nonatomic, assign) ActivityTypes activityType;//活动类型
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) UIImage *bannerImg;
@property (nonatomic, strong) NSMutableArray <DDXGoodsModel *> *contents;
@property (nonatomic, copy) NSString *bannerGoodsType;

@end

@implementation GirlClothesViewController

- (instancetype)initWithActivityType:(ActivityTypes)activityType
                          withBanner:(UIImage *)bannerImg
                           withTitle:(NSString *)title
                 withBannerGoodsType:(NSString *)bannerGoodsType
{
    self = [super init];
    if (self) {
        self.pageIndex = 1;
        self.activityType = activityType;
        self.bannerImg = bannerImg;
        self.bannerGoodsType = bannerGoodsType;
        
        self.contents = [NSMutableArray new];
        self.navigationItem.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setgirlheadview];
    
    [self.collectionView beginLoading];
    [self fetchDataForListWithRefresh:YES];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self fetchDataForListWithRefresh:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    self.collectionView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self fetchDataForListWithRefresh:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshing];
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.collectionView configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.collectionView hideAllGeneralPage];
        [strongSelf.collectionView beginLoading];
        [strongSelf fetchDataForListWithRefresh:YES];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetch data
- (void)fetchDataForListWithRefresh:(BOOL)isRefresh
{
    [self.collectionView hideAllGeneralPage];
    if (isRefresh) { self.pageIndex = 1; }
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@/%ld/%@/%ld", DDXAPI_HTTP_PREFIX_Activity, DDXAPI_ACTIVITY_SR, DDXAPI_ACTIVITY_LIST, self.activityType, self.bannerGoodsType, (long)self.pageIndex];
    
    [DaHttpTool get:strUrl
             params:nil
            success:^(id json) {
                
                BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                NSMutableArray *models = [NSMutableArray new];
                if (isSuccess) {
                    models = [NSArray osc_modelArrayWithClass:[DDXGoodsModel class] json:json[@"content"][@"rows"]].mutableCopy;
                    
                    if (models && models.count > 0) {//下拉得到的数据
                        if (isRefresh) {
                            [self.contents removeAllObjects];
                        } else {
                            self.pageIndex++;
                        }
                        [self.contents addObjectsFromArray:models];
                    }

                    if (!([json[@"content"][@"currentPage"] longValue] < [json[@"content"][@"pageCount"] longValue])) {
                        [self.collectionView.mj_footer endRefreshing];
                    }
                } else {
                    MBProgressHUD *HUD = [Util createHUD];
                    HUD.mode = MBProgressHUDModeCustomView;
//                    HUD.labelText = json[@"content"][@"statusMsg"];
                    
                    [HUD hide:YES afterDelay:5];
                }
                
                if (self.contents.count == 0) {
                    [self.collectionView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                           tip:@"小搭未发现任何数据"];
                } else {
                    self.bannerImageView.image = self.bannerImg;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (isRefresh) {
                        [self.collectionView.mj_header endRefreshing];
                    } else {
                        if ( (isSuccess && !models) || (isSuccess && models.count == 0)) {
                            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                        }else{
                            [self.collectionView.mj_footer endRefreshing];
                        }
                    }
                    
                    [self.collectionView reloadData];
                });
                
            } failure:^(NSError *error) {
                //
                NSLog(@"error = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
                if (isRefresh) {
                    [self.collectionView.mj_header endRefreshing];
                } else {
                    [self.collectionView.mj_footer endRefreshing];
                }
                
                if (self.contents.count == 0) {
                    [self.collectionView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                           tip:@"与母星暂时失去联系啦"
                                                   buttonTitle:@"刷新"];
                }
            }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.contents.count) {
        return self.contents.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodListCell *cell = [GoodListCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:GoodListCellIdentifier];
    
    if (self.contents.count) {
        DDXGoodsModel *goodsModel = self.contents[indexPath.row];
        cell.goodsItem = goodsModel;
        cell.goodType = GoodsThirdClassrifyTypeNormal;
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    DDXGoodsModel *goods = self.contents[indexPath.row];
    [self.navigationController pushViewController:[[GoodsDetailViewController alloc] initWithGoodsSKU:goods.sku goodsType:@"fs"] animated:YES];
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headclotcell" forIndexPath:indexPath];
    //定制头部视图的内容
    [reusableView addSubview:self.bannerImageView];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    bottomLabel.textColor=[UIColor colorWithHex:0x3f3f3f];
//    NSString *laststr = @"·热卖";
//    NSString *praisestr = [NSString stringWithFormat:@"潮流%@",laststr];
//    NSMutableAttributedString *costattrDescribeStr = [[NSMutableAttributedString alloc] initWithString:praisestr];
//    
//    [costattrDescribeStr addAttribute:NSForegroundColorAttributeName
//     
//                                value:[UIColor colorWithHex:0xff7d7d]
//     
//                                range:[praisestr  rangeOfString:laststr]];
//    bottomLabel.attributedText = costattrDescribeStr;
    bottomLabel.frame=CGRectMake(0, 165*kScreen_Width/375, kScreen_Width, 40*kScreen_Width/375);
    bottomLabel.textAlignment=NSTextAlignmentCenter;
    [reusableView addSubview:bottomLabel];

    return reusableView;
}

#pragma mark - UI

-(void)setgirlheadview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize=CGSizeMake(kScreen_Width, headheght);//头部视图的尺寸
    layout.minimumInteritemSpacing =0;
    layout.sectionInset = UIEdgeInsetsMake(0,12*kScreen_Width/375,0, 12*kScreen_Width/375);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreen_Width,kScreen_Height) collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headclotcell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[GoodListCell class] forCellWithReuseIdentifier:GoodListCellIdentifier];
}


-(UIImageView *)bannerImageView
{
    if (!_bannerImageView) {
        UIImageView *headerImage=[[UIImageView alloc] init];
        headerImage.contentMode=UIViewContentModeScaleAspectFill;
        headerImage.clipsToBounds=YES;
        headerImage.frame = CGRectMake(0, 0, kScreen_Width, 165*kScreen_Width/375);
        headerImage.backgroundColor = [UIColor whiteColor];
        
        _bannerImageView = headerImage;
    }
    
    return _bannerImageView;
}

+ (UIImage *)imageRendingMode:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

@end
