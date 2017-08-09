//
//  DDXDetailViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DDXDetailViewController.h"
#import "ShopListCell.h"
#import "DDXHomeModel.h"
#import "GoodsDetailViewController.h"

#define item_W 170 * kScreen_Width / 375
#define item_H 227 * kScreen_Width / 375
@interface DDXDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray <DDXSearchModel *>* listmodel;//搜索模型
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation DDXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    [self listmodel];

    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=self.keywordstring;
    [self setdetailgoods];
    [self searchdata:YES];
    self.collectionView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
      [self searchdata:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshing];
        });
    }];
    
    self.collectionView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self searchdata:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    
    
}

- (NSMutableArray*)listmodel
{
    if (!_listmodel) {
        _listmodel= [NSMutableArray new];
    }
    return _listmodel;
}





-(void)searchdata:(BOOL)isRefresh{
    [self.collectionView hideAllGeneralPage];
    if (isRefresh) { self.pageIndex = 1; }
    
    NSString* usernameid=nil;
    if ([DDXUserinfo getUserId]) {
    usernameid=[NSString stringWithFormat:@"%ld",[DDXUserinfo getUserId]];
    }
    else{
        
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"%@",identifierForVendor);
        NSString* udidstring=[identifierForVendor stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@",udidstring);
        usernameid=udidstring;
    }
    
    NSLog(@"用户ID==%@",usernameid);
    
    NSString* searchurlstr = [NSString stringWithFormat:@"%@%@", DDXAPI_HTTP_PREIX_Search, DDXAPI_SHOPMMS_Keywords];
    [DaHttpTool post:searchurlstr params:@{@"userId":usernameid,
                                           @"keyWord":self.keywordstring,
                                           @"page":@(self.pageIndex)}.mutableCopy
             success:^(id json) {
                 if ( [json isKindOfClass:[NSDictionary class]]) {
                     
                     if ([json[@"state"] isEqualToString:@"success"]) {
                         NSLog(@"%@",json);
                    
                         NSArray *contents = json[@"content"][@"itemList"];
                               NSLog(@"%lu",(unsigned long)contents.count);
                          NSMutableArray *models = [NSMutableArray new];
                         models=[[NSArray osc_modelArrayWithClass:[DDXSearchModel class] json:contents] mutableCopy];
                         if (models && models.count > 0) {//下拉得到的数据
                             if (isRefresh) {
                                 [self.listmodel removeAllObjects];
                             }
                                 self.pageIndex++;
                                [self.listmodel addObjectsFromArray:models];
                 
                         }
                         
                         if (self.listmodel.count == 0) {
                             [self.collectionView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                                    tip:@"小搭未发现任何数据"];
                         }
                         
                        [self.collectionView reloadData];
                         
                     }else{
                         
                         MBProgressHUD *HUD = [Util createHUD];
                         HUD.mode = MBProgressHUDModeCustomView;
                         HUD.labelText = @"网络错误";
                         
                         [HUD hide:YES afterDelay:5];
                     }
                 }
                 
             } failure:^(NSError *error) {
                 NSLog(@"请求失败%@",error);
            if (self.listmodel.count == 0) {
                     [self.collectionView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                                 tip:@"与母星暂时失去联系啦"
                                                         buttonTitle:@"刷新"];
                 }
             }];
}

-(void)setdetailgoods{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(item_W, item_H);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =0;
    layout.sectionInset = UIEdgeInsetsMake(0,12*kScreen_Width/375,0, 12*kScreen_Width/375);//top, left, bottom, right
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 8,kScreen_Width,kScreen_Height-8) collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headclotcell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ShopListCell class] forCellWithReuseIdentifier:ShopListCellIdentifier];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.listmodel.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopListCell *cell = [ShopListCell returnResueCellFormTableView:collectionView indexPath:indexPath identifier:ShopListCellIdentifier];
    
    DDXSearchModel* model=self.listmodel[indexPath.row];
    cell.listmodel=model;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DDXSearchModel* model=self.listmodel[indexPath.row];
    
    if (model.sku.length) {
        
        GoodsDetailViewController* goodvc=[[GoodsDetailViewController alloc] initWithGoodsSKU:model.sku goodsType:@"fs"];
        goodvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goodvc animated:YES];
        
    }
    
}


@end
