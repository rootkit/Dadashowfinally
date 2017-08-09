//
//  ReplacementViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ReplacementViewController.h"
#import "UIColor+CustomColor.h"
@interface ReplacementViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField * phonenubfield;
@property(nonatomic,strong) UITextField * codefield;
@property(nonatomic,strong) UIButton * postBtn;
@property (nonatomic, copy) NSString *mobilePhoneNumber;
@end

@implementation ReplacementViewController
{
    UITapGestureRecognizer *_tap;
}

- (instancetype)initWithPhoneNumber:(NSString *)numberString
{
    self = [super init];
    if (self) {
        _mobilePhoneNumber = numberString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"重置密码 ";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18*(kScreen_Height/667)],
       
       
       NSForegroundColorAttributeName:[UIColor colorWithHex:0x535353]}];
    [self settextefield];
    /*
    //软键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
     */
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
    [self.view addGestureRecognizer:_tap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init

-(void)settextefield{
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"btn-back"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(29*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));
        make.width.equalTo(@(32*(kScreen_Height/667)));
    }];
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"重置密码";
    titleLb.textColor = InfoTextColor;
    titleLb.font = [UIFont systemFontOfSize:18*(kScreen_Height/667)];
    [self.view addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(backBtn);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = BackCellColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(titleLb.mas_bottom).with.offset(12*(kScreen_Height/667));
        make.height.equalTo(@(0.5));
    }];
    
    UITextField* phonenubfield=[self getTheNormalTF];
    phonenubfield.backgroundColor=[UIColor clearColor];
    phonenubfield.placeholder=@"请输入6~16位的新密码:";
    phonenubfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    phonenubfield.keyboardType = UIKeyboardTypeASCIICapable;
    phonenubfield.tintColor = [UIColor themeColor];
    [self.view addSubview:phonenubfield];
    [phonenubfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(70*(kScreen_Height/667));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(@(-23*(kScreen_Height/667)));
        make.height.equalTo(@(39*(kScreen_Height/667)));
        
    }];
    phonenubfield.delegate = self;
    [phonenubfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _phonenubfield=phonenubfield;

    UILabel* line1=[[UILabel alloc]init];
    [line1 setBackgroundColor:[UIColor colorWithHex:0xececec]];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phonenubfield.mas_bottom).equalTo(@(1*(kScreen_Height/667)));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(@(-23*(kScreen_Height/667)));
        make.height.equalTo(@(1*(kScreen_Height/667)));
    }];
    
    //
    UITextField* codefield=[self getTheNormalTF];
    codefield.backgroundColor=[UIColor clearColor];
    codefield.placeholder=@"请再次输入新密码:";
    codefield.clearButtonMode = UITextFieldViewModeWhileEditing;
    codefield.keyboardType = UIKeyboardTypeASCIICapable;
    codefield.tintColor = [UIColor themeColor];
    codefield.delegate = self;
    [codefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:codefield];
    [codefield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(@(-23*(kScreen_Height/667)));
        make.height.equalTo(@(39*(kScreen_Height/667)));
        
    }];
    _codefield=codefield;
    
    //
    UILabel* line2=[[UILabel alloc]init];
    [line2 setBackgroundColor:[UIColor colorWithHex:0xececec]];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codefield.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(@(-23*(kScreen_Height/667)));
        make.height.equalTo(@(1*(kScreen_Height/667)));
    }];
    
    UIButton * surebtnbtn=[[UIButton alloc]init];
    [surebtnbtn setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
    [surebtnbtn setTitle:@"确认" forState:UIControlStateNormal];
    [surebtnbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    surebtnbtn.titleLabel.font=[UIFont systemFontOfSize:16*(kScreen_Height/667)];
    [surebtnbtn addTarget:self action:@selector(surebtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:surebtnbtn];
    [surebtnbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).equalTo(@(45*(kScreen_Height/667)));
        make.width.equalTo(@(300*(kScreen_Height/667)));
        make.left.equalTo(@((kScreen_Width-(300*(kScreen_Height/667)))/2));
        make.height.equalTo(@(45*(kScreen_Height/667)));
        
    }];
    surebtnbtn.enabled = NO;
    _postBtn = surebtnbtn;
    //
}
-(void)surebtn{
    NSLog(@"确认");
    [_phonenubfield resignFirstResponder];
    [_codefield resignFirstResponder];
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_EDITPASSWARDSECOND];
    
    [DaHttpTool post:str
              params:@{
                       @"mobile"   : _mobilePhoneNumber,
                       @"password" : _phonenubfield.text
                       }.mutableCopy
             success:^(id json) {
                 if ([json[@"state"] isEqualToString:@"success"]) {
                     [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                 } else {
                     
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                     hud.mode = MBProgressHUDModeText;
                     hud.margin=10;
                     hud.labelFont=[UIFont boldSystemFontOfSize:13];
                     hud.detailsLabelText = json[@"content"][@"statusMsg"];
                     [hud hide:YES afterDelay:1.5];
                 }
                 NSLog(@"success json = %@", json);
             } failure:^(NSError *error) {
                 //
                 NSLog(@"failure json = %@", error);
                 
                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                 hud.mode = MBProgressHUDModeText;
                 hud.margin=10;
                 hud.labelFont=[UIFont boldSystemFontOfSize:13];
                 hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 [hud hide:YES afterDelay:1.5];
             }];
}

- (UITextField *)getTheNormalTF
{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor redColor];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = [UIColor colorWithHex:0xAEAEAE];
    textField.delegate = self;
    return textField;
}

- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textfield
{
    [self buttonStateEnable];
    
    if (textfield == _codefield) {
        if (![_phonenubfield.text hasPrefix:textfield.text]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
            hud.mode = MBProgressHUDModeText;
            hud.margin=10;
            hud.labelFont=[UIFont boldSystemFontOfSize:13];
            hud.detailsLabelText = @"再次输入的新密码与第一次输入的新密码不一致";
            [hud hide:YES afterDelay:1.5];
        }
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self buttonStateEnable];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self buttonStateEnable];
}

#pragma mark - 软键盘隐藏
- (void)keyBoardHiden:(UITapGestureRecognizer *)tap
{
    [_phonenubfield resignFirstResponder];
    [_codefield resignFirstResponder];
    
//    [self.view removeGestureRecognizer:_tap];
}

- (void)keyboardAction:(NSNotification *)notification
{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
    [self.view addGestureRecognizer:_tap];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 按钮状态

- (void)buttonStateEnable
{
    if ([_phonenubfield.text isEqualToString:_codefield.text] &&  _phonenubfield.text.length >= 6 && _phonenubfield.text.length <= 16) {
        [_postBtn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [_postBtn setTitleColor:ButtonNormalTextColor forState:UIControlStateNormal];
        _postBtn.enabled = YES;
    } else {
        [_postBtn setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
        [_postBtn setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
        _postBtn.enabled = NO;
    }
}

@end
