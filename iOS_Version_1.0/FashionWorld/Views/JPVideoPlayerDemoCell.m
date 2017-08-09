/*
 * This file is part of the JPVideoPlayer package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/Chris-Pan
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "JPVideoPlayerDemoCell.h"
#import "UIView+WebVideoCache.h"



@interface JPVideoPlayerDemoCell()<JPVideoPlayerDelegate>

@end

@implementation JPVideoPlayerDemoCell

-(void)awakeFromNib{
    [super awakeFromNib];
   
   
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.videoImv.jp_videoPlayerDelegate = self;
        [self  setvideocell];
    }
    return  self;
}

-(void)setvideocell{
    
    UILabel* titleabel = [UILabel new];
    titleabel.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    titleabel.textColor =[UIColor colorWithHex:0xd8d8d8];
    titleabel.backgroundColor=[UIColor colorWithHex:0x3f3f3f];
    titleabel.text=@"她不用大牌傍身只穿基础款,借鉴度这么高我全学会了";
    [self addSubview:titleabel];
    [titleabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10*kScreen_Width/375));
        make.left.equalTo(@(15*kScreen_Width/375));
        
    }];

    
    UIImageView* imageview=[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"detailview"];
    [self addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleabel.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@(([UIScreen mainScreen].bounds.size.width*9.0/16.0)));
    }];
    _videoImv=imageview;
//    self.videoImv.alpha=0.3;
    self.backgroundColor=[UIColor colorWithHex:0x3f3f3f];
  
    UIImageView* portraitIMG = [UIImageView new];
    portraitIMG.layer.masksToBounds = YES;
    portraitIMG.layer.cornerRadius = 17*(kScreen_Width/375); //圆角（圆形）
    portraitIMG.image = [UIImage imageNamed:@"collect_shop_userPortrait"];
    [self addSubview:portraitIMG];
    [portraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).equalTo(@(10*kScreen_Width/375));
        make.left.equalTo(@(12*kScreen_Width/375));
        make.width.equalTo(@(35*kScreen_Width/375));
        make.height.equalTo(@(35*kScreen_Width/375));
    }];

    UILabel* nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithHex:0xd8d8d8];
    nameLabel.text=@"AISA HOME";
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.left.equalTo(portraitIMG.mas_right).equalTo(@(12*kScreen_Width/375));
    }];

    UILabel* information = [UILabel new];
    information.font = [UIFont systemFontOfSize:14];
    information.textColor = [UIColor colorWithHex:0xd8d8d8];
    information.text=@"25";
    [self addSubview:information];
    [information mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top);
        make.right.equalTo(@(-12*kScreen_Width/375));
    }];
    
    UIImageView*transIMG = [UIImageView new];
    transIMG.image=[UIImage imageNamed:@"ico_comment"];
    [self addSubview:transIMG];
    [transIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.right.equalTo(information.mas_left).equalTo(@(-4*kScreen_Width/375));
        make.width.equalTo(@(20*kScreen_Width/375));
        make.height.equalTo(@(17*kScreen_Width/375));
    }];
    
    UILabel* likelabel = [UILabel new];
    likelabel.font = [UIFont systemFontOfSize:14];
    likelabel.textColor = [UIColor colorWithHex:0xd8d8d8];
    likelabel.text=@"345";
    [self addSubview:likelabel];
    [likelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top);
        make.right.equalTo(transIMG.mas_left).equalTo(@(-14*kScreen_Width/375));
    }];
    
    UIImageView* likeimage = [UIImageView new];
    likeimage.image=[UIImage imageNamed:@"ico_like"];
    [self addSubview:likeimage];
    [likeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.right.equalTo(likelabel.mas_left).equalTo(@(-4*kScreen_Width/375));
        make.width.equalTo(@(20*kScreen_Width/375));
        make.height.equalTo(@(17*kScreen_Width/375));
    }];
    
    UILabel* whitchlabel = [UILabel new];
    whitchlabel.font = [UIFont systemFontOfSize:14];
    whitchlabel.textColor = [UIColor colorWithHex:0xd8d8d8];
    whitchlabel.text=@"4.3亿";
    [self addSubview:whitchlabel];
    [whitchlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top);
        make.right.equalTo(likeimage.mas_left).equalTo(@(-14*kScreen_Width/375));
    }];
    
    UIImageView* watchIMG = [UIImageView new];
    watchIMG.image = [UIImage imageNamed:@"ico_watch"];
    [self addSubview:watchIMG];
    [watchIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.right.equalTo(whitchlabel.mas_left).equalTo(@(-4*kScreen_Width/375));
        make.width.equalTo(@(20*kScreen_Width/375));
        make.height.equalTo(@(17*kScreen_Width/375));
    }];

    UIButton * playbtn=[[UIButton alloc]init];
    [playbtn setBackgroundImage:[UIImage imageNamed:@"ico_like"] forState:UIControlStateNormal];
//    [playbtn addTarget:self action:@selector(clickplay) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:playbtn];
    [playbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-12*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(15*(kScreen_Height/667)));
        make.height.equalTo(@(15*(kScreen_Height/667)));
    }];
    _playbtn=playbtn;
    
    
    
}



//-(void)setIndexPath:(NSIndexPath *)indexPath{
//    _indexPath = indexPath;
//    
//    if (indexPath.row%2) {
//        self.videoImv.image = [UIImage imageNamed:@"detailview"];
//    }
//    else{
//        self.videoImv.image = [UIImage imageNamed:@"detailview"];
//    }
//    self.videoImv.alpha=0.3;
//    self.backgroundColor=[UIColor blackColor];
//}


#pragma mark -----------------------------------------
#pragma mark JPVideoPlayerDelegate

-(BOOL)videoPlayerManager:(JPVideoPlayerManager *)videoPlayerManager shouldAutoReplayForURL:(NSURL *)videoURL{
    // do something here.
    return YES;
}

-(BOOL)videoPlayerManager:(JPVideoPlayerManager *)videoPlayerManager shouldDownloadVideoForURL:(NSURL *)videoURL{
    // do something here.
    return YES;
}

//-(BOOL)shouldProgressViewOnTop{
//    return YES;
//}


@end
