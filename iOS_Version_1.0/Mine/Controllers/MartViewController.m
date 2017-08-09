//
//  MartViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 二维码 *****/
#import "MartViewController.h"

#define rating kScreen_Width/375
@interface MartViewController ()

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIImageView *martBgImg;

@property (nonatomic, strong) UIImageView *userPortrait;
@property (nonatomic, strong) UIImageView *userSexIcon;
@property (nonatomic, strong) UIImageView *martImg;
@property (nonatomic, strong) UILabel *userNameLb;
@property (nonatomic, strong) UILabel *descLb;

@property (nonatomic, strong) NSTimer *animationTimer;

@end

@implementation MartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"二维码";
    [self.view addSubview:self.customView];//my_mart1
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(loadAnimationForImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.animationTimer forMode:NSRunLoopCommonModes];
    
    [self setInfomationForUser];
}

- (void)dealloc
{
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)customView
{
    if (!_customView) {
        _customView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height)];
        _customView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *userPortrait = [UIImageView new];
        userPortrait.backgroundColor = DefaultImgBgColor;
        [userPortrait handleCornerRadiusWithRadius:3];
        [_customView addSubview:userPortrait];
        
        [userPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12*rating));
            make.top.equalTo(@(19*rating));
            make.width.equalTo(@(56*rating));
            make.height.equalTo(@(56*rating));
        }];
        
        UILabel *nameLb = [UILabel new];
        nameLb.text = @"七秒金鱼";
        nameLb.textColor = [UIColor blackColor];
        nameLb.font = [UIFont systemFontOfSize:15*rating];
        [_customView addSubview:nameLb];
        [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(userPortrait.mas_right).with.offset(13*rating);
            make.top.equalTo(@(23*rating));
        }];
        
        UIImageView *sexIcon = [UIImageView new];
        sexIcon.image = [UIImage imageNamed:@"ico_woman"];
        [_customView addSubview:sexIcon];
        [sexIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLb.mas_right).with.offset(10*rating);
            make.width.equalTo(@(13*rating));
            make.height.equalTo(@(13*rating));
            make.centerY.equalTo(nameLb);
        }];
        
        UILabel *descLb = [UILabel new];
        descLb.text = @"等我有钱了，买两根棒棒糖，一根我吃给你看，一根你看着我吃";
        descLb.textColor = [UIColor colorWithHex:0x676767];
        descLb.font = [UIFont systemFontOfSize:12*rating];
        descLb.numberOfLines = 0;
        descLb.lineBreakMode = NSLineBreakByWordWrapping;
        [_customView addSubview:descLb];
        [descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLb.mas_left);
            make.top.equalTo(nameLb.mas_bottom).with.offset(10*rating);
            make.right.equalTo(@(-12*rating));
        }];
        
        UIImageView *martBgIcon = [UIImageView new];//mymart_1
        martBgIcon.image = [UIImage imageNamed:@"mymart_1"];
        [_customView addSubview:martBgIcon];
        [martBgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userPortrait.mas_bottom).with.offset(31*rating);
            make.width.equalTo(@(269*rating));
            make.height.equalTo(@(371*rating));
            make.centerX.equalTo(_customView);
        }];
        
        UIImageView *martImg = [UIImageView new];//mymart_1
        martImg.image=[UIImage imageNamed:@"dadaxiuurl"];
        [martImg handleCornerRadiusWithRadius:25];
        [martBgIcon addSubview:martImg];
        [martImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-9*rating));
            make.width.equalTo(@(258*rating));
            make.height.equalTo(@(258*rating));
            make.centerX.equalTo(martBgIcon);
        }];
        
        UILabel *tagLb = [UILabel new];
        tagLb.text = @"扫一扫二维码，加我好友~";
        tagLb.textAlignment = NSTextAlignmentCenter;
        tagLb.textColor = [UIColor colorWithHex:0x828282];
        tagLb.font = [UIFont systemFontOfSize:15*rating];
        [_customView addSubview:tagLb];
        [tagLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(martBgIcon.mas_bottom).with.offset(37*rating);
            make.centerX.equalTo(_customView);
        }];
        
        self.userPortrait = userPortrait;
        self.userNameLb = nameLb;
        self.userSexIcon = sexIcon;
        self.descLb = descLb;
        self.martImg = martImg;
        self.martBgImg = martBgIcon;
    }
    return _customView;
}

- (void)setInfomationForUser
{
    DDXUserinfo *userInfo = [DDXUserinfo loadUserInfoFromSanbox];
    
    [self.userPortrait loadPortrait:[NSURL URLWithString:userInfo.headerUrl]];
    self.userNameLb.text = userInfo.alias;
    self.userSexIcon.image = [UIImage imageNamed:(userInfo.sex == UserSexTypeForMale ? @"ico_man" : @"ico_woman")];
    self.descLb.text = userInfo.personality.length ? userInfo.personality : @"暂无个性签名";
//    [self.martImg loadPicture:[NSURL URLWithString:userInfo.martUrl]];
}

- (void)loadAnimationForImage
{
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 8; i++) {
        NSString *imageString = [NSString stringWithFormat:@"mymart_%d", i];
        UIImage *image = [UIImage imageNamed:imageString];
//        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageString ofType:nil]];
        [images addObject:image];
    }
    self.martBgImg.animationImages = images;
    self.martBgImg.animationDuration = 0.6f;
    self.martBgImg.animationRepeatCount = 1;
    [self.martBgImg startAnimating];
    [self.martBgImg performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.martBgImg.animationDuration+1.0f];
}

@end
