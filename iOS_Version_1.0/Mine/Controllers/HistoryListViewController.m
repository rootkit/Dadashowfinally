//
//  HistoryListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 足迹列表 *****/
#import "HistoryListViewController.h"
#import "GoodsDetailViewController.h"

#import "CollectGoodsCell.h"
#import "MineGoodsmodel.h"

#define cell_Height 130*kScreen_Width/375
@interface HistoryListViewController ()
@property (nonatomic, assign) NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray <Travelmodel *>* travelmodel;//足迹模型

@end

@implementation HistoryListViewController

- (NSMutableArray*)travelmodel
{
    if (!_travelmodel) {
        _travelmodel= [NSMutableArray new];
    }
    return _travelmodel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self travelmodel];
    self.title = @"足迹";
    self.pageIndex=0;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CollectGoodsCell class] forCellReuseIdentifier:CollectGoodsCellIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearAction)];
    
    [self sethistory:YES];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self sethistory:NO];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self sethistory:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
}


-(void)sethistory:(BOOL)isRefresh{
    
    NSString* usertoken=nil;
    if (isRefresh){
        self.pageIndex = 1;
    }
    if ([DDXUserinfo  getUserCode].length) {
        [self.tableView hideAllGeneralPage];
        usertoken = [DDXUserinfo  getUserCode];
        
        NSString* travelurlstr =[NSString stringWithFormat:@"%@%@?token=%@&pageNo=%ld", DDXAPI_HTTP_PREFIX_Goods, DDXAPI_Minetravel,usertoken,self.pageIndex];
        
        [DaHttpTool post:travelurlstr
                  params:@{}.mutableCopy
                 success:^(id json) {
                     if ( [json isKindOfClass:[NSDictionary class]]) {
                         if ([json[@"state"] isEqualToString:@"success"]) {
                             NSLog(@"%@",json);
                             NSArray *contents = json[@"content"][@"rows"];
                             NSMutableArray *models = [NSMutableArray new];
                             models = [[NSArray osc_modelArrayWithClass:[Travelmodel class] json:contents] mutableCopy];
                             NSLog(@"%@", models);
                             if (models && models.count > 0) {//下拉得到的数据
                                 if (isRefresh) {
                                     [self.travelmodel removeAllObjects];
                                 }
                                 self.pageIndex++;
                                 [self.travelmodel addObjectsFromArray:models];
                             }
                             if (self.travelmodel.count == 0) {
                                 [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                                          tip:@"小搭未发现任何数据"];
                             }
                             [self.tableView reloadData];
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
                     if (self.travelmodel.count == 0) {
                         [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                                tip:@"与母星暂时失去联系啦"];
                     }
                 }];
    }

    
    
    
}












#pragma mark - back action

- (void)clearAction
{
    NSLog(@"clear  Action ......");
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 3;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.travelmodel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectGoodsCell *cell = [CollectGoodsCell returnResueCellFormTableView:tableView indexPath:indexPath identifier:CollectGoodsCellIdentifier];
    if (self.travelmodel.count) {
        Travelmodel* model=self.travelmodel[indexPath.row];
        cell.tranvemodel=model;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Travelmodel* model = self.travelmodel[indexPath.row];
    
    if (model.sku.length) {
        GoodsDetailViewController* goodvc = [[GoodsDetailViewController alloc] initWithGoodsSKU:model.sku goodsType:@"fs"];
        [self.navigationController pushViewController:goodvc animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cell_Height + 6;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    return [self customHeaderView];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - init view
- (UIView *)customHeaderView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    bottomView.backgroundColor = BackCellColor;
    
    UILabel *label = [UILabel new];
    label.text = @"02月13日";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = FirstTextColor;
    label.frame = CGRectMake(12, 12, kScreen_Width-24, 16);
    [bottomView addSubview:label];
    
    return bottomView;
}

@end
