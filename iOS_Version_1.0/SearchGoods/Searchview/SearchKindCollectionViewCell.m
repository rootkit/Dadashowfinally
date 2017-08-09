//
//  SearchKindCollectionViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SearchKindCollectionViewCell.h"
#define IMG_W CGRectGetWidth(self.contentView.frame)
#define IMG_H IMG_W

#define IMG_title_padding 8*kScreen_Width/375
#define title_price_padding 12*kScreen_Width/375
#define price_bottom_padding 12*kScreen_Width/375


@interface SearchKindCollectionViewCell()
@property (nonatomic, strong) UIImageView *IMG;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *countLb;
@property(nonatomic,strong) UIImageView* goodscarimage;

@end

@implementation SearchKindCollectionViewCell
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
    SearchKindCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}


- (void)layoutSubs
{
    _IMG = [UIImageView new];
    _IMG.image = [UIImage imageNamed:@"allgoods"];
    [_IMG handleCornerRadiusWithRadius:5];
    [self.contentView addSubview:_IMG];
    [_IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(IMG_H));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"韩都衣舍春季新款女装潮";
    _titleLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _titleLb.textColor = [UIColor colorWithHex:0x353434];
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_IMG.mas_bottom).with.offset(IMG_title_padding);
        make.left.equalTo(@(0));
        make.height.equalTo(@(13*kScreen_Width/375));
        make.right.equalTo(@(0));
    }];
    
    _priceLb = [UILabel new];
    _priceLb.text = @"¥169.40";
    _priceLb.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    _priceLb.textColor = ThemeColor;
    [self.contentView addSubview:_priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).with.offset(title_price_padding);
        make.left.equalTo(@(0));
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-price_bottom_padding);
    }];
    
    _goodscarimage = [UIImageView new];
    _goodscarimage.image = [UIImage imageNamed:@"buy_1"];
    [self.contentView addSubview:_goodscarimage];
    [_goodscarimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_IMG.mas_right);
        make.bottom.equalTo(_priceLb.mas_bottom);
        make.width.equalTo(@(33*kScreen_Width/375));
        make.height.equalTo(@(15*kScreen_Width/375));
    }];

    _countLb = [UILabel new];
    _countLb.text = @"已售25件";
    _countLb.font = [UIFont systemFontOfSize:11*kScreen_Width/375];
    _countLb.textColor = [UIColor colorWithHex:0xa6a6a6];
    [self.contentView addSubview:_countLb];
    [_countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo( _goodscarimage.mas_left).with.offset(-8*kScreen_Width/375);
        make.bottom.equalTo(_priceLb.mas_bottom);
   }];
    
   
}

@end
