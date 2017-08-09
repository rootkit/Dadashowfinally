//
//  GoodsCartsHeaderView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsCartsHeaderView.h"
#import "UIColorHF.h"

@interface GoodsCartsHeaderView ()
{
    BOOL _isChooseAllGoods;
    BOOL _isDrawGoodCards;
    BOOL _isEditing;
}

@property (strong, nonatomic) UIImageView *chooseBtn;
@property (strong, nonatomic) UILabel *shopNameLb;

@property (strong, nonatomic) UILabel *tagsBtn;
@property (strong, nonatomic) UILabel *editBtn;


@end

@implementation GoodsCartsHeaderView


- (instancetype)init
{
    if (self = [super init]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _chooseBtn = [UIImageView new];
        //    [_chooseBtn setImage:[GoodsCartsHeaderView unGoodsSelectedImage]];
        [_chooseBtn setImage:[UIImage imageNamed:@"店铺图标"]];
        [self addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(12));
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
            make.centerY.equalTo(self.contentView);
        }];
        
        _shopNameLb = [UILabel new];
        //    _shopNameLb.text = @"cherrykoko旗舰店";
        _shopNameLb.font = [UIFont systemFontOfSize:14];
        _shopNameLb.textColor = FirstTextColor;
        
        _shopNameLb.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_shopNameLb];
        [_shopNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_chooseBtn.mas_right).with.offset(12);
            make.centerY.equalTo(_chooseBtn);
        }];
        
        _tagsBtn = [UILabel new];
        _tagsBtn.text = @"领券";
        _tagsBtn.textAlignment = NSTextAlignmentCenter;
        _tagsBtn.font = [UIFont systemFontOfSize:12];
        _tagsBtn.textColor = [UIColor colorWithHex:0x585757];
        [self addSubview:_tagsBtn];
        [_tagsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_shopNameLb.mas_right).with.offset(4);
            make.centerY.equalTo(_shopNameLb);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = IconTextColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagsBtn.mas_right).with.offset(8);
            make.width.equalTo(@(1));
            make.height.equalTo(@(15));
            make.centerY.equalTo(_tagsBtn);
        }];
        
        _editBtn = [UILabel new];
        _editBtn.text = @"编辑";
        _editBtn.textAlignment = NSTextAlignmentCenter;
        _editBtn.font = [UIFont systemFontOfSize:12];
        _editBtn.textColor = [UIColor colorWithHex:0x585757];
        [self addSubview:_editBtn];
        
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line.mas_right).with.offset(8);
            make.right.equalTo(self.mas_right).with.offset(-12);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
            make.centerY.equalTo(_tagsBtn);
        }];
    }
    return self;
}

- (void)setIsChooseGoods:(BOOL)isChooseGoods
{
    _isChooseGoods = isChooseGoods;
    
    [_chooseBtn setImage:(isChooseGoods ? [GoodsCartsHeaderView goodsSelectedImage] : [GoodsCartsHeaderView unGoodsSelectedImage])];
}

- (void)setGoods:(DDXShopCartGoods *)goods
{
    _goods=goods;
    _shopNameLb.text =_goods.storeName.length ? _goods.storeName : @"无店名";
}

- (void)setIndexRow:(NSInteger)indexRow
{
    _indexRow = indexRow;
}

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

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _isChooseAllGoods = NO;
    _isDrawGoodCards = NO;
    _isEditing = NO;
    
    UITouch *touch = touches.anyObject;
    
    CGPoint point1 = [touch locationInView:_chooseBtn];
    CGPoint point2 = [touch locationInView:_tagsBtn];
    CGPoint point3 = [touch locationInView:_editBtn];
    
    if (CGRectContainsPoint(_chooseBtn.bounds, point1)) {
        _isChooseAllGoods = YES;
    } else if (CGRectContainsPoint(_chooseBtn.bounds, point2)) {
        _isDrawGoodCards = YES;
    }  else if (CGRectContainsPoint(_chooseBtn.bounds, point3)) {
        _isEditing = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isChooseAllGoods) {
//        if ([_delegate respondsToSelector:@selector(chooseAllGoodsAction:indexSection:)]) {
//            [_delegate chooseAllGoodsAction:self indexSection:self.indexRow];
//        }
    } else if (_isDrawGoodCards) {
        if ([_delegate respondsToSelector:@selector(drawGoodCardsAction:indexSection:)]) {
            [_delegate drawGoodCardsAction:self indexSection:self.indexRow];
        }
    }  else if (_isEditing) {
        if ([_delegate respondsToSelector:@selector(editingAction:indexSection:)]) {
            [_delegate editingAction:self indexSection:self.indexRow];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isChooseAllGoods || !_isDrawGoodCards || !_isEditing) {
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
