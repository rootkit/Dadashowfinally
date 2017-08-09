//
//  OrderGoodsCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OrderGoodsCell.h"

@interface OrderGoodsCell ()

@property (strong, nonatomic) UILabel *shopsNameLb;
@property (strong, nonatomic) UIImageView *goodsIMG;
@property (strong, nonatomic) UILabel *goodsNameLb;
@property (strong, nonatomic) UILabel *goodsInfoLb;
@property (strong, nonatomic) UILabel *goodsPriceLb;
@property (strong, nonatomic) UILabel *goodsOldPriceLb;
@property (strong, nonatomic) UILabel *goodsCountLb;

@property (strong, nonatomic) UIView *goodsDetailView;

@end

@implementation OrderGoodsCell
{
    BOOL _isTouchStore;
    BOOL _isTouchGoods;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self layoutSubviewCell];
    }
    return  self;
}

+ (instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)layoutSubviewCell
{
    UIView *topView = [UIView new];
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(33*rating));
    }];
    
    UIImageView* shopnameimageview = [UIImageView new];
    shopnameimageview.image=[UIImage imageNamed:@"店铺图标"];
    [topView addSubview:shopnameimageview];
    [shopnameimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(topView);
        make.width.equalTo(@(13*rating));
        make.height.equalTo(@(12*rating));
        
    }];
    
    UILabel *shopnamelabel = [UILabel new];
    shopnamelabel.text = @"乐町旗舰店";
    shopnamelabel.font = [UIFont systemFontOfSize:12*rating];
    shopnamelabel.textColor = InfoTextColor;
    [topView addSubview:shopnamelabel];
    [shopnamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopnameimageview);
        make.left.equalTo(shopnameimageview.mas_right).equalTo(@(7*rating));
    }];
    
    UIImageView *pushImg = [UIImageView new];
    pushImg.image = [UIImage imageNamed:@"ico_push"];
    [topView addSubview:pushImg];
    [pushImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopnamelabel.mas_right).with.offset(10*rating);
        make.centerY.equalTo(topView);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(12*rating));
    }];
    
    ////////
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(topView.mas_bottom);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@0);
    }];
    
    UIImageView *goodsImg = [UIImageView new];
    goodsImg.backgroundColor = DefaultImgBgColor;
    [goodsImg handleCornerRadiusWithRadius:3];
    [bottomView addSubview:goodsImg];
    [goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.centerY.equalTo(bottomView);
        make.width.equalTo(@(70*rating));
        make.height.equalTo(@(70*rating));
    }];
    
    UILabel *priceLb = [UILabel new];
    priceLb.text = @"¥169.40";
    priceLb.textAlignment = NSTextAlignmentRight;
    priceLb.font = [UIFont systemFontOfSize:14*rating];
    priceLb.textColor = InfoTextColor;
    [bottomView addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsImg.mas_top);
        make.right.equalTo(@(-12));
    }];
    
    UILabel *historyPriceLb = [UILabel new];
    historyPriceLb.text = @"¥180.00";
    historyPriceLb.font = [UIFont systemFontOfSize:12*rating];
    historyPriceLb.textColor = [UIColor colorWithHex:0x949393];
    [bottomView addSubview:historyPriceLb];
    [historyPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLb.mas_bottom).with.offset(5*rating);
        make.right.equalTo(@(-12));
    }];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor colorWithHex:0x949393];
    [historyPriceLb addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(1));
        make.centerY.equalTo(historyPriceLb);
    }];
    
    UILabel *goodsNameLb = [UILabel new];
    goodsNameLb.textColor = InfoTextColor;
    goodsNameLb.text = @"乐町2017夏季新款女装绿色短款刺绣宽松短袖T恤女夏韩版纯色上衣";
    goodsNameLb.font = [UIFont systemFontOfSize:12*rating];
    goodsNameLb.numberOfLines = 0;
    goodsNameLb.lineBreakMode = NSLineBreakByWordWrapping;
    [bottomView addSubview:goodsNameLb];
    [goodsNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImg.mas_right).with.offset(10*rating);
        make.top.equalTo(goodsImg.mas_top);
        make.right.equalTo(priceLb.mas_left).with.offset(-20*rating);
    }];
    
    
    UILabel *countLb = [UILabel new];
    countLb.text = @"x1";
    countLb.font = [UIFont systemFontOfSize:11*rating];
    countLb.textColor = [UIColor colorWithHex:0x949393];
    [bottomView addSubview:countLb];
    [countLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(historyPriceLb.mas_bottom).with.offset(8*rating);
        make.right.equalTo(@(-12));
    }];
    
    UILabel *detailInfoLb = [UILabel new];
    detailInfoLb.text = @"颜色：橙色； 尺码：M";
    detailInfoLb.font = [UIFont systemFontOfSize:11*rating];
    detailInfoLb.textColor = [UIColor colorWithHex:0x949393];
    [bottomView addSubview:detailInfoLb];
    [detailInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countLb);
        make.left.equalTo(goodsNameLb.mas_left);
        make.height.equalTo(@(11*rating));
    }];
    
    self.shopsNameLb = shopnamelabel;
    self.goodsIMG = goodsImg;
    self.goodsNameLb = goodsNameLb;
    self.goodsPriceLb = priceLb;
    self.goodsOldPriceLb = historyPriceLb;
    self.goodsCountLb = countLb;
    self.goodsInfoLb = detailInfoLb;
    
    self.goodsDetailView = bottomView;
}

- (void)setGoods:(DDXShopCartGoods *)goods
{
    _goods = goods;
    
    self.shopsNameLb.text = goods.storeName;
    [self.goodsIMG loadPicture:[NSURL URLWithString:goods.imageUrl]];
    self.goodsNameLb.text = goods.itemName;
    self.goodsPriceLb.text = [NSString stringWithFormat:@"¥%ld", (long)goods.itemPriceNow];
    self.goodsOldPriceLb.text = [NSString stringWithFormat:@"¥%ld", (long)goods.itemPrice];
    self.goodsCountLb.text = [NSString stringWithFormat:@"x%ld", (long)goods.itemNum];;
    self.goodsInfoLb.text = [NSString stringWithFormat:@"颜色：%@；尺码：%@", goods.itemColor.length ? @"随机" : goods.itemColor, goods.itemSize.length ? @"均码" : goods.itemSize];;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isTouchStore = NO;
    _isTouchGoods = NO;
    
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:self.shopsNameLb];
    CGPoint p2 = [t locationInView:self.goodsDetailView];
    
    if (CGRectContainsPoint(self.shopsNameLb.bounds, p1)) {
        _isTouchStore = YES;
    } else if (CGRectContainsPoint(self.goodsDetailView.bounds, p2)) {
        _isTouchGoods = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isTouchStore) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickOrderForGoodsStore:)]) {
            [_delegate clickOrderForGoodsStore:self];
        }
    } else if (_isTouchGoods) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickOrderForGoodsDetail:)]) {
            [_delegate clickOrderForGoodsDetail:self];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isTouchStore || !_isTouchGoods) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
