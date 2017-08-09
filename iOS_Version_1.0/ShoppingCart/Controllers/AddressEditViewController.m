//
//  AddressEditViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  编辑/修改地址 *******/
#import "AddressEditViewController.h"
#import "PhoneNumListController.h"

#import "AddressEditCell.h"
#import "MBProgressHUD.h"
#import "BLAreaPickerView.h"

@interface AddressEditViewController () <UITableViewDelegate, UITableViewDataSource, AddressEditCellDelegate, UITextFieldDelegate, BLPickerViewDelegate>
{
    UIButton *delBtn;
    BOOL isTruePhoneNumber;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) DDXConsignee *consignee;
@property (nonatomic, strong) NSMutableDictionary *consigneeDic;
@property (nonatomic, strong) BLAreaPickerView *pickView;
@property (nonatomic, copy) NSString *provinceString;

@property (nonatomic, assign) BOOL isEditing;

@end

@implementation AddressEditViewController

- (instancetype)initWithMessage:(BOOL)isEditing consignee:(DDXConsignee *)consig
{
    self = [super init];
    if (self) {
        //
        
        self.title = isEditing ? @"修改地址" : @"新增地址";
        self.isEditing = isEditing;
        self.consignee = consig;
        self.consigneeDic = [NSMutableDictionary new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"电话号码 = %@", self.phoneNum);
//    self.consignee.mobile = self.phoneNum;
    [self.consigneeDic setValue:self.phoneNum forKey:@"mobile"];
    
    if (self.isEditing) {
        [self.consigneeDic setValue:self.consignee.mobile forKey:@"mobile"];
        [self.consigneeDic setValue:@(self.consignee.isDefault) forKey:@"isDefault"];
        [self.consigneeDic setValue:self.consignee.consignee forKey:@"consignee"];
        [self.consigneeDic setValue:self.consignee.address forKey:@"address"];
        [self.consigneeDic setValue:self.consignee.province forKey:@"province"];
        [self.consigneeDic setValue:self.consignee.city forKey:@"city"];
        [self.consigneeDic setValue:self.consignee.district forKey:@"district"];
        [self.consigneeDic setObject:@(1) forKey:@"provinceId"];
        [self.consigneeDic setObject:@(1) forKey:@"cityId"];
        [self.consigneeDic setObject:@(1) forKey:@"districtId"];
        [self.consigneeDic setObject:@(self.consignee.id) forKey:@"id"];
    }
    
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.rightbtnishide) {
        delBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 28)];
        [delBtn setTitle:@"删除" forState:UIControlStateNormal];
        [delBtn setTitleColor:SecondTextColor forState:UIControlStateNormal];
        delBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [delBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:delBtn];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressEditCell" bundle:nil] forCellReuseIdentifier:AddressEditCellIdentifier];
    
    self.saveBtn.layer.shadowColor = ThemeColor.CGColor;
    self.saveBtn.layer.shadowOffset = CGSizeMake(2, 2);
    self.saveBtn.layer.shadowOpacity = 0.8;
    
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)]];
    self.tableView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - hidden keyboard
- (void)hiddenKeyBoard
{
    [self.tableView endEditing:YES];
}

#pragma mark - fetch data

- (void)editNewUserConsignee
{

    if (self.consignee.consignee.length==0) {
        [self SetHudMessage:@"联系人不能为空"];
        return;
    }
    

    if ( self.consignee.mobile.length==0) {
        [self SetHudMessage:@"联系电话不能为空"];
        return;
    }
    
    if ( self.consignee.mobile.length!=11) {
       [self SetHudMessage:@"联系电话必须11位数字"];
        return;
    }
    
    if ( self.consignee.address.length==0) {
        [self SetHudMessage:@"详细地址不能为空"];
        return;
    }
    
    if (!isTruePhoneNumber) {
        return;
    }

    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@&orderConsignee=%@", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_MODIFYCONSIGNEE, [DDXUserinfo getUserCode], [Util jsonBase64AndUrlEncoder:[Util dictionaryToJson:self.consigneeDic]]];
    
    [DaHttpTool post:strUrl
              params:nil
             success:^(id json) {
                 //
                 NSLog(@"success = %@", json);
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 if (isSuccess) {
                     NSLog(@"success .... ");
                     if (self.saveaddressblock) {
                         self.saveaddressblock();
                     }
                     [self.navigationController popViewControllerAnimated:YES];
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

-(void)SetHudMessage:(NSString*)message{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.mode = MBProgressHUDModeText;
    hud.margin=10;
    hud.labelFont=[UIFont boldSystemFontOfSize:13];
    hud.detailsLabelText = message;
    [hud hide:YES afterDelay:1.5];
}

- (void)deleteUserConsignee
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@?token=%@&consigneeId=%ld", DDXAPI_HTTP_PREFIX_Order, DDXAPI_SHOPORDER_OMS, DDXAPI_SHOPORDER_OMS_DELCONSIGNEE, [DDXUserinfo getUserCode], (long)self.consignee.id];
    
    [DaHttpTool post:strUrl
              params:@{}.mutableCopy
             success:^(id json) {
                 //
                 NSLog(@"success = %@", json);
                 BOOL isSuccess = [json[@"state"] isEqualToString:@"success"];
                 
                 if (isSuccess) {
                     if (self.saveaddressblock) {
                         self.saveaddressblock();
                     }
                     
                     [self.navigationController popViewControllerAnimated:YES];
                     
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressEditCell *cell = [AddressEditCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:AddressEditCellIdentifier];
    cell.delegate = self;

    cell.nameTF.text = self.consignee.consignee;
    cell.phoneNumTF.text = self.phoneNum.length ? self.phoneNum : self.consignee.mobile;
    cell.phoneNumTF.delegate = self;
    [cell.phoneNumTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    NSString *string = [NSString stringWithFormat:@"%@%@%@", self.consignee.province.length ? self.consignee.province : @"",
                                                             self.consignee.city.length ? self.consignee.city : @"",
                                                             self.consignee.district.length ? self.consignee.district : @""];
    cell.addressTF.text = string;//@"广东省深圳市南山区";
    cell.detailAdTF.text = self.consignee.address;//@"科兴科技园4A401";
    cell.defaultSwitch.on = (self.consignee.isDefault == ConsigneeAddressTypeForDefault ? YES : NO);//YES;
    [self.consigneeDic setValue:@(self.consignee.isDefault) forKey:@"isDefault"];

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - AddressEditCellDelegate
- (void)addressBookAction:(AddressEditCell *)cell
{
//    [self.navigationController pushViewController:[PhoneNumListController new] animated:YES];
}
- (void)locationAddressAction:(AddressEditCell *)cell
{
    NSLog(@"所在地区");
    [self.view endEditing:YES];
    _pickView = [[BLAreaPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    _pickView.pickViewDelegate = self;
    [_pickView bl_show];
}

- (void)addressChangeAction:(AddressEditCell *)cell
               textfieldTag:(NSInteger)tag
                 textString:(NSString *)textStr
{
    if (tag == 1) {
        self.consignee.consignee = textStr;
        [self.consigneeDic setValue:textStr forKey:@"consignee"];
    } else if (tag == 2) {

        self.consignee.mobile = textStr;
        [self.consigneeDic setValue:textStr forKey:@"mobile"];
    } else if (tag == 3) {
        self.provinceString=textStr;

    } else if (tag == 4) {

        self.consignee.address = textStr;
        [self.consigneeDic setValue:textStr forKey:@"address"];
    }
}

- (void)switchDefaultAddressAction:(AddressEditCell *)cell withSwitch:(UISwitch *)switchCt
{
    if (switchCt.on) {
        NSLog(@"设置默认");
        self.consignee.isDefault = ConsigneeAddressTypeForDefault;
    } else {
        NSLog(@"取消设置默认");
        self.consignee.isDefault = ConsigneeAddressTypeForUnDefault;
    }
    [self.consigneeDic setValue:@(self.consignee.isDefault) forKey:@"isDefault"];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 251;
}

- (void)deleteAction
{
    NSLog(@"删除地址");
    
    [self deleteUserConsignee];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textfield
{

        if (textfield.text.length > 11) {
            textfield.text = [textfield.text substringToIndex:11];
        } else if (textfield.text.length == 11) {
            if ([Util validateMobile:textfield.text]) {
                //匹配成功
                
                isTruePhoneNumber = YES;
            } else {
                //不是正确的手机号码
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = @"请填写正确格式的手机号码";
                
                [HUD hide:YES afterDelay:2];
                
                isTruePhoneNumber = NO;
            }
        } else if (textfield.text.length < 11) {
            
            isTruePhoneNumber = NO;
        }

}

#pragma mark - save
- (IBAction)saveAddressAction:(UIButton *)sender {
    NSLog(@"保存地址");
    
    [self editNewUserConsignee];
}

#pragma mark - - BLPickerViewDelegate
- (void)bl_selectedAreaResultWithProvince:(NSString *)provinceTitle city:(NSString *)cityTitle area:(NSString *)areaTitle{
    NSLog(@"%@,%@,%@",provinceTitle,cityTitle,areaTitle);
    
    self.provinceString = [NSString stringWithFormat:@"%@%@%@", provinceTitle, cityTitle, areaTitle];
    
    self.consignee.province = provinceTitle;
    self.consignee.city = cityTitle;
    self.consignee.district = areaTitle;
    
    [self.consigneeDic setValue:provinceTitle forKey:@"province"];
    [self.consigneeDic setValue:cityTitle forKey:@"city"];
    [self.consigneeDic setValue:areaTitle forKey:@"district"];
    [self.consigneeDic setObject:@(1) forKey:@"provinceId"];
    [self.consigneeDic setObject:@(1) forKey:@"cityId"];
    [self.consigneeDic setObject:@(1) forKey:@"districtId"];
    
    [self.tableView reloadData];
}

@end
