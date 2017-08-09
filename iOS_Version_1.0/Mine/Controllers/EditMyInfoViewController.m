//
//  EditMyInfoViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 修改昵称/个性签名 *****/
#import "EditMyInfoViewController.h"

#define rating kScreen_Width/375
@interface EditMyInfoViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIView *nickNameView;
@property (nonatomic, strong) UIView *descView;

@property (nonatomic, strong) UITextField *nickNameTF;
@property (nonatomic, strong) UITextView *descTV;
@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, assign) BOOL isNickname;

@end

@implementation EditMyInfoViewController

- (instancetype)initWithNickname:(BOOL)isNickname
{
    self = [super init];
    if (self) {
        self.title = isNickname ? @"昵称" : @"个性签名";
        self.isNickname = isNickname;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackCellColor;
    [self.view addSubview:self.nickNameView];
    [self.view addSubview:self.descView];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKayboard)]];
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.enabled = NO;
    [saveBtn setTitleColor:BackCellColor forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:18*rating];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn  = saveBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - target
- (void)hiddenKayboard
{
    [_nickNameTF resignFirstResponder];
    [_descTV resignFirstResponder];
}

#pragma mark - save 
- (void)saveAction
{
    NSLog(@"save");

    NSMutableDictionary *param = @{
                                   @"id"   : [DDXUserinfo getUserId] > 0 ? @([DDXUserinfo getUserId]) : @(0),
                                   @"code" : [DDXUserinfo getUserCode].length > 0 ? [DDXUserinfo getUserCode] : @"",
                                   }.mutableCopy;
    if (self.isNickname) {
        [param setObject:self.nickNameTF.text forKey:@"alias"];
    } else {
        [param setObject:self.descTV.text forKey:@"personality"];
    }
    NSString *strUrl = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_USERINFO_EDIT];
    
    [DaHttpTool post:strUrl
              params:param
             success:^(id json) {
                 //
                 NSLog(@"json==== %@", json);
                 MBProgressHUD *HUD = [Util createHUD];
                 HUD.mode = MBProgressHUDModeCustomView;
                 HUD.labelText = json[@"content"][@"statusMsg"];
                 
                 [HUD hide:YES afterDelay:5];
                 
                 if ([json[@"state"] isEqualToString:@"success"]) {
                     DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
                     if (self.isNickname) {
                         userInfo.alias = self.nickNameTF.text;
                     } else {
                         userInfo.personality = self.descTV.text;
                     }
                     
                     [DDXUserinfo saveUserInfoToSanbox:userInfo];
                     [self.navigationController popViewControllerAnimated:YES];
                 }

             } failure:^(NSError *error) {
                 NSLog(@"error === %@", error);
                 
                 MBProgressHUD *HUD = [Util createHUD];
                 HUD.mode = MBProgressHUDModeCustomView;
                 HUD.labelText = @"网络错误!";
                 
                 [HUD hide:YES afterDelay:5];
             }];
}

#pragma mark - init

- (UIView *)nickNameView
{
    if (!_nickNameView) {
        _nickNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+10*rating, kScreen_Width, 30*rating)];
        _nickNameView.backgroundColor = [UIColor whiteColor];
        _nickNameView.hidden = !_isNickname;
        
        UILabel *tagLabel = [UILabel new];
        tagLabel.text = @"昵称";
        tagLabel.textColor = InfoTextColor;
        tagLabel.font = [UIFont systemFontOfSize:14*rating];
        [_nickNameView addSubview:tagLabel];
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12*rating));
            make.centerY.equalTo(_nickNameView);
            make.width.equalTo(@(33*rating));
        }];
        
        UITextField *nickNameTF = [UITextField new];
        nickNameTF.placeholder = @"请输入你的新昵称";
        nickNameTF.text = [DDXUserinfo loadUserInfoFromSanbox].alias;
        nickNameTF.font = [UIFont systemFontOfSize:14*rating];
        nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        nickNameTF.tintColor = ThemeColor;
        [nickNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _nickNameTF = nickNameTF;
        [_nickNameView addSubview:nickNameTF];
        [nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tagLabel.mas_right).with.offset(4*rating);
            make.centerY.equalTo(_nickNameView);
            make.right.equalTo(@(-12*rating));
        }];
    }
    
    return _nickNameView;
}

- (UIView *)descView
{
    if (!_descView) {
        _descView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+10*rating, kScreen_Width, 158*rating)];
        _descView.backgroundColor = [UIColor whiteColor];
        _descView.hidden = _isNickname;
        
        UITextView *descTextView = [UITextView new];
        descTextView.text = [DDXUserinfo loadUserInfoFromSanbox].personality;
        descTextView.font = [UIFont systemFontOfSize:14*rating];
        descTextView.tintColor = ThemeColor;
        descTextView.delegate = self;
        [_descView addSubview:descTextView];
        _descTV = descTextView;
        [descTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12*rating));
            make.top.equalTo(@(12*rating));
            make.right.equalTo(@(-12*rating));
        }];
        
        UILabel *tagLb = [UILabel new];
        tagLb.text = @"30个字";
        tagLb.textColor = [UIColor colorWithHex:0xefefef];
        tagLb.font = [UIFont systemFontOfSize:17*rating];
        [_descView addSubview:tagLb];
        [tagLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(descTextView.mas_bottom).with.offset(10*rating);
            make.right.equalTo(@(-18*rating));
            make.bottom.equalTo(@(-18*rating));
            make.height.equalTo(@(14*rating));
        }];
    }
    return _descView;
}

#pragma mark - textfield delegate
- (void)textFieldDidChange:(UITextField *)textfield
{
    if (textfield.text.length > 0) {
        _saveBtn.enabled = YES;
        [_saveBtn setTitleColor:FirstTextColor forState:UIControlStateNormal];
    } else {
        _saveBtn.enabled = NO;
        [_saveBtn setTitleColor:BackCellColor forState:UIControlStateNormal];
    }
}

#pragma mark - textview delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    if (_descTV.text.length > 0) {
        _saveBtn.enabled = YES;
        [_saveBtn setTitleColor:FirstTextColor forState:UIControlStateNormal];
    } else {
        _saveBtn.enabled = NO;
        [_saveBtn setTitleColor:BackCellColor forState:UIControlStateNormal];
    }
}

@end
