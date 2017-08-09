//
//  ShopClassifyView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ShopClassifyView.h"

@interface ShopClassifyView ()

@property (strong, nonatomic) UILabel *titleLb;

@end

@implementation ShopClassifyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubs];
    }
    return self;
}

+ (instancetype)returnResueCellFormCollectionView:(UICollectionView *)collectionView
                                        indexPath:(NSIndexPath *)indexPath
                                       identifier:(NSString *)identifier
{
    ShopClassifyView *item = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = BackCellColor;
    return item;
}

- (void)layoutSubs
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.top.equalTo(@(5));
    }];
    
    UILabel *chunkLv = [UILabel new];
    chunkLv.backgroundColor = ThemeColor;
    [bottomView addSubview:chunkLv];
    [chunkLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.width.equalTo(@(3));
        make.height.equalTo(@(15));
        make.centerY.equalTo(self);
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"全部宝贝";
    _titleLb.textColor = [UIColor colorWithHex:0x3f3f3f];
    _titleLb.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:_titleLb];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chunkLv.mas_right).with.offset(10);
        make.centerY.equalTo(self);
    }];
    
    _pushBtn = [UIButton new];
    [_pushBtn setImage:[UIImage imageNamed:@"ico_push"] forState:UIControlStateNormal];
    [bottomView addSubview:_pushBtn];
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLb.mas_right).with.offset(10);
        make.right.equalTo(@(-12));
        make.width.equalTo(@(100));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    [_pushBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 90, 0, 0)];
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLb.text = title;
}

@end
