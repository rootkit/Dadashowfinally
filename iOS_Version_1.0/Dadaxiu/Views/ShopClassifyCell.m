//
//  ShopClassifyCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ShopClassifyCell.h"

@interface ShopClassifyCell ()

@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation ShopClassifyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self layoutCell];
        
    }
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    ShopClassifyCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutCell
{
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = [UIColor colorWithHex:0x3f3f3f];
    [self.contentView addSubview:_titleLb];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(20));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _titleLb.text = title;
}

@end
