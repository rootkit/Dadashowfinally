//
//  CollectViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 收藏列表 *****/
#import "CollectViewController.h"
/** 正式版 **/
#import "TitleViewController.h"
#import "CollectGoodsViewController.h"
#import "CollectShopsViewController.h"
#import "MineGoodsmodel.h"
#import "GoodsDetailViewController.h"
/** 展会版 **/
#import "CollectGoodsCell.h"

@interface CollectViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray <MineGoodsmodel *>* mycollectmodel;//收藏商品模型


@end

@implementation CollectViewController

- (NSMutableArray*)mycollectmodel
{
    if (!_mycollectmodel) {
        _mycollectmodel= [NSMutableArray new];
    }
    return _mycollectmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self mycollectmodel];
    self.pageIndex=0;
    self.title = @"收藏";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = BackCellColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self collectmegoodsload:YES];

    self.tableView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self collectmegoodsload:NO];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
         [self collectmegoodsload:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];

    
    /** 正式版 **/
//    [self layoutScrollTitle];
    
    /** 展会版 **/
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CollectGoodsCell class] forCellReuseIdentifier:CollectGoodsCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectmegoodsload:(BOOL)isRefresh{
    
    NSString* usertoken=nil;
    if (isRefresh){
        self.pageIndex = 1;
    }
    if ([DDXUserinfo  getUserCode].length) {
      [self.tableView hideAllGeneralPage];
        usertoken=[DDXUserinfo  getUserCode];
      NSLog(@"用户token==%@",usertoken);
      NSString* collecturlstr =[NSString stringWithFormat:@"%@%@?token=%@&pageNo=%ld", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_Minecollect,usertoken,self.pageIndex];
      NSLog(@"%@",collecturlstr);
        
      [DaHttpTool post:collecturlstr
                  params:@{}.mutableCopy
               success:^(id json) {
                if ( [json isKindOfClass:[NSDictionary class]]) {
                    if ([json[@"state"] isEqualToString:@"success"]) {
                         NSLog(@"%@",json);
                     NSArray *contents = json[@"content"][@"rows"];
                     NSMutableArray *models = [NSMutableArray new];

                    models = [[NSArray osc_modelArrayWithClass:[MineGoodsmodel class] json:contents] mutableCopy];
                      NSLog(@"%@",_mycollectmodel);
                      
                        if (models && models.count > 0) {//下拉得到的数据
                            if (isRefresh) {
                                [self.mycollectmodel removeAllObjects];
                            }
                            self.pageIndex++;
                            [self.mycollectmodel addObjectsFromArray:models];
                            
                        }
                        if (self.mycollectmodel.count == 0) {
                            [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                                   tip:@"小搭未发现任何数据"];
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (isRefresh) {
                                [self.tableView.mj_header endRefreshing];
                            } else {
                                if ( ([json[@"state"] isEqualToString:@"success"] && !models) || ([json[@"state"] isEqualToString:@"success"] && models.count == 0)) {
                                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                }else{
                                    [self.tableView.mj_footer endRefreshing];
                                }
                            }
                            
                            [self.tableView reloadData];
                        });
      
                } else {
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                        hud.mode = MBProgressHUDModeText;
                        hud.margin=10;
                        hud.labelFont=[UIFont boldSystemFontOfSize:13];
                        hud.detailsLabelText = @"登录已过期";
                        [hud hide:YES afterDelay:1.5];
                        
                    }
                }

                
            } failure:^(NSError *error) {
                     NSLog(@"%@",error);
                if (self.mycollectmodel.count == 0) {
                    [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                           tip:@"与母星暂时失去联系啦"];
                }
                     
            }];
    }
}


/** 正式版 **/
- (void)layoutScrollTitle
{
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"宝贝", @"店铺"]
                                                               viewControllers:@[[CollectGoodsViewController new],
                                                                                 [CollectShopsViewController new]]
                                                         andIsFixedTitleLength:NO
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = 44;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 1;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14];
    
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
}

/** 展会版 **/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _mycollectmodel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectGoodsCell *cell = [CollectGoodsCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:CollectGoodsCellIdentifier];
    if (self.mycollectmodel.count) {
        MineGoodsmodel* model = self.mycollectmodel[indexPath.row];
        cell.model=model;
    }
      return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineGoodsmodel* model=self.mycollectmodel[indexPath.row];
    
    if (model.sku.length) {
        
        GoodsDetailViewController* goodvc=[[GoodsDetailViewController alloc] initWithGoodsSKU:model.sku goodsType:@"fs"];
        goodvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:goodvc animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*rating + 6;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除 section = %ld, row = %ld \n", (long)indexPath.section, (long)indexPath.row);
        [self.mycollectmodel removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        
    }
}

#pragma mark - init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = BackCellColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


 








@end
