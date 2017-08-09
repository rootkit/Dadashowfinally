//
//  CheapcomeViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CheapcomeViewCell.h"
#define IMG_W CGRectGetWidth(self.contentView.frame)
#define IMG_H IMG_W

#define IMG_title_padding 8*kScreen_Width/375
#define historicalprice_padding 10*kScreen_Width/375
#define title_price_padding 12*kScreen_Width/375
#define price_bottom_padding 12*kScreen_Width/375

@interface CheapcomeViewCell ()

@property (nonatomic, strong) UIImageView *IMG;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *countLb;

@end
@implementation CheapcomeViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self layoutSubs];
    }
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
indexPath:(NSIndexPath *)indexPath
identifier:(NSString *)identifier
{
    CheapcomeViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutSubs
{
    _IMG = [UIImageView new];
    _IMG.image = [UIImage imageNamed:@"image5"];
    [_IMG handleCornerRadiusWithRadius:5];
    [self.contentView addSubview:_IMG];
    [_IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(3*kScreen_Width/375));
        make.left.equalTo(@(0));
        make.right.equalTo(@(-0));
        make.height.equalTo(@(IMG_H));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"2017春秋女装新款外套";
    _titleLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _titleLb.textColor = [UIColor colorWithHex:0x353434];
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_IMG.mas_bottom).with.offset(IMG_title_padding);
        make.left.equalTo(@(10*kScreen_Width/375));
        make.height.equalTo(@(13*kScreen_Width/375));
        make.right.equalTo(@(0));
    }];
    
    UILabel* historicalprice = [UILabel new];
    historicalprice.text = @"¥170.0";
    historicalprice.font = [UIFont systemFontOfSize:11*kScreen_Width/375];
    historicalprice.textColor =[UIColor colorWithHex:0xa8a8a8];
    [self.contentView addSubview:historicalprice];
    [historicalprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).with.offset(historicalprice_padding);
        make.left.equalTo(_titleLb.mas_left);
    }];
    
    UILabel* line=[UILabel new];
    line.backgroundColor=[UIColor colorWithHex:0xa8a8a8];
    [historicalprice addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(6*kScreen_Width/375));
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    
    _priceLb = [UILabel new];
    _priceLb.text = @"¥169.40";
    _priceLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _priceLb.textColor = ThemeColor;
    [self.contentView addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(historicalprice.mas_bottom).with.offset(historicalprice_padding);
        make.left.equalTo(_titleLb.mas_left);
    }];
    
    _countLb = [UILabel new];
    _countLb.text = @"21已抢";
    _countLb.font = [UIFont systemFontOfSize:11*kScreen_Width/375];
    _countLb.textColor = [UIColor colorWithHex:0xa6a6a6];
    [self.contentView addSubview:_countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(historicalprice.mas_bottom).with.offset(historicalprice_padding);
        make.right.equalTo(@-0);
    }];
    
    UIButton * commercebtn=[[UIButton alloc]init];
    [commercebtn.layer setMasksToBounds:YES];
    [commercebtn.layer setCornerRadius:3.0];
    commercebtn.backgroundColor=[UIColor colorWithHex:0xfc5c98];
    [commercebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commercebtn setTitle:@"特惠抢购" forState:UIControlStateNormal];
    commercebtn.titleLabel.font=[UIFont systemFontOfSize:15*kScreen_Width/375];
    [commercebtn addTarget:self action:@selector(commerce) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:commercebtn];
    [commercebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLb.mas_bottom).with.offset(historicalprice_padding);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@(30*kScreen_Width/375));
    }];
}
-(void)commerce{
    NSLog(@"特惠抢购");
}



@end
