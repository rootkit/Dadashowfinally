//
//  VMemberHeaderView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "VMemberHeaderView.h"

#define centerV_bottom_padding 32
#define centerV_W (kScreen_Width-25)
#define centerV_H (centerV_W*3/7)

#define portrait_W_H 50
#define portrait_level_padding 6

#define level_name_padding 13
#define name_info_padding 8

#define takeshow_top_padding 9
#define takeshow_right_padding 10

#define circle_W_H 50
#define circle_left 17

@interface VMemberHeaderView ()

@property (nonatomic, strong) UIImageView *bgIMG;
@property (nonatomic, strong) UIView *firstBgView;

//
@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *takeShowLb;
@property (nonatomic, strong) UILabel *levelLb;
@property (nonatomic, strong) UILabel *levelNameLb;
@property (nonatomic, strong) UILabel *infoLb;
//

@end

@implementation VMemberHeaderView

- (void)drawRect:(CGRect)rect {
    
    _bgIMG = [UIImageView new];
    _bgIMG.image = [UIImage imageNamed:@"vm_bgImg"];
    [self addSubview:_bgIMG];
    [_bgIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    _firstBgView = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetHeight(self.frame)-centerV_H - centerV_bottom_padding, centerV_W, centerV_H)];
    [_firstBgView handleCornerRadiusWithRadius:5];
    [_bgIMG addSubview:_firstBgView];
    [self layerForCycleScrollViewTitle:_firstBgView];
    
//    [self setFirstViewLaySubViews];
    [self setSecondViewLaySubViews];
}

- (void)setFirstViewLaySubViews
{
    _portraitIMG = [UIImageView new];
    _portraitIMG.image = [UIImage imageNamed:@"mine_portrait"];
    [_portraitIMG handleCornerRadiusWithRadius:portrait_W_H/2];
    [_portraitIMG handleBoardWidth:2 andBorderColor:[UIColor whiteColor]];
    [_bgIMG addSubview:_portraitIMG];
    [_portraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(portrait_W_H));
        make.height.equalTo(@(portrait_W_H));
        make.centerX.equalTo(_firstBgView);
        make.top.equalTo(@(3));
    }];
    
    _takeShowLb = [UILabel new];
    _takeShowLb.text = @"Take show";
    _takeShowLb.font = [UIFont systemFontOfSize:16];
    _takeShowLb.textColor = [UIColor colorWithHex:0xffffff alpha:0.35f];
    [_firstBgView addSubview:_takeShowLb];
    [_takeShowLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(takeshow_top_padding));
        make.right.equalTo(@(-takeshow_right_padding));
        make.height.equalTo(@(12));
    }];
    
    _levelLb = [UILabel new];
    _levelLb.text = @"Lv-1";
    _levelLb.font = [UIFont systemFontOfSize:12];
    _levelLb.textColor = [UIColor colorWithHex:0xfdeef4];
    _levelLb.textAlignment = NSTextAlignmentCenter;
    [_firstBgView addSubview:_levelLb];
    [_levelLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_portraitIMG.mas_bottom).with.offset(portrait_level_padding);
//        make.left.equalTo(@(0));
//        make.right.equalTo(@(0));
//        make.height.equalTo(@(10));
        make.centerX.equalTo(_firstBgView);
    }];
    
    _levelNameLb = [UILabel new];
    _levelNameLb.text = @"普通会员";
    _levelNameLb.font = [UIFont systemFontOfSize:15];
    _levelNameLb.textAlignment = NSTextAlignmentCenter;
    _levelNameLb.textColor = [UIColor colorWithHex:0xfdeef4];
    [_firstBgView addSubview:_levelNameLb];
    [_levelNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_levelNameLb.mas_bottom).with.offset(level_name_padding);
//        make.left.equalTo(@(0));
//        make.right.equalTo(@(0));
        make.height.equalTo(@(16));
        make.centerX.equalTo(_firstBgView);
    }];
    
    _infoLb = [UILabel new];
    _infoLb.text = @"打败了全国52%的用户";
    _infoLb.font = [UIFont systemFontOfSize:11];
    _infoLb.textColor = [UIColor colorWithHex:0xfdeef4];
    _infoLb.textAlignment = NSTextAlignmentCenter;
    [_firstBgView addSubview:_infoLb];
    [_infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_levelNameLb.mas_bottom).with.offset(name_info_padding);
//        make.left.equalTo(@(0));
//        make.right.equalTo(@(0));
        make.height.equalTo(@(12));
        make.centerX.equalTo(_firstBgView);
    }];
}

/* 标题背景添加渐变色 */
- (void)layerForCycleScrollViewTitle:(UIView *)bottomView
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[
                     (__bridge id)[UIColor colorWithHex:0xf97baa].CGColor,
                     (__bridge id)[UIColor colorWithHex:0xf23984].CGColor,
                     ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = bottomView.bounds;
    
    [bottomView.layer addSublayer:layer];
}

- (void)setSecondViewLaySubViews
{
    _takeShowLb = [UILabel new];
    _takeShowLb.text = @"Take show";
    _takeShowLb.font = [UIFont systemFontOfSize:16];
    _takeShowLb.textColor = [UIColor colorWithHex:0xffffff alpha:0.35f];
    [_firstBgView addSubview:_takeShowLb];
    [_takeShowLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(takeshow_top_padding));
        make.right.equalTo(@(-takeshow_right_padding));
        make.height.equalTo(@(12));
    }];
    
    UILabel *levelLb = [UILabel new];
    levelLb.text = @"会员等级";
    levelLb.font = [UIFont systemFontOfSize:15];
    levelLb.textAlignment = NSTextAlignmentCenter;
    levelLb.textColor = [UIColor colorWithHex:0xfdeef4];
    [_firstBgView addSubview:levelLb];
    [levelLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(17));
        make.centerX.equalTo(_firstBgView);
    }];
    
    UILabel *levelNameLb = [UILabel new];
    levelNameLb.text = @"VIP-1";
    levelNameLb.font = [UIFont systemFontOfSize:12];
    levelNameLb.textAlignment = NSTextAlignmentCenter;
    levelNameLb.textColor = [UIColor colorWithHex:0xfdeef4];
    [_firstBgView addSubview:levelNameLb];
    [levelNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelLb.mas_bottom).with.offset(10);;
        make.centerX.equalTo(_firstBgView);
    }];
    
    UILabel *infoLb = [UILabel new];
    infoLb.text = @"还差492成长值可升级为VIP2";
    infoLb.font = [UIFont systemFontOfSize:11];
    infoLb.textAlignment = NSTextAlignmentCenter;
    infoLb.textColor = [UIColor colorWithHex:0xfdeef4];
    [_firstBgView addSubview:infoLb];
    [infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelNameLb.mas_bottom).with.offset(10);;
        make.centerX.equalTo(_firstBgView);
    }];
    
    CGFloat width_height = 50;
    CGFloat padding = (CGRectGetWidth(_firstBgView.frame)-24-3*width_height)/2;
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(12+width_height/2, CGRectGetHeight(_firstBgView.frame)-(20+width_height/2), CGRectGetWidth(_firstBgView.frame)-2*(12+width_height/2), 2)];
    [_firstBgView addSubview:progressView];
    
    progressView.trackTintColor = [UIColor colorWithHex:0xfb8cb5];
    progressView.progressTintColor = [UIColor colorWithHex:0xfdeef4];
    progressView.progress = 0.2;
    
    
    for (int i = 0; i < 3; i++) {
        customPointTitle *view = [[customPointTitle alloc] initWithFrame:CGRectMake(12+(padding+width_height)*i, CGRectGetHeight(_firstBgView.frame)-(20+width_height), width_height, width_height)];
        view.backgroundColor = [UIColor clearColor];
        view.levelLabel.text = @[@"Lv-1", @"Lv-3", @"Lv-5"][i];
        view.titleLabel.text = @[@"普通会员", @"超级会员", @"至尊会员"][i];
        [_firstBgView addSubview:view];
    }
    
    
}

@end

/////////

@implementation customPointTitle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layOutLabels];
    }
    return self;
}
- (void)layOutLabels
{
    _levelLabel = [UILabel new];
//    _levelLabel.text = @"Lv-1";
    _levelLabel.font = [UIFont systemFontOfSize:11];
    _levelLabel.textAlignment = NSTextAlignmentCenter;
    _levelLabel.textColor = [UIColor colorWithHex:0xfdeef4];
    [self addSubview:_levelLabel];
    
    UIView *circleV = [UIView new];
    circleV.backgroundColor = [UIColor whiteColor];
    [circleV handleCornerRadiusWithRadius:2];
    [self addSubview:circleV];
    
    _titleLabel = [UILabel new];
//    _titleLabel.text = @"普通会员";
    _titleLabel.font = [UIFont systemFontOfSize:11];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithHex:0xfdeef4];
    [self addSubview:_titleLabel];
    
    CGFloat self_H = CGRectGetHeight(self.frame);
    CGFloat view_H = self_H/2 - 6 - 2;
    [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(view_H));
        make.bottom.equalTo(circleV.mas_top).with.offset(-6);
    }];
    
    [circleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(4));
        make.height.equalTo(@(4));
        make.centerX.equalTo(_levelLabel);
        make.centerY.equalTo(_levelLabel);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(circleV.mas_bottom).with.offset(6);
        make.right.equalTo(@(0));
        make.height.equalTo(@(view_H));
    }];
}

@end

