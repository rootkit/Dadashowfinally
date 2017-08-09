//
//  GoodsReclassifyCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsReclassifyCell.h"


#define item_W 64 * kScreen_Width / 375
#define item_H item_W
#define img_title_padding 13 * kScreen_Width / 375

@interface GoodsReclassifyCell ()

@property (nonatomic, strong) UIImageView *iconIMG;
@property (nonatomic, strong) UILabel *titleLb;

@end

@implementation GoodsReclassifyCell

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
    GoodsReclassifyCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    return item;
}

- (void)layoutSubs
{
    _iconIMG = [UIImageView new];
    _iconIMG.backgroundColor = DefaultImgBgColor;
    [self.contentView addSubview:_iconIMG];
    [_iconIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.width.equalTo(@(item_W));
        make.height.equalTo(@(item_H));
        make.centerX.equalTo(self.contentView);
    }];
    
    _titleLb = [UILabel new];
    _titleLb.text = @"新春上新";
    _titleLb.adjustsFontSizeToFitWidth = YES;
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = [UIColor colorWithHex:0x443b36];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(_iconIMG.mas_bottom).with.offset(img_title_padding);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
}

- (void)setModel:(GoodsFirstClassifyModel *)model
{
    _iconIMG.backgroundColor = [UIColor clearColor];
    _iconIMG.image = [UIImage imageNamed:model.icon];
    _titleLb.text = model.title;
}

@end


/**** GoodsSecondClassifyModel ****/

@implementation GoodsSecondClassifyModel


@end
