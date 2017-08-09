//
//  ConfirmOrderViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//


/*******  确认订单  *******/
#import "ConfirmOrderViewController.h"
#import "AddressListViewController.h"
#import "ToStoreViewController.h"
#import "OrderPayStateController.h"//支付失败或者成功界面
#import "GoodsShopListViewController.h" //店铺
#import "GoodsDetailViewController.h" //详情

#import "OrderAdressCell.h"
#import "OrderGoodsCell.h"
#import "OrderPostageCell.h"
#import "OrderPayTypeCell.h"
#import "PostageStateManager.h"

#import "UIColorHF.h"

@interface ConfirmOrderViewController () <UITableViewDelegate, UITableViewDataSource, OrderPostageCellDelegate, PostageStateManagerDelegate, OrderPayTypeCellDelegate, OrderGoodsCellDelegate>
{
    OrderPostageCell *postageCell;
    CGFloat _curTouchPointHeight;
    BOOL isShowKeyboard;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray <DDXShopCartGoods *> *goodsArray;
@property (nonatomic, assign) float price;

@property (nonatomic, strong) DDXConsignee *consignee;

@end

@implementation ConfirmOrderViewController

- (instancetype)initWithSelectedGoods:(NSArray <DDXShopCartGoods *> *)goods withAllPrice:(float)allPrice //从购物车进
{
    self = [super init];
    if (self) {
        _params = [NSMutableDictionary dictionary];
        self.goodsArray = [NSMutableArray arrayWithArray:goods];
        self.price = 0;
        
        [self judgePrice];
    }
    return self;
}

- (instancetype)initWithDetailGoods:(DDXShopCartGoods *)goods  //从详情进
{
    self = [super init];
    if (self) {
        _params = [NSMutableDictionary dictionary];
        self.goodsArray = [NSMutableArray arrayWithObject:goods];
        self.price = 0;
        
        [self judgePrice];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[OrderAdressCell class] forCellReuseIdentifier:OrderAdressCellIdentifierString];
    [self.tableView registerClass:[OrderGoodsCell class] forCellReuseIdentifier:OrderGoodsCellIdentifierString];
    [self.tableView registerClass:[OrderPostageCell class] forCellReuseIdentifier:OrderPostageCellIdentifierString];
    [self.tableView registerClass:[OrderPayTypeCell class] forCellReuseIdentifier:OrderPayTypeCellIdentifierString];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction)];
    
    //软键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _curTouchPointHeight = 0;
    
    self.priceLb.text = [NSString stringWithFormat:@"¥%.2f", self.price];
    self.consignee = [DDXConsignee loadUserDefaultAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 计算价格
- (void)judgePrice
{
    [self.goodsArray enumerateObjectsUsingBlock:^(DDXShopCartGoods * _Nonnull goods, NSUInteger idx, BOOL * _Nonnull stop) {
        self.price = self.price + goods.itemPriceNow*goods.itemNum;
    }];
}

#pragma mark - bar button

- (void)cancleAction
{
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"是否取消订单" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消订单");
    }]];
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self.navigationController presentViewController:alertCtl animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 1;
    } else if (section == 1) {
        return self.goodsArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            OrderAdressCell *cell = [OrderAdressCell returnReuseCellFormTableView:tableView
                                                                        indexPath:indexPath
                                                                       identifier:OrderAdressCellIdentifierString];
            
            cell.consignee = self.consignee;
            
            return cell;
            break;
        }
        case 1:
        {
            OrderGoodsCell *cell = [OrderGoodsCell returnReuseCellFormTableView:tableView
                                                                      indexPath:indexPath
                                                                     identifier:OrderGoodsCellIdentifierString];
            cell.goods = self.goodsArray[indexPath.row];
            cell.delegate = self;
            
            return cell;
            break;
        }
        case 2:
        {
            OrderPostageCell *cell = [OrderPostageCell returnReuseCellFormTableView:tableView
                                                                          indexPath:indexPath
                                                                         identifier:OrderPostageCellIdentifierString];
//            cell.delegate = self;
            cell.price = self.price;
            return cell;
            break;
        }
        case 3:
        {
            OrderPayTypeCell *cell = [OrderPayTypeCell returnReuseCellFormTableView:tableView
                                                                          indexPath:indexPath
                                                                         identifier:OrderPayTypeCellIdentifierString];
            cell.delegate = self;
            return cell;
            break;
        }
        default:
            break;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            return 80*rating;
            break;
        }
        case 1:
        {
            return 117*rating;
            break;
        }
        case 2:
        {
            return 164*rating;
            break;
        }
        case 3:
        {
            return 157*rating;
            break;
        }
        default:
            break;
    }
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section < 3) {
        return 10*rating;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        AddressListViewController *addressVC = [AddressListViewController new];
        
        [self.navigationController pushViewController:addressVC animated:YES];
        addressVC.changeOrderAddressBlock = ^(DDXConsignee *consignee) {
            self.consignee = consignee;
        };
        
        
    } else { }
}

#pragma mark - OrderGoodsCellDelegate
- (void)clickOrderForGoodsStore:(OrderGoodsCell *)cell
{
    GoodsShopListViewController *storeVC = [[GoodsShopListViewController alloc] initWithGoodsStoreSKU:cell.goods.storeId];
    [self.navigationController pushViewController:storeVC animated:YES];
}

- (void)clickOrderForGoodsDetail:(OrderGoodsCell *)cell
{
    GoodsDetailViewController *shopDetailVC = [[GoodsDetailViewController alloc] initWithGoodsSKU:cell.goods.sku goodsType:@"fs"];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    /*
    确认订单的商品无法区分是“普通”(fs)的还是“试衣间”(fit)的
     */
}

#pragma mark - OrderPostageCellDelegate
- (void)postageStateActionDelegate:(OrderPostageCell *)cell
{
    NSLog(@"更改邮寄方式");
    PostageStateManager *manager = [PostageStateManager postagestateManager];
    manager.delegate = self;
    [manager showPostageStateWithStateType:@[@"到店自取", @"全国包邮", @"申通¥25", @"圆通¥24"]];
    postageCell = cell;
}

- (void)postageChooseShopAddressActionDelegate:(OrderPostageCell *)cell
{
    NSLog(@"更改到店提取的店铺地址");
    ToStoreViewController *storeSelectedCtl = [ToStoreViewController new];
    [storeSelectedCtl addTarget:self action:@selector(changeStoreAddress:)];
    [self.navigationController pushViewController:storeSelectedCtl animated:YES];
}

- (void)changeStoreAddress:(NSString *)selectedModel
{
    NSLog(@"选择地址列表中的第%@个", selectedModel);
}

- (void)postageChooseEditOrderDetailInfoActionDelegate:(OrderPostageCell *)cell withTextfieldMaxY:(CGFloat)maxY
{
    _curTouchPointHeight = maxY;
    
    NSLog(@"请填写订单补充说明 Point === %f", maxY);
}

#pragma mark - PostageStateManagerDelegate
- (void)delegateForPostageManeger:(NSInteger)selectedIndex;
{
    NSLog(@"传回选项数据==第 %ld 方式", (long)selectedIndex);
    if (selectedIndex == 0) {
        [postageCell setPostageWayChangeForHelpSelf:YES];
        
    } else {
        [postageCell setPostageWayChangeForHelpSelf:NO];
    }
}

#pragma mark - OrderPayTypeCellDelegate

- (void)payChooseEditActionDelegate:(OrderPayTypeCell *)cell withTextfieldMaxY:(CGFloat)maxY
{
    _curTouchPointHeight = maxY;
    
    NSLog(@"请填写使用积分数 Point === %f", maxY);
}

- (void)payChoosePayTypeActionDelegate:(OrderPayTypeCell *)cell withPayType:(PayTypes)type
{
    if (type == GoodsPayTypesWithAlipay) {
        NSLog(@"支付宝支付");
    } else if (type == GoodsPayTypesWithWeChat) {
        NSLog(@"微信支付");
    }
}

#pragma mark - 确认下单
- (IBAction)orderAction:(UIButton *)sender {
    NSLog(@"确认下单");
    
    MBProgressHUD *HUD = [Util createHUD];
    HUD.labelText = @"正在提交订单";
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_fail"]];
    HUD.labelText = @"提交订单失败";
    [HUD hide:YES afterDelay:5];
    [NSThread sleepForTimeInterval:3];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        OrderPayStateController *payStateCtl = [[OrderPayStateController alloc] initWithPayState:NO withConsigNee:self.consignee withPrice:self.price];
        [self.navigationController pushViewController:payStateCtl animated:YES];
    });
    
    
    /*
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"支付结果" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"成功" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        OrderPayStateController *payStateCtl = [[OrderPayStateController alloc] initWithPayState:YES];
        [self.navigationController pushViewController:payStateCtl animated:YES];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"失败" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        OrderPayStateController *payStateCtl = [[OrderPayStateController alloc] initWithPayState:NO];
        [self.navigationController pushViewController:payStateCtl animated:YES];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
     */
    
    
}

#pragma mark - 软键盘隐藏
- (void)keyBoardHiden:(UITapGestureRecognizer *)tap
{
    [self.view removeGestureRecognizer:_tap];
}

- (void)keyboardAction:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval timeInt;
    [animationDuration getValue:&timeInt];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyBoradHeight = keyboardRect.size.height;
    if (keyBoradHeight <= 0) {
        return;
    }
    
    
    CGFloat offestY = kScreen_Height - keyBoradHeight;
    CGFloat paading = 10;
    __block CGFloat moveY;
    if (_curTouchPointHeight > offestY) {
        moveY = _curTouchPointHeight - offestY + paading;
    }else{
        moveY = 0;
    }
    
    if (notification.name == UIKeyboardWillShowNotification) {
        if (isShowKeyboard == NO) {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 CGRect oldFrame = self.tableView.frame;
                                 oldFrame.origin.y -= moveY;
                                 self.tableView.frame = oldFrame;
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
            
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
            [self.view addGestureRecognizer:_tap];
        }
        
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        [UIView animateWithDuration:-timeInt
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect oldFrame = self.tableView.frame;
                             oldFrame.origin.y = 64;
                             self.tableView.frame = oldFrame;
                         } completion:^(BOOL finished) {
                             isShowKeyboard = NO;
                         }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
