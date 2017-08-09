//
//  CouponPopViewCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CouponPopViewCell.h"

#define price_font 18
#define info_font 13
#define time_font 11
#define button_font 15

#define cell_left_padding 12
#define cell_right_padding cell_left_padding
#define cell_top_padding 12
#define cell_bottom_padding cell_top_padding

#define price_info_padding 10
#define info_time_padding 10
#define btn_width 62
#define btn_height 26

@interface CouponPopViewCell ()

@property (nonatomic, strong) UIButton *couponBtn;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *infoLb;
@property (nonatomic, strong) UILabel *timeLb;

@end

@implementation CouponPopViewCell

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
    CouponPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    UIButton *button = [UIButton new];
//    [button setTitle:@"领取" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:button_font];
    button.layer.cornerRadius = 3;
//    button.backgroundColor = ThemeColor;
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    _couponBtn = button;
    [_couponBtn setTitle:@"已领取" forState:UIControlStateNormal];
    _couponBtn.backgroundColor = IconTextColor;
    _couponBtn.selected = NO;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(btn_width));
        make.height.equalTo(@(btn_height));
        make.right.equalTo(@(-cell_right_padding));
        make.centerY.equalTo(self);
    }];
    
    UILabel *priceLb = [UILabel new];
    priceLb.text = @"40元";
    priceLb.textColor = ThemeColor;
    priceLb.font = [UIFont systemFontOfSize:price_font];
    [self.contentView addSubview:priceLb];
    _priceLb = priceLb;
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(cell_top_padding));
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(@(-cell_right_padding));
    }];
    
    UILabel *infoLb = [UILabel new];
    infoLb.text = @"订单满200元使用";
    infoLb.textColor = FirstTextColor;
    infoLb.font = [UIFont systemFontOfSize:info_font];
    [self.contentView addSubview:infoLb];
    _infoLb = infoLb;
    [infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLb.mas_bottom).with.offset(price_info_padding);
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(button.mas_left).with.offset(-10);
        make.centerY.equalTo(self);
    }];
    
    UILabel *timeLb = [UILabel new];
    timeLb.text = @"使用期限 2017.03.25~2017.05.25";
    timeLb.textColor = IconTextColor;
    timeLb.font = [UIFont systemFontOfSize:time_font];
    [self.contentView addSubview:timeLb];
    _timeLb = timeLb;
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLb.mas_bottom).with.offset(info_time_padding);
        make.left.equalTo(@(cell_left_padding));
        make.right.equalTo(@(-cell_right_padding));
    }];
}

#pragma mark - action
- (void)clickAction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickGetCouponAction:)]) {
        [_delegate clickGetCouponAction:self];
    }
}

- (void)changeButtonState:(BOOL)isGet
{
    if (isGet) {
        [_couponBtn setTitle:@"已领取" forState:UIControlStateNormal];
        _couponBtn.backgroundColor = IconTextColor;
        _couponBtn.selected = NO;
    } else {
        [_couponBtn setTitle:@"领取" forState:UIControlStateNormal];
        _couponBtn.backgroundColor = ThemeColor;
        _couponBtn.selected = YES;
    }
    
}

@end
