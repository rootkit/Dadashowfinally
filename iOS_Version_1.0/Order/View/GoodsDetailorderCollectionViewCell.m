//
//  GoodsDetailorderCollectionViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsDetailorderCollectionViewCell.h"
#define IMG_W CGRectGetWidth(self.contentView.frame)
#define IMG_H IMG_W
#define IMG_title_padding 8*kScreen_Width/375
#define title_price_padding 12*kScreen_Width/375
#define price_bottom_padding 12*kScreen_Width/375

@interface GoodsDetailorderCollectionViewCell ()

@property (nonatomic, strong) UIImageView *IMG;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *countLb;
@property (nonatomic, strong) UIImageView *countIMG;

@end


@implementation GoodsDetailorderCollectionViewCell

- (id)initWithFrame:(CGRect)frame
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
    GoodsDetailorderCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    return item;
}

- (void)layoutSubs
{
    UIView*  backview=[[UIView alloc]initWithFrame:CGRectMake(0, 0,170*(kScreen_Height/667),246*(kScreen_Height/667))];
    backview.backgroundColor=[UIColor whiteColor];
//    backview.layer.cornerRadius =5;
//    backview.layer.masksToBounds = YES;
    [self.contentView addSubview:backview];
    
    _IMG = [UIImageView new];
    _IMG.image = [UIImage imageNamed:@"2"];
    [_IMG handleCornerRadiusWithRadius:5];
    [backview addSubview:_IMG];
    
    [_IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(IMG_H));
    }];
    
    _priceLb = [UILabel new];
    _priceLb.text = @"¥169.40";
    _priceLb.font = [UIFont systemFontOfSize:12];
    _priceLb.textColor =[UIColor blackColor];
    [backview addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(5*(kScreen_Height/667)));
        make.bottom.equalTo(@(-5*(kScreen_Height/667)));
    }];
    
   _countIMG  = [UIImageView new];
    _countIMG.contentMode = UIViewContentModeScaleAspectFit;
    _countIMG.image= [UIImage imageNamed:@"goods_collect"];
    [backview addSubview:_countIMG];
    
    [_countIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-7*(kScreen_Height/667)));
        make.right.equalTo(@(-5*(kScreen_Height/667)));
    }];
    
    
    _countLb = [UILabel new];
    _countLb.text = @"2156";
    _countLb.font = [UIFont systemFontOfSize:11];
    _countLb.textColor = [UIColor colorWithHex:0xa6a6a6];
    [backview addSubview:_countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_priceLb.mas_bottom);
        make.right.equalTo(_countIMG.mas_left).equalTo(@(-3*(kScreen_Height/667)));
    }];
    
    UILabel* leftlabel = [UILabel new];
    leftlabel.text = @"针织吊带";
    leftlabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    leftlabel.font = [UIFont systemFontOfSize:10*(kScreen_Height/667)];
    leftlabel.textColor = [UIColor colorWithHex:0x949393];
    [backview addSubview:leftlabel];
    [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_priceLb.mas_top).equalTo(@(-12*(kScreen_Height/667)));
        make.left.equalTo(_priceLb.mas_left);
    }];
    
    UILabel* centerlabel = [UILabel new];
    centerlabel.text = @"九分裤";
    centerlabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    centerlabel.font = [UIFont systemFontOfSize:10*(kScreen_Height/667)];
    centerlabel.textColor = [UIColor colorWithHex:0x949393];
    [backview addSubview:centerlabel];
    [centerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftlabel.mas_top);
        make.left.equalTo(leftlabel.mas_right).equalTo(@(5*(kScreen_Height/667)));
    }];
    
    UILabel* rightlabel = [UILabel new];
    rightlabel.text = @"套装";
    rightlabel.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    rightlabel.font = [UIFont systemFontOfSize:10*(kScreen_Height/667)];
    rightlabel.textColor = [UIColor colorWithHex:0x949393];
    [backview addSubview:rightlabel];
    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftlabel.mas_top);
        make.left.equalTo(centerlabel.mas_right).equalTo(@(5*(kScreen_Height/667)));
    }];
    
    
}
@end
