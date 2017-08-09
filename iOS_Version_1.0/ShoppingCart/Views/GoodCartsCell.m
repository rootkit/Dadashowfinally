//
//  GoodCartsCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodCartsCell.h"
#import "UIColorHF.h"
#import "UIImageView+Comment.h"

#define kScreen_W [UIScreen mainScreen].bounds.size.width

#define rating kScreen_Width/375

#define cell_padding_left 12*rating
#define cell_padding_right cell_padding_left
#define cell_padding_top 18*rating
#define cell_padding_bottom cell_padding_top

#define selected_W_H 20*rating
#define image_W 81*rating
#define image_H 96*rating
#define goodInfo_H 18*rating

#define deleteBtn_W 67*rating

@interface GoodCartsCell ()

@property (nonatomic, strong) UIImageView *imageIMG;

@property (nonatomic, strong) UIView *normalView;
@property (nonatomic, strong) UILabel *goodNameLb;
@property (nonatomic, strong) UILabel *goodInfoLb;
@property (nonatomic, strong) UILabel *goodPriceLb;
@property (nonatomic, strong) UILabel *goodOldPriceLb;
@property (nonatomic, strong) UILabel *goodNumLb;

@property (nonatomic, strong) UIView *deleteView;
@property (nonatomic, strong) UIView *goodChgV;
@property (nonatomic, strong) UIButton *subButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *numLb;
@property (nonatomic, strong) UILabel *goodInfoLabel;

@end

@implementation GoodCartsCell

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
    GoodCartsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithHex:0xf9f9f9];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)layoutSubviewCell
{
    _selectedBtn = [UIButton new];
    [_selectedBtn setImage:[GoodCartsCell unGoodsSelectedImage] forState:UIControlStateNormal];
    [self.contentView addSubview:_selectedBtn];
    [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        make.centerY.equalTo(self.contentView);
    }];
    
    [_selectedBtn addTarget:self action:@selector(chooseGoodsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _imageIMG = [UIImageView new];
    _imageIMG.backgroundColor = ThemeColor;
    _imageIMG.image = [UIImage imageNamed:@"collect_goods"];
    _imageIMG.contentMode = UIViewContentModeScaleAspectFill;
    [_imageIMG handleCornerRadiusWithRadius:3];
    [self.contentView addSubview:_imageIMG];
    [_imageIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectedBtn.mas_right).with.offset(6);
        make.width.equalTo(@(image_W));
        make.height.equalTo(@(image_H));
        make.centerY.equalTo(self.contentView);
    }];
    
    //normal
    _normalView = [UIView new];
    [self.contentView addSubview:_normalView];
    [_normalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(_imageIMG.mas_right).with.offset(0);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    
    _goodNameLb = [UILabel new];
    _goodNameLb.text = @"cherrykoko 韩版女立领拼接条纹长袖连衣裙";
    _goodNameLb.font = [UIFont systemFontOfSize:12];
    _goodNameLb.textColor = [UIColor colorWithHex:0x585757];
    _goodNameLb.numberOfLines = 2;
    _goodNameLb.lineBreakMode = NSLineBreakByCharWrapping;
    [_normalView addSubview:_goodNameLb];
    [_goodNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(cell_padding_top));
        make.left.equalTo(@(4));
        make.right.equalTo(@(-cell_padding_right));
    }];
    
    _goodInfoLb = [UILabel new];
    _goodInfoLabel.text = @"颜色：黑色；尺码：M";
    _goodInfoLb.font = [UIFont systemFontOfSize:12];
    _goodInfoLb.textColor = IconTextColor;
    [_normalView addSubview:_goodInfoLb];
    [_goodInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodNameLb.mas_bottom).with.offset(10);
        make.left.equalTo(@(4));
        make.right.equalTo(@(cell_padding_right));
        make.centerY.equalTo(_normalView);
    }];
    
    _goodPriceLb = [UILabel new];
    _goodPriceLb.text = @"¥169.40";
    _goodPriceLb.font = [UIFont systemFontOfSize:17];
    _goodPriceLb.textColor = FirstTextColor;
    [_normalView addSubview:_goodPriceLb];
    [_goodPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cell_padding_left));
        make.top.equalTo(_goodInfoLb.mas_bottom).with.offset(26);
//        make.width.equalTo(@(60));
        make.bottom.equalTo(_imageIMG.mas_bottom);
    }];
    
    _goodOldPriceLb = [UILabel new];
    _goodOldPriceLb.text = @"¥308.00";
    _goodOldPriceLb.textAlignment = NSTextAlignmentCenter;
    _goodOldPriceLb.font = [UIFont systemFontOfSize:12];
    _goodOldPriceLb.textColor = IconTextColor;
    [_normalView addSubview:_goodOldPriceLb];
    [_goodOldPriceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodPriceLb.mas_right).with.offset(20);
//        make.width.equalTo(@(60));
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
    _goodNumLb.font = [UIFont systemFontOfSize:12];
    _goodNumLb.textColor = [UIColor colorWithHex:0x585757];
    _goodNumLb.textAlignment = NSTextAlignmentRight;
    [_normalView addSubview:_goodNumLb];
    [_goodNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_goodOldPriceLb.mas_right).with.offset(10);
        make.right.equalTo(_normalView.mas_right).with.offset(-cell_padding_right);
        make.centerY.equalTo(_goodPriceLb);
    }];
    
    
    //delete
    _deleteView = [UIView new];
    [self.contentView addSubview:_deleteView];
    [_deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(_imageIMG.mas_right).with.offset(0);
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];
    
    _goodChgV = [UIView new];
    [_deleteView addSubview:_goodChgV];
    
    _goodInfoLabel = [UILabel new];
    _goodInfoLabel.text = @"颜色：黑色；尺码：M";
    _goodInfoLabel.font = [UIFont systemFontOfSize:12];
    _goodInfoLabel.textColor = IconTextColor;
    _goodInfoLabel.textAlignment = NSTextAlignmentCenter;
    [_deleteView addSubview:_goodInfoLabel];
    
    _deleteBtn = [UIButton new];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _deleteBtn.backgroundColor = ThemeColor;
    [_deleteView addSubview:_deleteBtn];
    _deleteBtn.tag = 3;
    [_deleteBtn addTarget:self action:@selector(changeGoodsNumAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _numLb = [UILabel new];
    _numLb.text = @"104";
    _numLb.font = [UIFont systemFontOfSize:18];
    _numLb.textColor = FirstTextColor;
    _numLb.textAlignment = NSTextAlignmentCenter;
    [_goodChgV addSubview:_numLb];
    
    _subButton = [UIButton new];
    [_subButton setImage:[UIImage imageNamed:@"goods_sub"] forState:UIControlStateNormal];
    _subButton.tag = 1;
    [_subButton addTarget:self action:@selector(changeGoodsNumAction:) forControlEvents:UIControlEventTouchUpInside];
    [_goodChgV addSubview:_subButton];
    
    _addButton = [UIButton new];
    [_addButton setImage:[UIImage imageNamed:@"goods_add"] forState:UIControlStateNormal];
    _addButton.tag = 2;
    [_addButton addTarget:self action:@selector(changeGoodsNumAction:) forControlEvents:UIControlEventTouchUpInside];
    [_goodChgV addSubview:_addButton];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(deleteBtn_W));
    }];
    
    [_goodChgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_deleteView).with.offset(- 10);
        make.left.equalTo(@(10));
        make.height.equalTo(@(40));
        make.right.equalTo(_deleteBtn.mas_left).with.offset(-10);
    }];
    [_goodInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(4));
        make.right.equalTo(_deleteBtn.mas_left).with.offset(-4);
        make.height.equalTo(@(goodInfo_H));
        make.bottom.equalTo(_deleteView.mas_bottom).with.offset(-18);
    }];
    
    [_numLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_goodChgV);
        make.centerY.equalTo(_goodChgV);
    }];
    
    [_subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_numLb.mas_left).with.offset(-16);
        make.width.equalTo(@(12));
        make.height.equalTo(@(12));
        make.centerY.equalTo(_numLb);
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numLb.mas_right).with.offset(16);
        make.width.equalTo(@(12));
        make.height.equalTo(@(12));
        make.centerY.equalTo(_numLb);
    }];
    
    /*****/
//    _normalView.hidden = YES;
    _deleteView.hidden = YES;
}

#pragma mark - action
- (void)chooseGoodsAction:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(chooseGoodsWithGoodCartsCell:)]) {
        [_delegate chooseGoodsWithGoodCartsCell:self];
    }
}

- (void)changeGoodsNumAction:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(changeGoodsNumActionWithGoodCartsCell:forTag:)]) {
        [_delegate changeGoodsNumActionWithGoodCartsCell:self forTag:button.tag];
    }
}

- (void)setIsChooseGoods:(BOOL)isChoose
{
//    _isChooseGoods = isChooseGoods;
    
    [_selectedBtn setImage:(isChoose ? [GoodCartsCell goodsSelectedImage] : [GoodCartsCell unGoodsSelectedImage]) forState:UIControlStateNormal];
}

- (void)setChangeEditingStyle:(BOOL)ischange
{
    if (ischange) {
        _normalView.hidden = YES;
        _deleteView.hidden = NO;
    } else {

        _normalView.hidden = NO;
        _deleteView.hidden = YES;
    }
}

- (void)setGoods:(DDXShopCartGoods *)goods
{
    _goods = goods;
    
    [_imageIMG loadPicture:[NSURL URLWithString:goods.imageUrl]];
    _goodNameLb.text = goods.itemName;
    _goodInfoLb.text = [NSString stringWithFormat:@"颜色：%@；尺码：%@", goods.itemColor.length ? goods.itemColor : @"随机", goods.itemSize.length ? goods.itemSize : @"均码"];
    _goodPriceLb.text = [NSString stringWithFormat:@"¥%ld", (long)goods.itemPriceNow];
    _goodOldPriceLb.text = [NSString stringWithFormat:@"¥%ld", (long)goods.itemPrice];
    _goodNumLb.text = [NSString stringWithFormat:@"x%ld", (long)goods.itemNum];
    
    _goodInfoLabel.text = [NSString stringWithFormat:@"颜色：%@；尺码：%@", goods.itemColor.length ? goods.itemColor : @"随机", goods.itemSize.length ? goods.itemSize : @"均码"];
    _numLb.text = [NSString stringWithFormat:@"%ld", (long)goods.itemNum];
    
    [self setIsChooseGoods:goods.isChooseGoods];
    [self setChangeEditingStyle:goods.changeEditingStyle];
}

//
static UIImage *_unGoodsSelectedImage;
+ (UIImage *)unGoodsSelectedImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unGoodsSelectedImage = [UIImage imageNamed:@"goods_unChoose"];
    });
    return _unGoodsSelectedImage;
}
static UIImage *_goodsSelectedImage;
+ (UIImage *)goodsSelectedImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _goodsSelectedImage = [UIImage imageNamed:@"ico_address"];
    });
    return _goodsSelectedImage;
}

@end
