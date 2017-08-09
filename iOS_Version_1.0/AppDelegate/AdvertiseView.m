//
//  AdvertiseView.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/18.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 启动页 ****/
#import "AdvertiseView.h"
#import "UIImageView+WebCache.h"

#define subleftloading 18*(kScreen_Height/667)
#define subcenterloading 10*(kScreen_Height/667)
#define suballloading 46*(kScreen_Height/667)
#define addwithloading 23*(kScreen_Height/667)


@interface AdvertiseView()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;
@property (nonatomic, assign) CGFloat imageheight;


@end

// 广告显示的时间
static int const showtime = 5;

@implementation AdvertiseView
- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        UIImageView *advImagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        advImagev.image = [UIImage imageNamed:@"adv_start"];
        [self addSubview:advImagev];
        
//        _imageheight=165*(kScreen_Height/667);
//        // 1.广告图片
//        _adView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, _imageheight)];
//        _adView.userInteractionEnabled = YES;
//        
//        [_adView sd_setImageWithURL:[NSURL URLWithString:@"http://www.desktx.com/d/file/wallpaper/comic/20161127/78f7411af95e6fb9e278d4ce1eeb7e49.jpg"]];
//        _adView.contentMode = UIViewContentModeScaleAspectFill;
//        _adView.clipsToBounds = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
//        [_adView addGestureRecognizer:tap];
//        
//        _imageheight=_imageheight+45*(kScreen_Height/667);
//        NSLog(@"%f",_imageheight);
//        for (int i=0; i<4; i++) {
//            UIImageView* subimageview=[[UIImageView alloc]init];
//            subimageview.frame=CGRectMake(subleftloading+i*(kScreen_Width-suballloading)/2+subcenterloading*i, _imageheight, (kScreen_Width-suballloading)/2,(kScreen_Width-suballloading)/2);
//            if (i>=2) {
//             subimageview.frame=CGRectMake(subleftloading+(i-2)*(kScreen_Width-suballloading)/2+subcenterloading*(i-2), _imageheight+(kScreen_Width-suballloading)/2+subcenterloading, (kScreen_Width-suballloading)/2,(kScreen_Width-suballloading)/2);
//            }
//            subimageview.contentMode = UIViewContentModeScaleAspectFill;
//            subimageview.clipsToBounds = YES;
//            [subimageview sd_setImageWithURL:[NSURL URLWithString:@"http://www.desktx.com/d/file/wallpaper/comic/20161127/78f7411af95e6fb9e278d4ce1eeb7e49.jpg"]];
//            [subimageview.layer setMasksToBounds:YES];
//            [subimageview.layer setCornerRadius:3.0];
//            [self addSubview:subimageview];
//            
//            UILabel* titlelabls=[[UILabel alloc]init];
//            titlelabls.backgroundColor=[UIColor colorWithRed:105.0/255.0 green:105.0/255.0 blue:105.0/255.0 alpha:0.4];
//            titlelabls.font = [UIFont systemFontOfSize:10*(kScreen_Height/667)];
//            titlelabls.textColor=[UIColor colorWithHex:0xffffff];
//            titlelabls.text=@"新款女装潮宽松红色短袖";
//            [subimageview addSubview:titlelabls];
//            [titlelabls mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(@-0);
//                make.left.equalTo(@(8*(kScreen_Height/667)));
//                make.right.equalTo(@-0);
//                make.height.equalTo(@(24*(kScreen_Height/667)));
//            }];
//        }
//        UIButton * addressbtn=[[UIButton alloc]init];
//        [addressbtn setBackgroundImage:[UIImage imageNamed:@"Add_icon"] forState:UIControlStateNormal];
//        addressbtn.frame=CGRectMake(17*(kScreen_Height/667), 175*(kScreen_Height/667), addwithloading, addwithloading);
//        [self addSubview:addressbtn];
//        
//        UILabel* addresslable=[[UILabel alloc]init];
//        addresslable.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
//        addresslable.textColor=[UIColor colorWithHex:0x666666];
//        addresslable.textAlignment=NSTextAlignmentLeft;
//        addresslable.text=@"福田区KKONE商场";
//        [self addSubview:addresslable];
//        [addresslable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(addressbtn.mas_top);
//            make.left.equalTo(addressbtn.mas_right).equalTo(@(5*(kScreen_Height/667)));
//            make.width.equalTo(@(kScreen_Width/3));
//            make.bottom.equalTo(addressbtn.mas_bottom);
//        }];
//        
//        UILabel* phonelable=[[UILabel alloc]init];
//        phonelable.font = [UIFont systemFontOfSize:12*(kScreen_Height/667)];
//        phonelable.textColor=[UIColor colorWithHex:0x666666];
//        phonelable.textAlignment=NSTextAlignmentRight;
//        phonelable.text=@"0755-131131213";
//        [self addSubview:phonelable];
//        [phonelable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(addressbtn.mas_top);
//            make.right.equalTo(@(-18*(kScreen_Height/667)));
//            make.bottom.equalTo(addressbtn.mas_bottom);
//        }];
//        
//        UIButton * phonebtn=[[UIButton alloc]init];
//        [phonebtn setBackgroundImage:[UIImage imageNamed:@"phone_icon"] forState:UIControlStateNormal];
//        [self addSubview:phonebtn];
//        [phonebtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(addressbtn.mas_top);
//            make.right.equalTo(phonelable.mas_left).equalTo(@(-5*(kScreen_Height/667)));
//            make.width.equalTo(@(addwithloading));
//            make.bottom.equalTo(addressbtn.mas_bottom);
//        }];
//        
//        
//        UIImageView* iconview=[[UIImageView alloc]init];
//        iconview.image=[UIImage imageNamed:@"Dada_applogo"];
//        [self addSubview:iconview];
//        [iconview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@((kScreen_Width-50*(kScreen_Height/667))/2));
//            make.width.height.equalTo(@(50*(kScreen_Height/667)));
//            make.bottom.equalTo(@(-48*(kScreen_Height/667)));
//        }];
//        
//        UILabel* dadalabl=[[UILabel alloc]init];
//        dadalabl.font = [UIFont systemFontOfSize:13*(kScreen_Height/667)];
//        dadalabl.textColor=[UIColor blackColor];
//        dadalabl.textAlignment=NSTextAlignmentCenter;
//        dadalabl.text=@"搭搭秀";
//        [self addSubview:dadalabl];
//        [dadalabl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(iconview.mas_bottom).equalTo(@0);
//            make.left.equalTo(@0);
//            make.right.equalTo(@-0);
//            make.height.equalTo(@(30*(kScreen_Height/667)));
//        }];
//
//        // 2.跳过按钮
        CGFloat btnW = 45*(kScreen_Height/667);
        CGFloat btnH = 20*(kScreen_Height/667);
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - btnW - 24*(kScreen_Height/667), btnH, btnW, btnH)];
        [_countBtn setBackgroundImage:[UIImage imageNamed:@"skip_bg"] forState:UIControlStateNormal];
        [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:9*(kScreen_Height/667)];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.layer.cornerRadius = 4;
        
//        [self addSubview:_adView];
        [self addSubview:_countBtn];
        
    }
    return self;
}


//- (void)pushToAd{
//    if (self.headclickblock) {
//        self.headclickblock();
//
//    }
//
//}

- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self.countTimer invalidate];
        self.countTimer = nil;
        [self dismiss];
    }
}

- (void)show
{
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)show:(UIViewController*)vc
{
    [self startTimer];
    [vc.view addSubview:self];
}

// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// 移除广告页面
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.countTimer invalidate];
    }];
    
}

-(void)dealloc{
    NSLog(@"视图销毁");
    [self.countTimer invalidate];
}

@end
