//
//  LoginViewController.m
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"

#import "DDXUserinfo.h"

#define rating kScreen_Height/667
#define top_backBtn_padding 29*(kScreen_Height/667)
#define left_backBtn_padding 12*(kScreen_Height/667)
#define backBtn_width_equ_height 23*(kScreen_Height/667)

#define icon_width_equ_height 60*(kScreen_Height/667)
#define backBtn_icon_padding 25*(kScreen_Height/667)
//#define icon_TF_padding 64*(kScreen_Height/667)
#define top_phoneTFView_padding 201*(kScreen_Height/667)

#define left_TF_padding 37*(kScreen_Height/667)
#define right_TF_padding left_TF_padding
#define TF_height 45*(kScreen_Height/667)
#define TF_TF_padding 20*(kScreen_Height/667)

#define TF_forgetBtn_padding 12*(kScreen_Height/667)
#define forgetBtn_height 21*(kScreen_Height/667)
#define forgetBtn_logBtn_padding 45*(kScreen_Height/667)
#define forgetBtn_font 12*(kScreen_Height/667)

#define loginBtn_forgetBtn_padding 45*(kScreen_Height/667)
#define loginBtn_height 45*(kScreen_Height/667)

#define loginBtn_createBtn_padding 22*(kScreen_Height/667)
#define createBtn_height 24*(kScreen_Height/667)
#define createBtn_font 14*(kScreen_Height/667)

#define createBtn_thirdloginview_padding 50*(kScreen_Height/667)

#define top_line_padding 10*(kScreen_Height/667)
#define bottom_line_padding 10*(kScreen_Height/667)

#define label_Font 12*(kScreen_Height/667)
#define label_height 21*(kScreen_Height/667)
#define labe_button_padding 42*(kScreen_Height/667)

#define left_button_padding 80*(kScreen_Height/667)
#define Btn_Btn_padding 58*(kScreen_Height/667)
#define Btn_width 32*(kScreen_Height/667)
#define Btn_height 30*(kScreen_Height/667)

#define animationView_height 224*(kScreen_Height/667)

#define View_centerX [UIScreen mainScreen].bounds.size.width/2

@interface LoginViewController () <UITextFieldDelegate>
{
    CGFloat minY;
    BOOL isShowKeyboard;
    UIView *phoneNumView;
    UIView *passwView;
    UIButton *loginButton;
    
    BOOL isTruePhoneNumber;
}
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) UITextField *phoneNumberTF;
@property (nonatomic, strong) UITextField *passwardTF;
@property (nonatomic, strong) UIButton *secretButton;

@property (nonatomic, strong) UIView *thirdLoginView;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIImageView *iconIMG;

@end

@implementation LoginViewController

- (void)viewDidLoad {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    [icon setImage:[UIImage imageNamed:@"userPortrait_default"]];
    [self.view addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backBtn.mas_bottom).with.offset(backBtn_icon_padding);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(icon_width_equ_height));
        make.height.equalTo(@(icon_width_equ_height));
    }];
    self.iconIMG = icon;
    
    /******/
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
    /******/
    
    //
    phoneNumView = [UIView new];
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
    _phoneNumberTF.text = [DDXUserinfo sharedDWUserInfo].mobile.length ? [DDXUserinfo sharedDWUserInfo].mobile : @"";
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
    passwView = [UIView new];
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
    _passwardTF.secureTextEntry = YES;
    _passwardTF.tintColor = [UIColor themeColor];
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
    
    UIButton *forgetBtn = [UIButton new];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:forgetBtn_font];
    [forgetBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [animationView addSubview:forgetBtn];
    [forgetBtn addTarget:self action:@selector(forgetPWAction) forControlEvents:UIControlEventTouchUpInside];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwView.mas_bottom).with.offset(TF_forgetBtn_padding);
        make.right.equalTo(@(0));
        make.height.equalTo(@(forgetBtn_height));
    }];
    
    loginButton = [UIButton new];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16*rating];
    [animationView addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    loginButton.enabled = NO;
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(loginBtn_height));
        make.bottom.equalTo(@(0));
    }];
    
    UIButton *createButton = [UIButton new];
    [createButton setTitle:@"创建账号" forState:UIControlStateNormal];
    createButton.titleLabel.font = [UIFont systemFontOfSize:createBtn_font];
    [createButton setTitleColor:ThemeColor forState:UIControlStateNormal];
    [self.view addSubview:createButton];
    [createButton addTarget:self action:@selector(createNewAccount) forControlEvents:UIControlEventTouchUpInside];
    
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).with.offset(loginBtn_createBtn_padding);
        make.left.equalTo(@(left_TF_padding));
        make.right.equalTo(@(-right_TF_padding));
        make.height.equalTo(@(createBtn_height));
    }];
    
    self.thirdLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-146*rating, kScreen_Width, 146*rating)];
    [self.view addSubview:self.thirdLoginView];
    
//    [self thirdViewLayout];
}

- (void)thirdViewLayout
{
    UIView *leftLine = [UIView new];
    leftLine.backgroundColor = [UIColor colorWithHex:0xaeaeae];
    [self.thirdLoginView addSubview:leftLine];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdLoginView.mas_top).with.offset(top_line_padding);
        make.left.equalTo(self.thirdLoginView.mas_left).with.offset(left_TF_padding);
        make.height.equalTo(@(1));
    }];
    
    UILabel *label = [UILabel new];
    label.text = @" 第三方快速登录 ";
    label.font = [UIFont systemFontOfSize:12*rating];
    label.textColor = [UIColor colorWithHex:0x3f3f3f];
    [self.thirdLoginView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLine.mas_right).with.offset(5*rating);
        make.top.equalTo(self.thirdLoginView.mas_top).with.offset(0);
        make.height.equalTo(@(label_height));
        make.centerX.equalTo(self.thirdLoginView);
    }];
    
    UIView *rightLine = [UIView new];
    rightLine.backgroundColor = [UIColor colorWithHex:0xaeaeae];
    [self.thirdLoginView addSubview:rightLine];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).with.offset(5*rating);
        make.top.equalTo(self.thirdLoginView.mas_top).with.offset(top_line_padding);
        make.height.equalTo(@(1));
        make.right.equalTo(self.thirdLoginView.mas_right).with.offset(-right_TF_padding);
    }];
    
    NSArray *images = @[@"qq", @"wechat", @"weibo"];
    for (int i = 0; i < 3; i++) {
        CGFloat x = (View_centerX - Btn_width/2) + (i-1) * (Btn_width+Btn_Btn_padding);
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(x, label_height+labe_button_padding, Btn_width, Btn_height);
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [self.thirdLoginView addSubview:button];
        
        button.tag = i+1;
//        [button addTarget:button action:@selector(thirdLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textfield
{
    if (textfield == _phoneNumberTF) {
        if (textfield.text.length > 11) {
            textfield.text = [textfield.text substringToIndex:11];
        } else if (_phoneNumberTF.text.length == 11) {
            if ([Util validateMobile:_phoneNumberTF.text]) {
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
        } else if (_phoneNumberTF.text.length < 11) {
            
            isTruePhoneNumber = NO;
        }
    } else if (textfield == _passwardTF) {
        if (textfield.text.length > 16) {
            textfield.text = [textfield.text substringToIndex:16];
        }
    }
    
    [self buttonStateEnable];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self buttonStateEnable];
}

#pragma mark - ThirdLoginView button click
- (void)thirdLoginAction:(UIButton *)typeBtn
{
    switch (typeBtn.tag) {
        case 1:
        {
            NSLog(@"QQ login");
            break;
        }
        case 2:
        {
            NSLog(@"wechat login");
            break;
        }
        case 3:
        {
            NSLog(@"weibo login");
            break;
        }
        default:
            break;
    }
}

#pragma mark - 软键盘隐藏
- (void)keyBoardHiden:(UITapGestureRecognizer *)tap
{
    [_phoneNumberTF resignFirstResponder];
    [_passwardTF resignFirstResponder];
    
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

    minY = (kScreen_Height- keyBoradHeight - animationView_height)/2+30;
    if (notification.name == UIKeyboardWillShowNotification) {
        if (isShowKeyboard == NO) {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.animationView.frame = CGRectMake(point.x, minY, size.width, size.height);
                                 self.iconIMG.hidden = YES;
                                 isShowKeyboard = YES;
                                 
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
            
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
            [self.view addGestureRecognizer:_tap];
        } else {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.animationView.frame = CGRectMake(point.x, minY, size.width, size.height);
                                 self.iconIMG.hidden = YES;
                                 isShowKeyboard = YES;
                                 
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
        }
        
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        [UIView animateWithDuration:-timeInt
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             self.animationView.frame = CGRectMake(point.x, top_phoneTFView_padding, size.width, size.height);
                             self.iconIMG.hidden = NO;
                             isShowKeyboard = NO;
                             
                         } completion:^(BOOL finished) {
                             isShowKeyboard = NO;
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

#pragma mark - forget password action
- (void)forgetPWAction
{
    NSLog(@"forget password ...");
    
    [self presentViewController:[ForgetViewController new] animated:YES completion:nil];
}

#pragma mark - login action
- (void)loginAction
{
    [_phoneNumberTF resignFirstResponder];
    [_passwardTF resignFirstResponder];
    
    NSString *strUtl = [NSString stringWithFormat:@"%@%@%@", DDXAPI_HTTP_PREFIX_Loign, DDXAPI_SHOPPASSWORD_SR, DDXAPI_SHOPPASSWORD_SR_LOGIN];
    NSMutableDictionary *paras = @{
                                   @"mobile"   : _phoneNumberTF.text,
                                   @"password" : _passwardTF.text,
                                   @"code"     : [DDXUserinfo getUserCode].length ? [DDXUserinfo getUserCode] : @"",
                                   }.mutableCopy;
    [DaHttpTool post:strUtl
              params:paras
             success:^(id json) {
                 NSLog(@"json = %@", json);
                 if ([json[@"state"] isEqualToString:@"success"]) {
                     
                     DDXUserinfo *object = [DDXUserinfo osc_modelWithDictionary:json[@"content"]];
                     [DDXUserinfo saveUserInfoToSanbox:object];
                     
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
    
}

#pragma mark - create new account
- (void)createNewAccount
{
    [_phoneNumberTF resignFirstResponder];
    [_passwardTF resignFirstResponder];
    
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
}

#pragma mark - 按钮状态

- (void)buttonStateEnable
{
    if (isTruePhoneNumber && _passwardTF.text.length >= 6 && _passwardTF.text.length <= 16) {
        [loginButton setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [loginButton setTitleColor:ButtonNormalTextColor forState:UIControlStateNormal];
        loginButton.enabled = YES;
    } else {
        [loginButton setBackgroundImage:[UIImage imageNamed:@"btn_disabled"] forState:UIControlStateNormal];
        [loginButton setTitleColor:ButtonDissableTextColor forState:UIControlStateNormal];
        loginButton.enabled = NO;
    }
}



@end
