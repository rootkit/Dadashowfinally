//
//  SelectedLimitedCollectCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/2.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SelectedLimitedCollectCell.h"

#define img_width self.frame.size.width
#define img_height img_width

#define img_title_padding 5*kScreen_Width/375
#define title_info_padidng 9*kScreen_Width/375
#define info_bottom_padding 5*kScreen_Width/375

#define title_newPrice_font 12*kScreen_Width/375
#define historyPrice_font 11*kScreen_Width/375

@implementation SelectedLimitedCollectCell

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
    SelectedLimitedCollectCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    item.backgroundColor = [UIColor whiteColor];
    
    return item;
}

- (void)layoutCell
{
    UIImageView *img = [UIImageView new];
    img.backgroundColor = DefaultImgBgColor;
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(0));
        make.width.equalTo(@(img_width));
        make.height.equalTo(@(img_height));
    }];
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"ELLE女短裤2017春夏新品70048系列";
    titleLb.font = [UIFont systemFontOfSize:title_newPrice_font];
    titleLb.textColor = FirstTextColor;
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.numberOfLines = 0;
    titleLb.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:titleLb];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(img.mas_bottom).with.offset(img_title_padding);
    }];
    
    UILabel *historyPriceLb = [UILabel new];
    historyPriceLb.text = @"¥89";
    historyPriceLb.font = [UIFont systemFontOfSize:historyPrice_font];
    historyPriceLb.textColor = IconTextColor;
    [self.contentView addSubview:historyPriceLb];
    
    [historyPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(titleLb.mas_bottom).with.offset(title_newPrice_font);
        make.bottom.equalTo(@(-info_bottom_padding));
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = IconTextColor;
    [historyPriceLb addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.centerY.equalTo(historyPriceLb);
        make.height.equalTo(@(1));
    }];
    
    UILabel *nowPriceLb = [UILabel new];
    nowPriceLb.text = @"¥69";
    nowPriceLb.font = [UIFont systemFontOfSize:title_newPrice_font];
    nowPriceLb.textColor = ThemeColor;
    nowPriceLb.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:nowPriceLb];
    
    [nowPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(historyPriceLb.mas_right).with.offset(10);
        make.right.equalTo(@(0));
        make.centerY.equalTo(historyPriceLb);
    }];
}

@end
