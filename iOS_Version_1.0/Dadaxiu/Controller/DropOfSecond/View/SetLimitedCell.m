//
//  SetLimitedCell.m
//  testSecondsView
//
//  Created by ping_L on 2017/6/2.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import "SetLimitedCell.h"

#define left_padding 12
#define right_padding left_padding

#define info_font 13*kScreen_Width/375
#define info_height 38*kScreen_Width/375
#define headView_height 14*kScreen_Width/375
#define headView_width 60*kScreen_Width/375

#define headView_collectionview_padding 20*kScreen_Width/375
#define item_padding 10*kScreen_Width/375

#define item_width (kScreen_Width-2*left_padding-item_padding)/2
#define item_height 255*item_width/170

@interface SetLimitedCell ()

@end

@implementation SetLimitedCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self layoutSubviewCell];
    }
    return  self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    SetLimitedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    for (int i = 0; i < 2; i++) {
        LimitedSubView *view = [[LimitedSubView alloc] initWithFrame:CGRectMake(left_padding+i*(item_width+item_padding), 0, item_width, item_height)];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSetLimitedAction)]];
        [self.contentView addSubview:view];
    }
}

- (void)clickSetLimitedAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickSetLimitedCell:)]) {
        [_delegate clickSetLimitedCell:self];
    }
}

@end



//////

#define img_width self.frame.size.width
#define img_height img_width

#define img_title_padding 15*kScreen_Width/375
#define title_historyPrice_padidng 8*kScreen_Width/375
#define historyPrice_nowPrice_padding 9*kScreen_Width/375
#define price_bottom_padding 12*kScreen_Width/375

#define action_btn_width 60*kScreen_Width/375
#define action_btn_height 17*kScreen_Width/375

#define title_font 13*kScreen_Width/375
#define newPrice_font 12*kScreen_Width/375
#define historyPrice_font 11*kScreen_Width/375

@interface LimitedSubView ()

@end

@implementation LimitedSubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCell];
    }
    return self;
}

- (void)layoutCell
{
    UIImageView *img = [UIImageView new];
    img.backgroundColor = DefaultImgBgColor;
    [img handleCornerRadiusWithRadius:5];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(0));
        make.width.equalTo(@(img_width));
        make.height.equalTo(@(img_height));
    }];
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"ELLE女短裤2017春夏新品70048系列";
    titleLb.font = [UIFont systemFontOfSize:title_font];
    titleLb.textColor = FirstTextColor;
    [self addSubview:titleLb];
    
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(img.mas_bottom).with.offset(img_title_padding);
    }];
    
    UILabel *historyPriceLb = [UILabel new];
    historyPriceLb.text = @"¥85";
    historyPriceLb.font = [UIFont systemFontOfSize:historyPrice_font];
    historyPriceLb.textColor = IconTextColor;
    [self addSubview:historyPriceLb];
    
    [historyPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(titleLb.mas_bottom).with.offset(historyPrice_font);
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
    nowPriceLb.text = @"¥57";
    nowPriceLb.font = [UIFont systemFontOfSize:newPrice_font];
    nowPriceLb.textColor = ThemeColor;
    [self addSubview:nowPriceLb];
    
    [nowPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(historyPriceLb.mas_bottom).with.offset(historyPrice_nowPrice_padding);
        make.bottom.equalTo(@(-price_bottom_padding));
    }];
    
    UILabel *actionLb = [UILabel new];
    actionLb.text = @"立即秒杀";
    actionLb.font = [UIFont systemFontOfSize:newPrice_font];
    actionLb.textColor = [UIColor whiteColor];
    actionLb.backgroundColor = ThemeColor;
    actionLb.textAlignment = NSTextAlignmentCenter;
    [actionLb handleCornerRadiusWithRadius:3];
    [self addSubview:actionLb];
    
    [actionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.centerY.equalTo(nowPriceLb);
        make.width.equalTo(@(action_btn_width));
        make.height.equalTo(@(action_btn_height));
    }];
}

@end


