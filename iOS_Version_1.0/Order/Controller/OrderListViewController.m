//
//  OrderListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

/*******  订单列表  *******/
#import "OrderListViewController.h"
#import "AlreadySendGoodsViewController.h"
#import "GoodsOrderCell.h"

#import "FiveCommentViewController.h"
#import "OrderLogisticsDetailViewController.h"
#import "OrderDrawbackViewController.h"//test 退款
#import "GoodsDetailViewController.h"

#import "WaitPayViewController.h"/****  等待付款  ****/
#import "SuccessOrderViewController.h" /****  交易成功  ****/

#import "AlreadyPayViewController.h"/****  已付款  ****/
#import "WaitOrderViewController.h"/****  等待发货  ****/
#import "AlreadySendGoodsViewController.h"/****  卖家已发货  ****/
#import "OrderGoodsViewController.h"/**** 关闭订单 ****/

#import "FWContentItem.h" // test
#import "DDXGoodsOrderModel.h"

@interface OrderListViewController () <UITableViewDelegate, UITableViewDataSource, GoodsOrderCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) GoodsOrderTypes orderTypes;

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *strUrl;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSMutableArray <DDXGoodsOrderModel *> *contents;

@end

@implementation OrderListViewController

- (instancetype)initWithOrderType:(GoodsOrderTypes)orderType
{
    self = [super init];
    if (self) {
        _orderTypes = orderType;
        
        _pageIndex = 1;
        _userId = [DDXUserinfo getUserId];
        
        _contents = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[GoodsOrderCell class] forCellReuseIdentifier:GoodsOrderCellIdentifier];
    
    [self.tableView.mj_header beginRefreshing];
    [self fetchOrderDataWithRefresh:YES];
    
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self fetchOrderDataWithRefresh:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    self.tableView.mj_footer = [XZZNormalFooter footerWithRefreshingBlock:^{
        [self fetchOrderDataWithRefresh:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView hideAllGeneralPage];
        [strongSelf.tableView beginLoading];
        [strongSelf fetchOrderDataWithRefresh:YES];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - fetch data

- (void)fetchOrderDataWithRefresh:(BOOL)isRefresh
{
    [self.tableView hideAllGeneralPage];
    
    if (isRefresh) {
        self.pageIndex = 1;
    }

    _strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@&state=%ld&pageNo=%ld", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_GETORDER, [DDXUserinfo getUserCode], (long)self.orderTypes, (long)self.pageIndex];
    
    [DaHttpTool post:_strUrl
              params:@{}.mutableCopy
             success:^(id json) {
                 //
                 NSLog(@"json == %@", json);
                 [self.tableView endLoading];
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 NSArray *contentDic = json[@"content"][@"rows"];
                 NSMutableArray *models = [NSMutableArray new];
                 
                 if (isSuccess) {
                     if (contentDic.count) {
                         models = [NSArray osc_modelArrayWithClass:[DDXGoodsOrderModel class] json:contentDic].mutableCopy;
                     }
                     if (models && models.count > 0) {//下拉得到的数据
                         if (isRefresh) {
                             [self.contents removeAllObjects];
                         }
                         self.pageIndex++;
                         
                         if (self.orderTypes == GoodsOrderTypesWithAll || self.orderTypes == GoodsOrderTypesWithObligation) {
                             [self.contents addObjectsFromArray:models];
                         }
                         
                     }
                     
                     
                 } else {
                     MBProgressHUD *HUD = [Util createHUD];
                     HUD.mode = MBProgressHUDModeCustomView;
                     HUD.labelText = json[@"content"][@"statusMsg"];
                     
                     [HUD hide:YES afterDelay:5];
                 }
                 
                 if (self.contents.count == 0) {
                     [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                            tip:@"小搭未发现任何数据"];
                 }
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (isRefresh) {
                         [self.tableView.mj_header endRefreshing];
                     } else {
                         if ( (isSuccess && !models) || (isSuccess && models.count == 0)) {
                             [self.tableView.mj_footer endRefreshingWithNoMoreData];
                         }else{
                             [self.tableView.mj_footer endRefreshing];
                         }
                     }
                     
                     [self.tableView reloadData];
                 });
                 
             } failure:^(NSError *error) {
                 NSLog(@"error = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
                 
                 if (isRefresh) {
                     [self.tableView.mj_header endRefreshing];
                 } else {
                     [self.tableView.mj_footer endRefreshing];
                 }
                 
                 if (self.contents.count == 0) {
                     [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                            tip:@"与母星暂时失去联系啦"
                                                    buttonTitle:@"刷新"];
                 }
                 
                 MBProgressHUD *HUD = [Util createHUD];
                 HUD.mode = MBProgressHUDModeCustomView;
                 HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 
                 [HUD hide:YES afterDelay:5];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contents.count;//2;//
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsOrderCell *cell = [GoodsOrderCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:GoodsOrderCellIdentifier];
    
    cell.orderTypes = _orderTypes;
    cell.delegate = self;
    if (self.contents.count) {
        DDXGoodsOrderModel *model = self.contents[indexPath.row];
        cell.goodsOrderModel = model;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 235*rating+10*rating;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DDXGoodsOrderModel *model = self.contents[indexPath.row];
    switch (_orderTypes) {
        case GoodsOrderTypesWithAll://全部
        {
//            [self.navigationController pushViewController:[AlreadyPayViewController new] animated:YES];//已付款？
            [self.navigationController pushViewController:[[WaitPayViewController alloc] initWithOrderInfo:model withAddress:[DDXConsignee loadUserDefaultAddress]] animated:YES];//等待付款
            break;
        }
        case GoodsOrderTypesWithObligation://待付款
        {
            [self.navigationController pushViewController:[[WaitPayViewController alloc] initWithOrderInfo:model withAddress:[DDXConsignee loadUserDefaultAddress]] animated:YES];//等待付款
            break;
        }
        case GoodsOrderTypesWithWaitForReceiv://待收货
        {
            [self.navigationController pushViewController:[AlreadySendGoodsViewController new] animated:YES];//已发货？
            break;
        }
        case GoodsOrderTypesWithRemainTobeEvaluated://待评价
        {
            [self.navigationController pushViewController:[SuccessOrderViewController new] animated:YES];//交易成功
            break;
        }
        case GoodsOrderTypesWithAfterSale://售后
        {
            [self.navigationController pushViewController:[OrderGoodsViewController new] animated:YES];//关闭订单？
            break;
        }
        default:
            break;
    }
}

#pragma mark - GoodsOrderCellDelegate
- (void)clickBtnActionWithGoodsOrderCell:(GoodsOrderCell *)cell andBtnTag:(NSInteger)tag
{
    if (tag == 1) {
        
        if (cell.orderTypes == GoodsOrderTypesWithObligation) {
            NSLog(@"右边按钮 付款");
        } else if (cell.orderTypes == GoodsOrderTypesWithWaitForReceiv) {
            NSLog(@"右边按钮 确认收货");
        } else if (cell.orderTypes == GoodsOrderTypesWithRemainTobeEvaluated) {
            [self.navigationController pushViewController:[FiveCommentViewController new] animated:YES];
            
        } else if (cell.orderTypes == GoodsOrderTypesWithAfterSale) {
            NSLog(@"右边按钮 钱款去向");
        }
        
    } else if (tag == 2) {
        
        if (cell.orderTypes == GoodsOrderTypesWithObligation) {
            NSLog(@"中间按钮 取消订单");
        } else if (cell.orderTypes == GoodsOrderTypesWithWaitForReceiv) {
            NSLog(@"中间按钮 查看物流");
            OrderLogisticsDetailViewController *ctl = [[OrderLogisticsDetailViewController alloc] initWithOrderId:0];
            [self.navigationController pushViewController:ctl animated:YES];
            
        } else if (cell.orderTypes == GoodsOrderTypesWithRemainTobeEvaluated) {
            NSLog(@"中间按钮 查看物流");
            OrderLogisticsDetailViewController *ctl = [[OrderLogisticsDetailViewController alloc] initWithOrderId:0];
            [self.navigationController pushViewController:ctl animated:YES];
            
        } else if (cell.orderTypes == GoodsOrderTypesWithAfterSale) { }
    }else if (tag == 3) {

        if (cell.orderTypes == GoodsOrderTypesWithObligation) {
            NSLog(@"左边按钮联系卖家");
        } else if (cell.orderTypes == GoodsOrderTypesWithWaitForReceiv) {
            NSLog(@"左边按钮 延长收货");
            
            OrderDrawbackViewController *ctl = [[OrderDrawbackViewController alloc] initWithDrawBackType:GoodsOrderTypesWithWaitForReceiv];
            [self.navigationController pushViewController: ctl animated:YES];
            
        } else if (cell.orderTypes == GoodsOrderTypesWithRemainTobeEvaluated) {
            NSLog(@"左边按钮 删除订单");
            
            OrderDrawbackViewController *ctl = [[OrderDrawbackViewController alloc] initWithDrawBackType:GoodsOrderTypesWithRemainTobeEvaluated];
            [self.navigationController pushViewController: ctl animated:YES];
            
        } else if (cell.orderTypes == GoodsOrderTypesWithAfterSale) { }
        
    }
}

- (void)clickPushToGoodsDetail:(GoodsOrderCell *)cell
{
    DDXShopCartGoods *shopCartGoods = [DDXShopCartGoods osc_modelWithDictionary:cell.goodsOrderModel.items[0]];
    
    GoodsDetailViewController* goodvc = [[GoodsDetailViewController alloc] initWithGoodsSKU:shopCartGoods.sku goodsType:@"fs"];
    goodvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:goodvc animated:YES];
}

#pragma mark - init tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.backgroundColor = BackCellColor ;
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}



@end
