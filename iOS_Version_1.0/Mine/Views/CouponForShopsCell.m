//
//  CouponForShopsCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CouponForShopsCell.h"

#define img_height coupon_Height
#define img_width 96*rating

#define invalidIcon_W 83*rating
#define invalidIcon_H 58*rating

@interface CouponForShopsCell ()

@property (nonatomic, strong) UILabel *couponAmountLb; //面值
@property (nonatomic, strong) UILabel *couponConditionLb;   //条件
@property (nonatomic, strong) UIImageView *shopsIcon;
@property (nonatomic, strong) UILabel *shopsNameLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UIButton *actionBtn;

@property (nonatomic, strong) UIView *couponLeftView;
@property (nonatomic, strong) UIImageView *couponInvalidIcon;

@end

@implementation CouponForShopsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutSubviewCell];
    }
    return self;
}


+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    CouponForShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = BackCellColor;
    return cell;
}

-(void)layoutSubviewCell
{
    UIView *subView = [UIView new];
    subView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5));
        make.left.equalTo(@(cell_padding_left));
        make.right.equalTo(@(-cell_padding_right));
        make.bottom.equalTo(@(-5));
    }];
    
    subView.layer.cornerRadius = 5;
    subView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    subView.layer.shadowOffset = CGSizeMake(1, 1);
    subView.layer.shadowOpacity = 0.7; //设置阴影的不透明度
    subView.layer.shadowRadius = 4.0;  //设置阴影的半径
    
    UIView *imgBottomView = [UIView new];
    imgBottomView.clipsToBounds = YES;
    imgBottomView.backgroundColor = RandomColor;
    [subView addSubview:imgBottomView];
    [imgBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(img_width));
    }];
    _couponLeftView = imgBottomView;
    
    ///
    UIView *leftTopView = [UIView new];
    [imgBottomView addSubview:leftTopView];
    [leftTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBottomView.mas_left).with.offset(0);
        make.top.equalTo(imgBottomView.mas_top).with.offset(0);
        make.right.equalTo(imgBottomView.mas_right).with.offset(0);
        make.height.equalTo(@(img_height/2));
    }];
    
    UILabel *priceLb = [UILabel new];
    priceLb.attributedText = [Util changeStringType:@"¥"
                                          withPrice:@" 200"
                                       withTypeFont:[UIFont systemFontOfSize:14]
                                      withPriceFont:[UIFont systemFontOfSize:24]
                                         withReturn:NO];
    priceLb.textAlignment = NSTextAlignmentCenter;
    priceLb.textColor = [UIColor whiteColor];
    [leftTopView addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTopView.mas_left).with.offset(0);
        make.right.equalTo(leftTopView.mas_right).with.offset(0);
        make.bottom.equalTo(leftTopView.mas_bottom).with.offset(0);
    }];
    _couponAmountLb = priceLb;
    
    ////
    UIView *leftBottomView = [UIView new];
    [imgBottomView addSubview:leftBottomView];
    [leftBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBottomView.mas_left).with.offset(0);
        make.top.equalTo(leftTopView.mas_bottom).with.offset(0);
        make.right.equalTo(imgBottomView.mas_right).with.offset(0);
        make.bottom.equalTo(imgBottomView.mas_bottom).with.offset(0);
    }];
    
    UILabel *infoLb = [UILabel new];
    infoLb.text = @"满299元可用";
    infoLb.textAlignment = NSTextAlignmentCenter;
    infoLb.textColor = [UIColor whiteColor];
    infoLb.font = [UIFont systemFontOfSize:12];
    [leftBottomView addSubview:infoLb];
    [infoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBottomView.mas_left).with.offset(0);
        make.right.equalTo(leftBottomView.mas_right).with.offset(0);
        make.top.equalTo(leftBottomView.mas_top).with.offset(0);
    }];
    _couponConditionLb = infoLb;
    
    /////
    UIView *topView = [UIView new];
    [subView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBottomView.mas_right).with.offset(0);
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(img_height/2));
    }];
    
    UIImageView *shopIcon = [UIImageView new];
    shopIcon.image = [UIImage imageNamed:@"logo_1"];
    [topView addSubview:shopIcon];
    [shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(8));
        make.width.equalTo(@(31));
        make.height.equalTo(@(31));
        make.centerY.equalTo(topView);
    }];
    _shopsIcon = shopIcon;
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"cherrykoko旗舰店店铺优惠券"; //  coupon_invalid
    titleLb.textColor = FirstTextColor;
    titleLb.font = [UIFont systemFontOfSize:14];
    [topView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopIcon.mas_right).with.offset(8);
        make.right.equalTo(@(-12));
        make.centerY.equalTo(topView);
    }];
    _shopsNameLb = titleLb;
    
    /////
    UIView *bottomView = [UIView new];
    [subView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBottomView.mas_right).with.offset(0);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *timeLb = [UILabel new];
    timeLb.text = @"2017.02.03-2017.05.20";
    timeLb.textColor = [UIColor colorWithHex:0x585757];
    timeLb.font = [UIFont systemFontOfSize:10];
    [bottomView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(8));
        make.centerY.equalTo(bottomView);
    }];
    _timeLb = timeLb;
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitle:@"立即使用" forState:UIControlStateNormal];
    button.backgroundColor = ThemeColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLb.mas_right).with.offset(10);
        make.right.equalTo(@(-12));
        make.width.equalTo(@(65));
        make.height.equalTo(@(24));
        make.centerY.equalTo(bottomView);
    }];
    _actionBtn = button;//
    
    UIImageView *invalidImg = [UIImageView new];
    invalidImg.image = [UIImage imageNamed:@"coupon_invalid"];
    [imgBottomView addSubview:invalidImg];
    [invalidImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(invalidIcon_W));
        make.height.equalTo(@(invalidIcon_H));
        make.centerX.equalTo(imgBottomView);
        make.centerY.equalTo(imgBottomView);
    }];
    _couponInvalidIcon = invalidImg;
}

- (void)action:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickBtnActionWithCouponForShopsCell:)]) {
        [_delegate clickBtnActionWithCouponForShopsCell:self];
    }
}

- (void)setModel:(DDXCouponModel *)model
{
    _couponAmountLb.attributedText = [Util changeStringType:@"¥"
                                                  withPrice:[NSString stringWithFormat:@"  %.2ld", (long)model.price]
                                               withTypeFont:[UIFont systemFontOfSize:14]
                                              withPriceFont:[UIFont systemFontOfSize:24]
                                                 withReturn:NO];
    _couponConditionLb.text = model.info;
    _shopsIcon.image = [UIImage imageNamed:model.logo];
    _shopsNameLb.text = model.title;
    _timeLb.text = model.time;
    _actionBtn.hidden = !model.isUsing;
    if (!model.isUsing) {
        _couponLeftView.backgroundColor = [UIColor colorWithHex:0xa8a8a8];
        _couponInvalidIcon.hidden = NO;
    } else {
        _couponInvalidIcon.hidden = YES;
    }
}

@end


@implementation DDXCouponModel

@end



