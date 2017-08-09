//
//  KindClothesCollectionViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "KindClothesCollectionViewCell.h"

#define item_W 27 * kScreen_Width / 375
#define item_H item_W

#define top_img_padding 19 * kScreen_Width / 375

#define img_title_padding 13 * kScreen_Width / 375

@interface KindClothesCollectionViewCell ()

@property (nonatomic, strong) UIImageView *goodIMG;
@property (nonatomic, strong) UILabel *goodnameLb;

@end

@implementation KindClothesCollectionViewCell
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
    KindClothesCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutCell
{
    _goodIMG = [UIImageView new];
    _goodIMG.image = [UIImage imageNamed:@"icon_women_Home"];
    [self.contentView addSubview:_goodIMG];
    [_goodIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(top_img_padding);
        make.width.equalTo(@(item_W));
        make.height.equalTo(@(item_H));
        make.centerX.equalTo(self.contentView);
    }];
    
    _goodnameLb = [UILabel new];
    _goodnameLb.text = @"女装";
    _goodnameLb.font = [UIFont systemFontOfSize:10];
    _goodnameLb.textColor = [UIColor colorWithHex:0x333333];
    _goodnameLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_goodnameLb];
    [_goodnameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(_goodIMG.mas_bottom).with.offset(img_title_padding);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
}

- (void)setModel:(GoodsFirstClassifyModel *)model
{
    _goodIMG.image = [UIImage imageNamed:model.icon];
    _goodnameLb.text = model.title;
}

@end


@implementation GoodsFirstClassifyModel

//

@end
