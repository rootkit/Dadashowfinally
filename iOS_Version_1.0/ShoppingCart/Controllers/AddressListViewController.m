//
//  AddressListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  收货地址列表 *******/
#import "AddressListViewController.h"
#import "AddressEditViewController.h"
#import "AddressListCell.h"
#import "DDXConsignee.h"

#import "UIColorHF.h"

@interface AddressListViewController () <UITableViewDelegate, UITableViewDataSource, AddressListCellDelegate>
{
    BOOL _isSelected;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) NSMutableArray <DDXConsignee *> *contents;

@end

@implementation AddressListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _contents = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择收货地址";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BackCellColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressListCell" bundle:nil] forCellReuseIdentifier:AddressListCellIdentifier];
    
    self.addBtn.layer.shadowColor = ThemeColor.CGColor;
    self.addBtn.layer.shadowOffset = CGSizeMake(2, 2);
    self.addBtn.layer.shadowOpacity = 0.8;
    
    [self fetchUserList:YES];
    self.tableView.mj_header = [HZNormalHeader headerWithRefreshingBlock:^{
        [self fetchUserList:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];//加载完成停止结束刷新
            
        });
    }];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.tableView configReloadAction:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.tableView hideAllGeneralPage];
        [strongSelf.tableView beginLoading];
        [strongSelf fetchUserList:YES];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchUserList:(BOOL)isRefresh
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_FINDCONSIGNEE, [DDXUserinfo getUserCode]];
    NSLog(@"code= %@", [DDXUserinfo getUserCode]);
    [DaHttpTool post:strUrl
              params:@{}.mutableCopy
             success:^(id json) {
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 NSMutableArray *models = [NSMutableArray new];
                 
                 if (isSuccess) {
                     if ([json[@"content"] isKindOfClass:[NSArray class]]) {
                         models = [NSArray osc_modelArrayWithClass:[DDXConsignee class] json:json[@"content"]].mutableCopy;
                     } else if ([json[@"content"] isKindOfClass:[NSString class]]) {
                         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                         hud.mode = MBProgressHUDModeText;
                         hud.margin=10;
                         hud.labelFont=[UIFont boldSystemFontOfSize:13];
                         hud.detailsLabelText = json[@"content"];
                         [hud hide:YES afterDelay:1.5];
                     }

                     if (models.count > 0) {
                         if (isRefresh) {
                             [self.contents removeAllObjects];
                         }
                         
                         [self.contents addObjectsFromArray:models];
                     }
                     
                 } else {
                     
                     MBProgressHUD *HUD = [Util createHUD];
                     HUD.mode = MBProgressHUDModeCustomView;
                     HUD.labelText = json[@"content"][@"statusMsg"];
                     
                     [HUD hide:YES afterDelay:5];
                 }
                 
                 self.bottomView.hidden = NO;
                 if (self.contents.count == 0) {
                     [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_none"]
                                                            tip:@"小搭未发现任何数据"];

                 }
                 
                 self.bottomView.hidden = NO;
                 [self saveDefaultAddress];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (isRefresh) {
                         [self.tableView.mj_header endRefreshing];
                     }
                     [self.tableView reloadData];
                 });
             } failure:^(NSError *error) {
                 
                 if (isRefresh) {
                     [self.tableView.mj_header endRefreshing];
                 }
                 
                 if (self.contents.count == 0) {
                     self.bottomView.hidden = YES;
                     [self.tableView showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                            tip:@"与母星暂时失去联系啦"
                                                    buttonTitle:@"刷新"];
                 } else {
                     self.bottomView.hidden = NO;
                 }
                 
                 NSLog(@"error = %@", [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]]);
             }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCell *cell = [AddressListCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:AddressListCellIdentifier];
    cell.delegate = self;
    
    if (self.contents.count) {
        cell.consignee = self.contents[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 141;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DDXConsignee *consignee = self.contents[indexPath.row];
    
    if (self.changeOrderAddressBlock) {
        self.changeOrderAddressBlock(consignee);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - AddressListCellDelegate
- (void)chooseDefaultAddressAction:(AddressListCell *)cell indexPath:(NSInteger)indexPath
{
    if (cell.consignee.isDefault == 0) {
        _isSelected = !_isSelected;
        
        NSLog(@"默认选择%ld %@", (long)indexPath, (_isSelected ? @"默认" : @"不默认"));
        
        DDXConsignee *consignee = self.contents[indexPath];
        
        [cell chooseDefaultAddressIMG:_isSelected];
        [self chooseDefault:consignee];
    }
    
}
- (void)editingAddressAction:(AddressListCell *)cell indexPath:(NSInteger)indexPath
{
    NSLog(@"编辑%ld", (long)indexPath);

    AddressEditViewController *editCtl = [[AddressEditViewController alloc] initWithMessage:YES consignee:cell.consignee];
    editCtl.rightbtnishide = YES;
    [self.navigationController pushViewController:editCtl animated:YES];
    
    __weak typeof(self) weakSelf = self;
    editCtl.saveaddressblock = ^(){
        [weakSelf fetchUserList:YES];
        
    };
}
- (void)deleteAddressAction:(AddressListCell *)cell indexPath:(NSInteger)indexPath
{
    NSLog(@"删除%ld", (long)indexPath);
    NSIndexPath *inPath = [self.tableView indexPathForCell:cell];
    [self deleteUserConsignee:inPath.row];
}

#pragma mark - fetch

- (void)chooseDefault:(DDXConsignee *)consignee
{
    NSMutableDictionary *consigneeDic = [NSMutableDictionary new];
    consignee.isDefault = ConsigneeAddressTypeForDefault;
    
    [consigneeDic setValue:consignee.consignee forKey:@"consignee"];
    [consigneeDic setValue:consignee.mobile forKey:@"mobile"];
    [consigneeDic setValue:consignee.address forKey:@"address"];
    [consigneeDic setValue:consignee.province forKey:@"province"];
    [consigneeDic setValue:consignee.city forKey:@"city"];
    [consigneeDic setValue:consignee.district forKey:@"district"];
    [consigneeDic setObject:@(1) forKey:@"provinceId"];
    [consigneeDic setObject:@(1) forKey:@"cityId"];
    [consigneeDic setObject:@(1) forKey:@"districtId"];
    [consigneeDic setObject:@(1) forKey:@"isDefault"];
    [consigneeDic setObject:@(consignee.id)forKey:@"id"];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@&orderConsignee=%@", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_MODIFYCONSIGNEE, [DDXUserinfo getUserCode], [Util jsonBase64AndUrlEncoder:[Util dictionaryToJson:consigneeDic]]];
    
    [DaHttpTool post:strUrl
              params:nil
             success:^(id json) {
                 //
                 NSLog(@"success = %@", json);
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 if (isSuccess) {
                     NSLog(@"success .... ");
                     [self fetchUserList:YES];
                     
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
                 hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 [hud hide:YES afterDelay:1.5];
             }];
}

- (void)deleteUserConsignee:(NSInteger)consigneeIndex
{
    DDXConsignee *consignee = self.contents[consigneeIndex];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@&consigneeId=%ld", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_DELCONSIGNEE, [DDXUserinfo getUserCode], (long)consignee.id];
    
    [DaHttpTool post:strUrl
            params:@{}.mutableCopy
           success:^(id json) {
               //
               NSLog(@"success = %@", json);
               BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
               
               if (isSuccess) {
                   
                   [self.contents removeObjectAtIndex:consigneeIndex];
                   [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:consigneeIndex inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                   [self saveDefaultAddress];
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
               hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
               [hud hide:YES afterDelay:1.5];
           }];
}

#pragma mark - newAddressAction
- (IBAction)newAddressAction:(UIButton *)sender {
    AddressEditViewController *editCtl = [[AddressEditViewController alloc] initWithMessage:NO consignee:[DDXConsignee new]];
    editCtl.rightbtnishide=NO;
    __weak typeof(self) weakSelf = self;
    editCtl.saveaddressblock=^(){
         [weakSelf fetchUserList:YES];
       
    };
    [self.navigationController pushViewController:editCtl animated:YES];
}

- (void)saveDefaultAddress
{
    [self.contents enumerateObjectsUsingBlock:^(DDXConsignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        if (obj.isDefault == ConsigneeAddressTypeForDefault) {
            [DDXConsignee deleteUserDefaultAddress];
            [DDXConsignee saveUserDefaulrAddress:obj];
        }
    }];
}

@end
