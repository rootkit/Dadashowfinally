//
//  ForgetViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ForgetViewController.h"
#import "ReplacementViewController.h"

@interface ForgetViewController () <UITextFieldDelegate>

@property(nonatomic,strong) UITextField* phonenubfield;
@property(nonatomic,strong)  UITextField* codefield;
@property (nonatomic, assign) NSInteger numTimer; /**< 计数 */
@property(nonatomic,strong) UIButton * getcodebtn;
@property (nonatomic, strong) NSTimer *timer; /**< 验证码定时器 */
@property(nonatomic, strong) UIButton *forgetbtn;

@end

@implementation ForgetViewController{
    UITapGestureRecognizer *_tap;
    BOOL isTruePhoneNumber;
    BOOL isStartVer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title = @"手机验证 ";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*(kScreen_Height/667)],

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
    
    [self.timer invalidate];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init

-(void)settextefield
{
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
    titleLb.text = @"手机验证";
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
    phonenubfield.placeholder=@"请输入您的手机号:";
    phonenubfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    phonenubfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    phonenubfield.delegate = self;
    phonenubfield.tintColor = [UIColor themeColor];
    [phonenubfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:phonenubfield];
    [phonenubfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).with.offset(70*(kScreen_Height/667));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(@(-23*(kScreen_Height/667)));
        make.height.equalTo(@(39*(kScreen_Height/667)));
   
    }];
    _phonenubfield = phonenubfield;
    
    UILabel* line1=[[UILabel alloc]init];
    [line1 setBackgroundColor:[UIColor colorWithHex:0xececec]];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phonenubfield.mas_bottom).equalTo(@(1*(kScreen_Height/667)));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(@(-23*(kScreen_Height/667)));
        make.height.equalTo(@(1*(kScreen_Height/667)));
    }];
    
    UIButton * getcodebtn=[[UIButton alloc]init];
    [getcodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getcodebtn.layer.cornerRadius = 2;
    getcodebtn.layer.borderColor = BackCellColor.CGColor;
    getcodebtn.layer.borderWidth = 1;
    [getcodebtn setTitleColor:ButtonDissableLBackgroundColor forState:UIControlStateNormal];
    getcodebtn.titleLabel.font=[UIFont systemFontOfSize:16*(kScreen_Height/667)];
    [getcodebtn addTarget:self action:@selector(getcode) forControlEvents:UIControlEventTouchUpInside];
    getcodebtn.enabled = NO;
    [self.view addSubview:getcodebtn];
    
    [getcodebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.right.equalTo(line1.mas_right);
        make.width.equalTo(@(105*(kScreen_Height/667)));
        make.height.equalTo(@(39*(kScreen_Height/667)));
        
    }];
    _getcodebtn=getcodebtn;
//
    UITextField* codefield=[self getTheNormalTF];
    codefield.backgroundColor=[UIColor clearColor];
    codefield.placeholder=@"输入验证码:";
    codefield.clearButtonMode = UITextFieldViewModeWhileEditing;
    codefield.keyboardType = UIKeyboardTypeASCIICapable;
    codefield.tintColor = [UIColor themeColor];
    codefield.delegate = self;
    [codefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:codefield];
    [codefield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@(23*(kScreen_Height/667)));
        make.right.equalTo(getcodebtn.mas_left).equalTo(@(-10*(kScreen_Height/667)));
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
    
    UIButton * forgetbtn=[[UIButton alloc]init];
    [forgetbtn setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
    [forgetbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [forgetbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetbtn.titleLabel.font=[UIFont systemFontOfSize:16*(kScreen_Height/667)];
    [forgetbtn addTarget:self action:@selector(nextstep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetbtn];
    forgetbtn.enabled = NO;
    _forgetbtn = forgetbtn;
    [forgetbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).equalTo(@(45*(kScreen_Height/667)));
        make.width.equalTo(@(300*(kScreen_Height/667)));
        make.left.equalTo(@((kScreen_Width-(300*(kScreen_Height/667)))/2));
        make.height.equalTo(@(45*(kScreen_Height/667)));
        
    }];
//
}

/**
 *  定时器的响应方式
 */
- (void)timersStart {
    
    self.numTimer--;
    [self.getcodebtn setTitle:[NSString stringWithFormat:@"%d秒后重试", (int)self.numTimer] forState:UIControlStateNormal];
    [_getcodebtn setTitleColor:ButtonDissableLBackgroundColor forState:UIControlStateNormal];
    _getcodebtn.enabled = NO;
    if (self.numTimer == 0) {
  
        [self.getcodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self verButtonState];
        [self.timer invalidate];
        self.getcodebtn.enabled = YES;
    }
}

- (void)verButtonState
{
    if (_phonenubfield.text.length > 0) {
        [_getcodebtn setTitleColor:ButtonNormalLBackgroundColor forState:UIControlStateNormal];
        self.getcodebtn.enabled = YES;
    } else {
        [_getcodebtn setTitleColor:ButtonDissableLBackgroundColor forState:UIControlStateNormal];
        self.getcodebtn.enabled = NO;
    }
}


- (UITextField *)getTheNormalTF
{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor redColor];
    textField.font = [UIFont systemFontOfSize:14.0f];
//    textField.textColor = [UIColor colorWithHex:0xAEAEAE];
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
    if (_phonenubfield.text.length > 11) {
        textfield.text = [textfield.text substringToIndex:11];
    } else if (_phonenubfield.text.length == 11) {
        if ([Util validateMobile:_phonenubfield.text]) {
            //匹配成功
            [_getcodebtn setTitleColor:ButtonNormalLBackgroundColor forState:UIControlStateNormal];
            _getcodebtn.enabled = YES;
            isTruePhoneNumber = YES;
        } else {
            //不是正确的手机号码
            MBProgressHUD *HUD = [Util createHUD];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText = @"请填写正确格式的手机号码";
            
            [HUD hide:YES afterDelay:1.0];
            [_getcodebtn setTitleColor:ButtonDissableLBackgroundColor forState:UIControlStateNormal];
            _getcodebtn.enabled = NO;
            isTruePhoneNumber = NO;
        }
    } else if (_phonenubfield.text.length < 11) {
        [_getcodebtn setTitleColor:ButtonDissableLBackgroundColor forState:UIControlStateNormal];
        _getcodebtn.enabled = NO;
        isTruePhoneNumber = NO;
    }
    
    [self buttonStateEnable];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
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
    if (isTruePhoneNumber && _codefield.text.length > 0) {
        [_forgetbtn setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [_forgetbtn setTitleColor:ButtonNormalTextColor forState:UIControlStateNormal];
        _forgetbtn.enabled = YES;
    } else {
        [_forgetbtn setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
        [_forgetbtn setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
        _forgetbtn.enabled = NO;
    }
}

#pragma mark - button action

-(void)getcode
{
    NSLog(@"获取验证码");
    
    [DaHttpTool get:[NSString stringWithFormat:@"%@%@%@/%@/2", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_SENDVERIFYCODE, _phonenubfield.text]
             params:nil
            success:^(id json) {
                NSLog(@"success json = %@", json);
                
                if ([json[@"state"] isEqualToString:@"success"]) {
                    self.numTimer = 60;
                    self.getcodebtn.enabled = NO;
                    [self.getcodebtn setTitle:[NSString stringWithFormat:@"%ld秒后重试", (long)self.numTimer] forState:UIControlStateNormal];
                    [_getcodebtn setTitleColor:ButtonDissableLBackgroundColor forState:UIControlStateNormal];
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timersStart) userInfo:nil repeats:YES];
                } else {
                
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                    hud.mode = MBProgressHUDModeText;
                    hud.margin=10;
                    hud.labelFont=[UIFont boldSystemFontOfSize:13];
                    hud.detailsLabelText = json[@"content"][@"statusMsg"];
                    [hud hide:YES afterDelay:1.5];
                    
                }
            } failure:^(NSError *error) {
                NSLog(@"error = %@", error);
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                hud.mode = MBProgressHUDModeText;
                hud.margin=10;
                hud.labelFont=[UIFont boldSystemFontOfSize:13];
                hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                [hud hide:YES afterDelay:1.5];
            }];
}


-(void)nextstep
{
    NSLog(@"下一步");
    
    [DaHttpTool post:[NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_EDITPASSWARDFIRST]
              params:@{
                       @"mobile"     : _phonenubfield.text,
                       @"verifyCode" : _codefield.text
                       }.mutableCopy
             success:^(id json) {
                 if ([json[@"state"] isEqualToString:@"success"]) {

                     [self presentViewController:[[ReplacementViewController alloc] initWithPhoneNumber:_phonenubfield.text] animated:YES completion:nil];
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
                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                 hud.mode = MBProgressHUDModeText;
                 hud.margin=10;
                 hud.labelFont=[UIFont boldSystemFontOfSize:13];
                 hud.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                 [hud hide:YES afterDelay:1.5];
             }];

}


@end
