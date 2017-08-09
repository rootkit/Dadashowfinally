//
//  MineHeaderView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "MineHeaderView.h"
//#import "UIImageView+LBBlurredImage.h"//图片模糊效果处理
#import "UIImageView+WebCache.h"

#define kHeaderIMG_W kScreen_Width
#define kHeaderIMG_H kHeaderIMG_W*234/375

#define rating (kScreen_Width-24)/351

#define userPor_W 62*rating
#define userPor_H userPor_W

#define top_portrait_padding 60*kScreen_Height/667
#define portrait_name_padding 15*kScreen_Height/667
#define name_vBtn_padding 25*kScreen_Height/667
#define name_follow_padding 17*kScreen_Height/667

#define info_W (kScreen_Width-24)
#define info_H info_W*121/351

#define btn_H_Width 67*rating
#define btn_H_Height 74*rating
#define vImage_width (info_W-2)/3
#define vImage_height info_H - btn_H_Height

@interface MineHeaderView ()
{
    BOOL _isTouchPortrait;
    BOOL _isTouchVBtn;
}

//@property (nonatomic, strong) UIImageView *headIMG;
@property (nonatomic, strong) UIImageView *userPortraitIMG;
@property (nonatomic, strong) UILabel *usernameLb;
@property (nonatomic, strong) UILabel * V_Btn;
@property (nonatomic, strong) UILabel *followLb;

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *historyBtn;

@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UIButton *payingBtn;
@property (nonatomic, strong) UIButton *deliveryBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *afterSaleBtn;

@end
@implementation MineHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayout];
    }
    return self;
}

- (void)setLayout
{
    self.backgroundColor = BackCellColor;
    
    _headIMG = [UIImageView new];
    _headIMG.image = [UIImage imageNamed:@"mysetting.jpg"];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    // 20 左右 R  模糊图片
//    [_headIMG setImageToBlur:_headIMG.image blurRadius:21 completionBlock:nil];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame =CGRectMake(0, 0, kScreen_Width, kHeaderIMG_H);
    [_headIMG addSubview:effectView];
    [self addSubview:_headIMG];
    [_headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(kHeaderIMG_H));
    }];
    
    
    _userPortraitIMG = [UIImageView new];
    _userPortraitIMG.image = [UIImage imageNamed:@"userPortrait_default"];
    [_userPortraitIMG handleCornerRadiusWithRadius:userPor_W/2];
    [_userPortraitIMG handleBoardWidth:2 andBorderColor:[UIColor whiteColor]];
    [_headIMG addSubview:_userPortraitIMG];
    
    [_userPortraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headIMG.mas_centerX).with.offset(0);
        make.top.equalTo(@(top_portrait_padding));
        make.width.equalTo(@(userPor_W));
        make.height.equalTo(@(userPor_H));
    }];
    
    _usernameLb = [UILabel new];
    _usernameLb.text = @"方大同000111";
    _usernameLb.textAlignment = NSTextAlignmentCenter;
    _usernameLb.font = [UIFont systemFontOfSize:18*rating];
    _usernameLb.textColor = [UIColor whiteColor];
    [_headIMG addSubview:_usernameLb];
    
    [_usernameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(_userPortraitIMG.mas_bottom).with.offset(portrait_name_padding);
        make.height.equalTo(@(22*rating));
//        make.right.equalTo(_userPortraitIMG.mas_centerX).with.offset(-10*rating);//隐藏“申请加V享特权”
        make.right.equalTo(@(0));
    }];
    
    _V_Btn = [UILabel new];
    _V_Btn.font = [UIFont systemFontOfSize:12];
    _V_Btn.textColor = [UIColor whiteColor];
    _V_Btn.text = @"申请加V享特权";
    _V_Btn.hidden = YES;
    _V_Btn.textAlignment = NSTextAlignmentCenter;
    [_V_Btn handleCornerRadiusWithRadius:3];
    [_V_Btn handleBoardWidth:1 andBorderColor:[UIColor whiteColor]];
    [_headIMG addSubview:_V_Btn];
    
    [_V_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_usernameLb.mas_right).with.offset(name_vBtn_padding);
        make.centerY.equalTo(_usernameLb.mas_centerY);
        make.height.equalTo(@(16*rating));
        make.width.equalTo(@(100*rating));
    }];
    
    _followLb  = [UILabel new];
    _followLb.text = @"关注 100";
    _followLb.textAlignment = NSTextAlignmentCenter;
    _followLb.font = [UIFont systemFontOfSize:12*rating];
    _followLb.textColor = [UIColor whiteColor];
    [_headIMG addSubview:_followLb];
    
    [_followLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(_usernameLb.mas_bottom).with.offset(name_follow_padding);
        make.height.equalTo(@(15*rating));
        make.right.equalTo(@(0));
    }];
    
    _infoView = [UIView new];
    _infoView.backgroundColor = [UIColor whiteColor];
    _infoView.layer.masksToBounds = YES;
    _infoView.layer.cornerRadius = 5;
    [_infoView handleShadowOffset:CGSizeMake(3, 8) shadowColor:[UIColor colorWithHex:0x818181] shadowOpacity:0.8];
    [self addSubview:_infoView];
    
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
        make.bottom.equalTo(@(-7*rating));
        make.width.equalTo(@(info_W));
        make.height.equalTo(@(info_H));
    }];
    
    NSArray *vTitles = @[@"关注", @"收藏", @"足迹"];
    NSArray *vImages = @[@"mine_follow", @"mine_collect", @"mine_history"];

    for (int i = 0; i < 3; i++) {
        ImageButtonV *button = [[ImageButtonV alloc] initWithFrame:CGRectMake(floor((vImage_width+1)*i), 0, floor(vImage_width)+1, floor(vImage_height)+1) andImageName:vImages[i] andText:vTitles[i]];

        button.tag = i+1;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_infoView addSubview:button];
    }
    
    for (int i = 0; i < 2; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((vImage_width+1)*(i+1), 15*rating, 1, 20*rating)];
        lineView.backgroundColor = [UIColor colorWithHex:0x585757];
        [_infoView addSubview:lineView];
    }
    
    NSArray *hTitles = @[@"全部订单", @"待付款", @"待收货", @"待评价", @"售后"];
    NSArray *hImages = @[@"mine_allorder", @"mine_paying", @"mine_delivery", @"mine_comment", @"mine_aftersale"];
    CGFloat btnLeftPadding = 8*rating;
    
    for (int i = 0; i < 5; i++) {
        ImageButtonH *button = [[ImageButtonH alloc] initWithFrame:CGRectMake(btn_H_Width*i+btnLeftPadding, vImage_height, btn_H_Width, btn_H_Height) andImageName:hImages[i] andText:hTitles[i]];

        button.tag = i+4;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_infoView addSubview:button];
    }
}

- (CGRect)solveUIWidgetFuzzy:(UIView *)view
{
    CGRect frame = view.frame;
    int x = floor(frame.origin.x);
    int y = floor(frame.origin.y);
    int w = floor(frame.size.width)+1;
    int h = floor(frame.size.height)+1;
    
    return CGRectMake(x, y, w, h);
}

#pragma mark - button action
- (void)clickAction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(chooseAction:)]) {
        [_delegate chooseAction:button.tag];
    }
}

#pragma mark - set info
- (void)setUserInfo:(DDXUserinfo *)userInfo
{
    _followLb.hidden = YES;
    
    if (userInfo.id > 0) {
        if (userInfo.headerUrl.length > 0) {
//            [_userPortraitIMG loadPortrait:[NSURL URLWithString:userInfo.headerUrl]];//图片模糊处理
        [_userPortraitIMG  sd_setImageWithURL:[NSURL URLWithString:userInfo.headerUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
        }
        _usernameLb.text = userInfo.alias.length > 0 ? userInfo.alias : @"无昵称";
        _V_Btn.hidden = NO;
    } else {
        _userPortraitIMG.image = [UIImage imageNamed:@"userPortrait_default"];
        _usernameLb.text = @"未登录";
        _V_Btn.hidden = YES;
    }
    
    if (userInfo.headerUrl.length>0) {
//        dispatch_queue_t serialQueue=dispatch_queue_create("downloadImage", DISPATCH_QUEUE_SERIAL);//缓存单张图片
//                    dispatch_async(serialQueue, ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.headerUrl]];
//        UIImage *image = [UIImage imageWithData:imageData];
//        if (image) {
////        [_headIMG setImageToBlur:image blurRadius:21 completionBlock:nil];
//        }
//        });
        [_headIMG  sd_setImageWithURL:[NSURL URLWithString:userInfo.headerUrl] placeholderImage:[UIImage imageWithColor:DefaultImgBgColor]];
    }else{
//        UIImage* imagebegin=[UIImage imageNamed:@"mine_bg"];
//        [_headIMG setImageToBlur:imagebegin blurRadius:21 completionBlock:nil];
        _headIMG .image = [UIImage imageNamed:@"mysetting.jpg"];

    }
    
    
}

#pragma mark - touch 

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isTouchPortrait = NO;
    _isTouchVBtn = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:self.userPortraitIMG];
    CGPoint p2 = [t locationInView:self.V_Btn];
    
    if (CGRectContainsPoint(self.userPortraitIMG.bounds, p1)) {
        _isTouchPortrait = YES;
    } else if (CGRectContainsPoint(self.V_Btn.bounds, p2)) {
        _isTouchVBtn = YES;
    }  else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isTouchPortrait) {
        if (_delegate && [_delegate respondsToSelector:@selector(chooseUserPortrait)]) {
            [_delegate chooseUserPortrait];
        }
    } else if (_isTouchVBtn) {
        if (_delegate && [_delegate respondsToSelector:@selector(chooseVMember)]) {
            [_delegate chooseVMember];
        }
    } else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isTouchPortrait || !_isTouchVBtn) {
        
        [super touchesCancelled:touches withEvent:event];
    }
}

@end

#define VIMG_W_H 15*rating
#define lable_W CGRectGetWidth(self.frame)/2
/***** ImageButtonV ******/
@implementation ImageButtonV
{
    NSString *imageNameStr;
    NSString *textStr;
}

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andText:(NSString *)string
{
    self = [super initWithFrame:frame];
    if (self) {
        imageNameStr = imageName;
        textStr = string;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImageView *IMG = [UIImageView new];
    IMG.image = [UIImage imageNamed:imageNameStr];
    [self addSubview:IMG];
    
    [IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(23*rating));
        make.width.equalTo(@(VIMG_W_H));
        make.height.equalTo(@(VIMG_W_H));
        make.centerY.equalTo(self);
    }];
    
    UILabel *label = [UILabel new];
    label.text = textStr;
    label.font = [UIFont systemFontOfSize:14*rating];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IMG.mas_right).with.offset(10*rating);
        make.right.equalTo(@(0));
        make.centerY.equalTo(self);
        make.width.equalTo(@(lable_W));
    }];
}

@end

#define HIMG_W_H 23*rating
/***** ImageButtonH ******/
@implementation ImageButtonH
{
    NSString *imageNameStr;
    NSString *textStr;
}

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andText:(NSString *)string
{
    self = [super initWithFrame:frame];
    if (self) {
        imageNameStr = imageName;
        textStr = string;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIImageView *IMG = [UIImageView new];
    IMG.image = [UIImage imageNamed:imageNameStr];
    [self addSubview:IMG];
    
    [IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16*rating));
        make.width.equalTo(@(HIMG_W_H));
        make.height.equalTo(@(HIMG_W_H));
        make.centerX.equalTo(self);
    }];
    
    UILabel *label = [UILabel new];
    label.text = textStr;
    label.font = [UIFont systemFontOfSize:12*rating];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHex:0x585757];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IMG.mas_bottom).with.offset(8*rating);
        make.centerX.equalTo(self);
//        make.left.equalTo(@(0));
//        make.right.equalTo(@(0));
//        make.bottom.equalTo(self.mas_bottom).with.offset(-17*rating);
    }];
}

@end
