//
//  GoodsOrderCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsOrderCell.h"

#define cell_padding_left 12
#define cell_padding_right cell_padding_left
#define cell_padding_top 10
#define cell_padding_bottom cell_padding_top

@interface GoodsOrderCell ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *shopsNameLb;
@property (nonatomic, strong) UILabel *orderStateLb;

@property (nonatomic, strong) UIView *normalView;
@property (nonatomic, strong) UIImageView *imageIMG;
@property (nonatomic, strong) UILabel *goodNameLb;
@property (nonatomic, strong) UILabel *goodInfoLb;
@property (nonatomic, strong) UILabel *goodPriceLb;
@property (nonatomic, strong) UILabel *goodOldPriceLb;
@property (nonatomic, strong) UILabel *goodNumLb;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *orderInfoLb;
@property (nonatomic, strong) UIButton *orderButtonLeft;
@property (nonatomic, strong) UIButton *orderButtonCenter;
@property (nonatomic, strong) UIButton *orderButtonRight;

@end

@implementation GoodsOrderCell
{
    BOOL _isClickGoods;
}

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
    GoodsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
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
        make.top.equalTo(@(10));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    //////
    _topView = [UIView new];
    [subView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subView.mas_top).with.offset(0);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(45*rating));
    }];
    
    _shopsNameLb = [UILabel new];
    _shopsNameLb.text = @"cherrykoko 旗舰店";
    _shopsNameLb.font = [UIFont systemFontOfSize:14*rating];
    _shopsNameLb.textColor = FirstTextColor;
    [_topView addSubview:_shopsNameLb];
    [_shopsNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_padding_left));
        make.centerY.equalTo(_topView);
    }];
    
    _orderStateLb = [UILabel new];
    _orderStateLb.text = @"交易成功";
    _orderStateLb.font = [UIFont systemFontOfSize:14*rating];
    _orderStateLb.textColor = ThemeColor;
    [_topView addSubview:_orderStateLb];
    [_orderStateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopsNameLb.mas_right).with.offset(5);
        make.centerY.equalTo(_topView);
        make.right.equalTo(@(-cell_padding_right));
    }];
    
    /////
    _normalView = [UIView new];
    _normalView.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    [subView addSubview:_normalView];
    [_normalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(0);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(100*rating));
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = BackCellColor;
    [_normalView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_normalView.mas_top).with.offset(0);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(1));
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = BackCellColor;
    [_normalView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_normalView.mas_bottom).with.offset(-1);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(1));
    }];
    
    _imageIMG = [UIImageView new];
    _imageIMG.backgroundColor = DefaultImgBgColor;
    [_imageIMG handleCornerRadiusWithRadius:3];
    [_normalView addSubview:_imageIMG];
    [_imageIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_padding_left));
        make.width.equalTo(@(70*rating));
        make.height.equalTo(@(70*rating));
        make.centerY.equalTo(_normalView);
    }];
    
    _goodNameLb = [UILabel new];
    _goodNameLb.text = @"cherrykoko 韩版女立领拼接条纹时尚百搭露背黑色长袖连衣裙中长款";
    _goodNameLb.font = [UIFont systemFontOfSize:12*rating];
    _goodNameLb.textColor = FirstTextColor;
    _goodNameLb.numberOfLines = 2;
    _goodNameLb.lineBreakMode = NSLineBreakByCharWrapping;
    [_normalView addSubview:_goodNameLb];
    [_goodNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageIMG.mas_top);
        make.left.equalTo(_imageIMG.mas_right).with.offset(15*rating);
        make.right.equalTo(@(-cell_padding_right));
    }];
    
    _goodInfoLb = [UILabel new];
    _goodInfoLb.text = @"颜色：黑色；尺码：M";
    _goodInfoLb.font = [UIFont systemFontOfSize:12*rating];
    _goodInfoLb.textColor = IconTextColor;
    [_normalView addSubview:_goodInfoLb];
    [_goodInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodNameLb.mas_bottom).with.offset(8*rating);
        make.left.equalTo(_goodNameLb.mas_left);
        make.right.equalTo(@(cell_padding_right));
        make.height.equalTo(@(12*rating));
    }];
    
    _goodPriceLb = [UILabel new];
    _goodPriceLb.text = @"¥169.40";
    _goodPriceLb.font = [UIFont systemFontOfSize:17*rating];
    _goodPriceLb.textColor = FirstTextColor;
    [_normalView addSubview:_goodPriceLb];
    [_goodPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodNameLb.mas_left);
        make.top.equalTo(_goodInfoLb.mas_bottom).with.offset(12*rating);
//        make.bottom.equalTo(_imageIMG.mas_bottom);
        make.height.equalTo(@(13*rating));
    }];
    
    _goodOldPriceLb = [UILabel new];
    _goodOldPriceLb.text = @"¥308.00";
    _goodOldPriceLb.textAlignment = NSTextAlignmentLeft;
    _goodOldPriceLb.font = [UIFont systemFontOfSize:12*rating];
    _goodOldPriceLb.textColor = IconTextColor;
    [_normalView addSubview:_goodOldPriceLb];
    [_goodOldPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodPriceLb.mas_right).with.offset(20*rating);
        make.centerY.equalTo(_goodPriceLb);
    }];
    
    UILabel* line=[UILabel new];
    line.backgroundColor=[UIColor colorWithHex:0xa8a8a8];
    [_goodOldPriceLb addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@6);
        make.left.equalTo(_goodOldPriceLb.mas_left);
        make.height.equalTo(@1);
        make.right.equalTo(_goodOldPriceLb.mas_right);
        
    }];
    
    _goodNumLb = [UILabel new];
    _goodNumLb.text = @"x1";
    _goodNumLb.font = [UIFont systemFontOfSize:12*rating];
    _goodNumLb.textColor = [UIColor colorWithHex:0x585757];
    _goodNumLb.textAlignment = NSTextAlignmentRight;
    [_normalView addSubview:_goodNumLb];
    [_goodNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_normalView.mas_right).with.offset(-cell_padding_right);
        make.centerY.equalTo(_goodPriceLb);
    }];
    
    //////
    _bottomView = [UIView new];
    [subView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_normalView.mas_bottom).with.offset(0);
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    UILabel *orderPostagePayLb = [UILabel new];
    orderPostagePayLb.text = @"(含运费：0.00)";
    orderPostagePayLb.font = [UIFont systemFontOfSize:12*rating];
    orderPostagePayLb.textColor = FirstTextColor;
    [_bottomView addSubview:orderPostagePayLb];
    [orderPostagePayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(14*rating));
        make.right.equalTo(@(-cell_padding_right));
    }];
    
    _orderInfoLb = [UILabel new];
    _orderInfoLb.text = @"共1件商品 合计：¥169.40";
    _orderInfoLb.attributedText = [Util changeStringType:@"共1件商品 合计：" withPrice:@"¥169.40" withTypeFont:[UIFont systemFontOfSize:12*rating] withPriceFont:[UIFont systemFontOfSize:14*rating] withReturn:NO];
    _orderInfoLb.textAlignment = NSTextAlignmentRight;
    _orderInfoLb.textColor = FirstTextColor;
    [_bottomView addSubview:_orderInfoLb];
    [_orderInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderPostagePayLb);
        make.left.equalTo(@(cell_padding_left));
        make.right.equalTo(orderPostagePayLb.mas_left);
    }];
    
    
    _orderButtonRight = [UIButton new];
    _orderButtonRight.tag = 1;
    [_orderButtonRight setTitle:@"付款" forState:UIControlStateNormal];
    _orderButtonRight.titleLabel.font = [UIFont systemFontOfSize:14*rating];
    [_orderButtonRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _orderButtonRight.layer.cornerRadius = 2;
    _orderButtonRight.backgroundColor = ThemeColor;
    [_bottomView addSubview:_orderButtonRight];
    [_orderButtonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-cell_padding_right));
        make.width.equalTo(@(78*rating));
        make.height.equalTo(@(32*rating));
        make.top.equalTo(_orderInfoLb.mas_bottom).with.offset(20*rating);
    }];
    
    _orderButtonCenter = [UIButton new];
    _orderButtonCenter.tag = 2;
    [_orderButtonCenter setTitle:@"取消订单" forState:UIControlStateNormal];
    _orderButtonCenter.titleLabel.font = [UIFont systemFontOfSize:14*rating];
    [_orderButtonCenter setTitleColor:FirstTextColor forState:UIControlStateNormal];
    [_orderButtonCenter handleBoardWidth:1 andBorderColor:IconTextColor];
    _orderButtonCenter.layer.cornerRadius = 3;
    [_bottomView addSubview:_orderButtonCenter];
    [_orderButtonCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_orderButtonRight.mas_left).with.offset(-15*rating);
        make.width.equalTo(@(78*rating));
        make.height.equalTo(@(32*rating));
        make.centerY.equalTo(_orderButtonRight);
    }];
    
    _orderButtonLeft = [UIButton new];
    _orderButtonLeft.tag = 3;
    [_orderButtonLeft setTitle:@"联系卖家" forState:UIControlStateNormal];
    _orderButtonLeft.titleLabel.font = [UIFont systemFontOfSize:14*rating];
    [_orderButtonLeft setTitleColor:FirstTextColor forState:UIControlStateNormal];
    [_orderButtonLeft handleBoardWidth:1 andBorderColor:IconTextColor];
    _orderButtonLeft.layer.cornerRadius = 3;
    [_bottomView addSubview:_orderButtonLeft];
    [_orderButtonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_orderButtonCenter.mas_left).with.offset(-15*rating);
        make.width.equalTo(@(78*rating));
        make.height.equalTo(@(32*rating));
        make.centerY.equalTo(_orderButtonCenter);
    }];
    
    [_orderButtonLeft addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_orderButtonCenter addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_orderButtonRight addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickBtnActionWithGoodsOrderCell:andBtnTag:)]) {
        [_delegate clickBtnActionWithGoodsOrderCell:self andBtnTag:button.tag];
    }
}

#pragma mark - set

- (void)setOrderTypes:(GoodsOrderTypes)orderTypes
{
    _orderTypes = orderTypes;
    
    _orderButtonLeft.hidden = NO;
    _orderButtonCenter.hidden = NO;
    _orderButtonRight.hidden = NO;
    
    switch (orderTypes) {
        case GoodsOrderTypesWithObligation:
        {
            _orderStateLb.text = @"等待付款";
            [_orderButtonLeft setTitle:@"联系卖家" forState:UIControlStateNormal];
            [_orderButtonCenter setTitle:@"取消订单" forState:UIControlStateNormal];
            [_orderButtonRight setTitle:@"付款" forState:UIControlStateNormal];
            break;
        }
        case GoodsOrderTypesWithWaitForReceiv:
        {
            _orderStateLb.text = @"卖家已发货";
            [_orderButtonLeft setTitle:@"延长收货" forState:UIControlStateNormal];
            [_orderButtonCenter setTitle:@"查看物流" forState:UIControlStateNormal];
            [_orderButtonRight setTitle:@"确认收货" forState:UIControlStateNormal];
            break;
        }
        case GoodsOrderTypesWithRemainTobeEvaluated:
        {
            _orderStateLb.text = @"交易成功";
            [_orderButtonLeft setTitle:@"删除订单" forState:UIControlStateNormal];
            [_orderButtonCenter setTitle:@"查看物流" forState:UIControlStateNormal];
            [_orderButtonRight setTitle:@"评价" forState:UIControlStateNormal];
            break;
        }
        case GoodsOrderTypesWithAfterSale:
        {
            _orderStateLb.text = @"退款成功";
            _orderButtonLeft.hidden = YES;
            _orderButtonCenter.hidden = YES;
            [_orderButtonRight setTitle:@"钱款去向" forState:UIControlStateNormal];
            break;
        }
        default:
        {
            _orderStateLb.text = @"等待付款";
//            [_orderButtonLeft setTitle:@"按钮状态1" forState:UIControlStateNormal];
//            [_orderButtonCenter setTitle:@"按钮状态2" forState:UIControlStateNormal];
//            [_orderButtonRight setTitle:@"按钮状态3" forState:UIControlStateNormal];
            [_orderButtonLeft setTitle:@"联系卖家" forState:UIControlStateNormal];
            [_orderButtonCenter setTitle:@"取消订单" forState:UIControlStateNormal];
            [_orderButtonRight setTitle:@"付款" forState:UIControlStateNormal];
            break;
        }
    }
}

- (void)setGoodsOrderModel:(DDXGoodsOrderModel *)goodsOrderModel
{
    _goodsOrderModel = goodsOrderModel;
    DDXShopCartGoods *shopCartGoods = [DDXShopCartGoods osc_modelWithDictionary:goodsOrderModel.items[0]];
    _shopsNameLb.text = shopCartGoods.storeName;;
    _orderStateLb.text = goodsOrderModel.orderStatus;
    [_imageIMG loadPicture:[NSURL URLWithString:shopCartGoods.imageUrl]];
    _goodNameLb.text = shopCartGoods.itemName;
    _goodInfoLb.text = [NSString stringWithFormat:@"颜色：%@；尺码：%@", shopCartGoods.itemColor.length ? shopCartGoods.itemColor : @"随机", shopCartGoods.itemSize.length ? shopCartGoods.itemSize : @"均码"];
    _goodPriceLb.text = [NSString stringWithFormat:@"¥%ld", (long)shopCartGoods.itemPriceNow];
    _goodOldPriceLb.text = [NSString stringWithFormat:@"¥%ld", (long)shopCartGoods.itemPrice];
    _goodNumLb.text = [NSString stringWithFormat:@"x%ld", (long)shopCartGoods.itemNum];
    _orderInfoLb.text = [NSString stringWithFormat:@"共%ld件商品 合计：¥%.2f", (long)shopCartGoods.itemNum, (shopCartGoods.itemNum * shopCartGoods.itemPriceNow)];
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _isClickGoods = NO;
    
    UITouch *touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:_normalView];
    
    if (CGRectContainsPoint(_normalView.frame, point)) {
        _isClickGoods = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isClickGoods) {
        if ([_delegate respondsToSelector:@selector(clickPushToGoodsDetail:)]) {
            [_delegate clickPushToGoodsDetail:self];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isClickGoods) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end








