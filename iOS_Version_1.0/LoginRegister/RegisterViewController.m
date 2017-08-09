
//
//  RegisterViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColorHF.h"
#import "UIColor+CustomColor.h"

#import <Masonry/Masonry.h>

#define rating kScreen_Height/667
#define top_backBtn_padding 29*(kScreen_Height/667)
#define left_backBtn_padding 12*(kScreen_Height/667)
#define backBtn_width_equ_height 23*(kScreen_Height/667)

#define icon_width_equ_height 60*(kScreen_Height/667)
#define backBtn_icon_padding 25*(kScreen_Height/667)
//#define icon_TF_padding 64*(kScreen_Height/667)
#define top_phoneTFView_padding 171*(kScreen_Height/667)

#define left_TF_padding 37*(kScreen_Height/667)
#define right_TF_padding left_TF_padding
#define TF_height 45*(kScreen_Height/667)
#define TF_TF_padding 20*(kScreen_Height/667)

#define verificBtn_width 97*(kScreen_Height/667)

#define TF_forgetBtn_padding 12*(kScreen_Height/667)
#define forgetBtn_height 21*(kScreen_Height/667)
//#define forgetBtn_logBtn_padding 65*(kScreen_Height/667)  /////
#define forgetBtn_font 12*(kScreen_Height/667)

#define loginBtn_forgetBtn_padding 45*(kScreen_Height/667)
#define loginBtn_height 45*(kScreen_Height/667)

#define loginBtn_createBtn_padding 22*(kScreen_Height/667)
#define createBtn_height 24*(kScreen_Height/667)
#define createBtn_font 14*(kScreen_Height/667)

#define createBtn_thirdloginview_padding 50*(kScreen_Height/667)//80

#define top_line_padding 10*(kScreen_Height/667)
#define bottom_line_padding 10*(kScreen_Height/667)

#define label_Font 12*(kScreen_Height/667)
#define label_height 21*(kScreen_Height/667)
#define labe_button_padding 42*(kScreen_Height/667)

#define left_button_padding 80*(kScreen_Height/667)
#define Btn_Btn_padding 58*(kScreen_Height/667)
#define Btn_width 32*(kScreen_Height/667)
#define Btn_height 30*(kScreen_Height/667)

#define verfi_readBtn_padding 11*(kScreen_Height/667)
#define readBtn_W_H 15*(kScreen_Height/667)
#define readBtn_info_padding 7*(kScreen_Height/667)

#define animationView_height 284*(kScreen_Height/667)

#define View_centerX kScreen_Width/2

@interface RegisterViewController () <UITextFieldDelegate,UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UITextField *phoneNumberTF;
@property (nonatomic, strong) UITextField *passwardTF;
@property (nonatomic, strong) UITextField *verificTF;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *secretButton;
@property (nonatomic, strong) UIButton *verificButton;
@property (nonatomic, strong) UIButton *readButton;

@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIImageView *iconIMG;

@property (nonatomic, assign) NSInteger numTimer; /**< 计数 */
@property (nonatomic, strong) NSTimer *timer; /**< 验证码定时器 */
@property (nonatomic,strong) UIDocumentInteractionController *udic;
@end

@implementation RegisterViewController
{
    BOOL _isReadProtocol;
    CGFloat minY;
    UITapGestureRecognizer *_tap;
    
    BOOL isTruePhoneNumber;
    BOOL isStartVer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    [self.animationView addGestureRecognizer:_tap];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)]];
    
    [self layoutCustomView];
}

- (void)layoutCustomView
{
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"btn-back"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_backBtn_padding));
        make.left.equalTo(@(left_backBtn_padding));
        make.height.equalTo(@(Btn_height));
        make.width.equalTo(@(Btn_width));
    }];
    
    UIImageView *icon = [UIImageView new];
    [icon setImage:[UIImage imageNamed:@"icon"]];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backBtn.mas_bottom).with.offset(backBtn_icon_padding);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(icon_width_equ_height));
        make.height.equalTo(@(icon_width_equ_height));
    }];
    self.iconIMG = icon;
    
    /********/
    UIView *animationView = [UIView new];
    animationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:animationView];
    [animationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(top_phoneTFView_padding));
        make.left.equalTo(@(left_TF_padding));
        make.right.equalTo(@(-right_TF_padding));
        make.height.equalTo(@(animationView_height));
    }];
    self.animationView = animationView;
    
    /********/
    //
    UIView *phoneNumView = [UIView new];
    phoneNumView.backgroundColor = [UIColor colorWithHex:0xececec];
    [animationView addSubview:phoneNumView];
    phoneNumView.layer.cornerRadius = 2;
    
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.equalTo(@(0));//(icon.mas_bottom).with.offset(icon_TF_padding);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(TF_height));
    }];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"bg-box1"];
    [phoneNumView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(TF_height));
    }];
    
    UILabel *numLabel = [UILabel new];
    numLabel.text = @"+86";
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:14*rating];
    [phoneNumView addSubview:numLabel];
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(TF_height));
    }];
    
    _phoneNumberTF = [UITextField new];
    _phoneNumberTF.placeholder = @"请输入您的手机号";
    _phoneNumberTF.font = [UIFont systemFontOfSize:14*rating];
    _phoneNumberTF.tintColor = [UIColor themeColor];
    _phoneNumberTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [phoneNumView addSubview:_phoneNumberTF];
    _phoneNumberTF.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    _phoneNumberTF.delegate = self;
    [_phoneNumberTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_phoneNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(numLabel.mas_right).with.offset(17*rating);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    //
    UIView *passwView = [UIView new];
    passwView.backgroundColor = [UIColor colorWithHex:0xececec];
    passwView.layer.cornerRadius = 2;
    [animationView addSubview:passwView];
    
    [passwView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.equalTo(phoneNumView.mas_bottom).with.offset(TF_TF_padding);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(TF_height));
    }];
    
    _secretButton = [UIButton new];
    [_secretButton setImage:[UIImage imageNamed:@"btn-private"] forState:UIControlStateNormal];
    [passwView addSubview:_secretButton];
    [_secretButton addTarget:self action:@selector(changeSecretPWAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_secretButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(TF_height));
    }];
    
    _passwardTF = [UITextField new];
    _passwardTF.placeholder = @"请输入您的密码";
    _passwardTF.font = [UIFont systemFontOfSize:14*rating];
    _passwardTF.tintColor = [UIColor themeColor];
    _passwardTF.secureTextEntry = YES;
    _passwardTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwardTF.keyboardType = UIKeyboardTypeASCIICapable;
    [passwView addSubview:_passwardTF];
    _passwardTF.delegate = self;
    [_passwardTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(passwView.mas_left).with.offset(17*rating);
        make.right.equalTo(_secretButton.mas_left);//.with.offset(-10*rating);
        make.bottom.equalTo(@(0));
    }];
    
    //
    UIView *verificView = [UIView new];
    verificView.backgroundColor = [UIColor colorWithHex:0xececec];
    verificView.layer.cornerRadius = 2;
    [animationView addSubview:verificView];
    
    [verificView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.top.equalTo(passwView.mas_bottom).with.offset(TF_TF_padding);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(TF_height));
    }];
    
    _verificButton = [UIButton new];
    [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2-disabled"] forState:UIControlStateNormal];
    [_verificButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verificButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
    _verificButton.titleLabel.font = [UIFont systemFontOfSize:createBtn_font];
    [verificView addSubview:_verificButton];
    [_verificButton addTarget:self action:@selector(getVerificAction) forControlEvents:UIControlEventTouchUpInside];
    _verificButton.enabled = NO;
    [_verificButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(verificBtn_width));
    }];
    
    _verificTF = [UITextField new];
    _verificTF.placeholder = @"请输入验证码";
    _verificTF.font = [UIFont systemFontOfSize:14*rating];
    _verificTF.tintColor = [UIColor themeColor];
    _verificTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _verificTF.keyboardType = UIKeyboardTypeASCIICapable;
    [verificView addSubview:_verificTF];
    _verificTF.delegate = self;
    [_verificTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_verificTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(verificView.mas_left).with.offset(17*rating);
        make.right.equalTo(_verificButton.mas_left).with.offset(-17*rating);
        make.bottom.equalTo(@(0));
    }];
    
    ////
    _readButton = [UIButton new];
    [_readButton setImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateNormal];
    [animationView addSubview:_readButton];
    [_readButton addTarget:self action:@selector(readAction:) forControlEvents:UIControlEventTouchUpInside];
    [_readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(verificView.mas_bottom).with.offset(verfi_readBtn_padding);
        make.width.equalTo(@(readBtn_W_H));
        make.height.equalTo(@(readBtn_W_H));
    }];
    _isReadProtocol = YES;
    
    UILabel *readLb = [UILabel new];
    readLb.attributedText = [Util changeAttributedStrWithfrontStr:@"我已阅读并接受"
                                                    withBehindStr:@"搭搭秀用户注册协议"
                                                   withFrontColor:[UIColor colorWithHex:0x747474]
                                                  withBehindColor:ThemeColor];
    readLb.font = [UIFont systemFontOfSize:12];
    readLb.userInteractionEnabled = YES;
    [readLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToReadProtocol)]];
    [animationView addSubview:readLb];
    [readLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_readButton.mas_right).with.offset(readBtn_info_padding);
        make.right.equalTo(@(-right_TF_padding));
        make.centerY.equalTo(_readButton);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(arrgeuserbook)];
    [readLb addGestureRecognizer:tap];
    
    ////
    
    UIButton *registerButton = [UIButton new];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:16*(kScreen_Height/667)];
    [animationView addSubview:registerButton];
    registerButton.enabled = NO;
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    _registerButton = registerButton;
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.height.equalTo(@(loginBtn_height));
    }];
    
    UIButton *createButton = [UIButton new];
    [createButton setTitle:@"已有账号" forState:UIControlStateNormal];
    createButton.titleLabel.font = [UIFont systemFontOfSize:createBtn_font];
    [createButton setTitleColor:ThemeColor forState:UIControlStateNormal];
    [self.view addSubview:createButton];
    [createButton addTarget:self action:@selector(oldAccount) forControlEvents:UIControlEventTouchUpInside];
    
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerButton.mas_bottom).with.offset(loginBtn_createBtn_padding);
        make.left.equalTo(@(left_TF_padding));
        make.right.equalTo(@(-right_TF_padding));
        make.height.equalTo(@(createBtn_height));
    }];
    
}

-(void)arrgeuserbook{
    NSLog(@"同意用户协议");
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"软件许可使用协议" withExtension:@"pdf"];
    [self presentUDIC:url];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (void)presentUDIC:(NSURL *)url
{
    if(url){
        self.udic = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.udic.delegate = self;
        [self.udic presentPreviewAnimated:YES];
        [self.udic presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    }
}

- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textfield
{

    if (_phoneNumberTF.text.length > 11) {
        textfield.text = [textfield.text substringToIndex:11];
    } else if (_phoneNumberTF.text.length == 11) {
        if ([Util validateMobile:_phoneNumberTF.text]) {
            //匹配成功
            [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2"] forState:UIControlStateNormal];
            [_verificButton setTitleColor:ButtonNormalTextColor forState:UIControlStateNormal];
            _verificButton.enabled = YES;
            isTruePhoneNumber = YES;
        } else {
            //不是正确的手机号码
            MBProgressHUD *HUD = [Util createHUD];
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText = @"请填写正确格式的手机号码";
            
            [HUD hide:YES afterDelay:2];
            [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2-disabled"] forState:UIControlStateNormal];
            [_verificButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
            _verificButton.enabled = NO;
            isTruePhoneNumber = NO;
        }
    } else if (_phoneNumberTF.text.length < 11) {
        [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2-disabled"] forState:UIControlStateNormal];
        [_verificButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
        _verificButton.enabled = NO;
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
    [_phoneNumberTF resignFirstResponder];
    [_passwardTF resignFirstResponder];
    [_verificTF resignFirstResponder];
    
//    [self.view removeGestureRecognizer:_tap];
//    [self.animationView removeGestureRecognizer:_tap];
}

- (void)keyboardAction:(NSNotification *)notification
{
    CGSize size = self.animationView.frame.size;
    CGPoint point = self.animationView.frame.origin;
    
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
    
    //    minY = top_phoneTFView_padding - keyBoradHeight * 0.5;
    minY = (kScreen_Height- keyBoradHeight - animationView_height)/2+30;
    if (notification.name == UIKeyboardWillShowNotification) {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.animationView.frame = CGRectMake(point.x, minY, size.width, size.height);
                                 self.iconIMG.hidden = YES;
                                 
                             } completion:^(BOOL finished) {

                             }];
            
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
            [self.view addGestureRecognizer:_tap];
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        [UIView animateWithDuration:-timeInt
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             self.animationView.frame = CGRectMake(point.x, top_phoneTFView_padding, size.width, size.height);
                             self.iconIMG.hidden = NO;
                             
                         } completion:^(BOOL finished) {
                         }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 切换是否显示密码
- (void)changeSecretPWAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.passwardTF.secureTextEntry = NO;
        [self.secretButton setImage:[UIImage imageNamed:@"btn-Public"] forState:UIControlStateNormal];
    } else {
        self.passwardTF.secureTextEntry = YES;
        [self.secretButton setImage:[UIImage imageNamed:@"btn-private"] forState:UIControlStateNormal];
    }
}

#pragma mark - read action
- (void)readAction:(UIButton *)button
{
    _isReadProtocol = !_isReadProtocol;
    UIImage *image = _isReadProtocol ? [UIImage imageNamed:@"login_selected"] : [UIImage imageNamed:@"login_unSelected"];
    [button setImage:image forState:UIControlStateNormal];
    
    NSLog(@"是否选择 = %d", _isReadProtocol);
}

- (void)pushToReadProtocol
{
    NSLog(@"push to read protocol");
}

#pragma mark - get Verification action
- (void)getVerificAction
{
    NSLog(@"get VerificAction ...");
    
    [DaHttpTool get:[NSString stringWithFormat:@"%@%@%@/%@/1", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_SENDVERIFYCODE, _phoneNumberTF.text]
             params:nil
            success:^(id json) {
                NSLog(@"success json = %@", json);
                if ([json[@"state"] isEqualToString:@"success"]) {
                    self.numTimer = 60;
                    self.verificButton.enabled = NO;
                    [self.verificButton setTitle:[NSString stringWithFormat:@"%ld秒后重试", (long)self.numTimer] forState:UIControlStateNormal];
                    [_verificButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
                    [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2-disabled"] forState:UIControlStateNormal];
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timersStart) userInfo:nil repeats:YES];
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                    hud.mode = MBProgressHUDModeText;
                    hud.margin=10;
                    hud.labelFont=[UIFont boldSystemFontOfSize:13];
                    hud.detailsLabelText = @"验证码发送成功";
                    [hud hide:YES afterDelay:1.5];
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

/**
 *  定时器的响应方式
 */
- (void)timersStart {
    
    self.numTimer--;
    [self.verificButton setTitle:[NSString stringWithFormat:@"%d秒后重试", (int)self.numTimer] forState:UIControlStateNormal];
    [_verificButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
    [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2-disabled"] forState:UIControlStateNormal];
    _verificButton.enabled = NO;
    if (self.numTimer == 0) {
        
        [self.verificButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verificButton setTitleColor:ButtonNormalTextColor forState:UIControlStateNormal];
        [_verificButton setBackgroundImage:[UIImage imageNamed:@"bg-box2"] forState:UIControlStateNormal];
        [self.timer invalidate];
        self.verificButton.enabled = YES;
        
    }
}

#pragma mark - register action
- (void)registerAction
{
    NSLog(@"register ...");
    
    if (_isReadProtocol) {
        [DaHttpTool post:[NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_REGISTER]
                  params:@{
                           @"mobile"     : _phoneNumberTF.text,
                           @"password"   : _passwardTF.text,
                           @"verifyCode" : _verificTF.text,
                           }.mutableCopy
                 success:^(id json) {
                     NSLog(@"success json = %@", json);
                     
                     if ([json[@"state"] isEqualToString:@"success"]) {
                         DDXUserinfo *userInfo = [DDXUserinfo new];
                         userInfo.mobile =  _phoneNumberTF.text;
                         userInfo.id = [json[@"content"][@"id"] longValue];
                         
                         [DDXUserinfo saveUserInfoToSanbox:userInfo];
                         
                         [self dismissViewControllerAnimated:YES completion:nil];
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
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 15;
        hud.labelFont=[UIFont boldSystemFontOfSize:15];
        hud.detailsLabelText = @"请先勾选我已阅读并接受协议";
        [hud hide:YES afterDelay:1.5];
    }
    
}

#pragma mark - create new account
- (void)oldAccount
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 按钮状态

- (void)buttonStateEnable
{
    if (isTruePhoneNumber && _passwardTF.text.length >= 6 && _passwardTF.text.length <= 16 && _verificTF.text.length > 0) {
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [_registerButton setTitleColor:ButtonNormalTextColor forState:UIControlStateNormal];
        _registerButton.enabled = YES;
    } else {
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
        [_registerButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
        _registerButton.enabled = NO;
    }
}



@end
