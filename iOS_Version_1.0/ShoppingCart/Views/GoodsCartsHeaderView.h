//
//  GoodsCartsHeaderView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXShopCartGoods.h"

@class GoodsCartsHeaderView;
@protocol GoodsCartsHeaderViewDelegate <NSObject>

- (void)chooseAllGoodsAction:(GoodsCartsHeaderView *)headView indexSection:(NSInteger)section;
- (void)editingAction:(GoodsCartsHeaderView *)headView indexSection:(NSInteger)section;
- (void)drawGoodCardsAction:(GoodsCartsHeaderView *)headView indexSection:(NSInteger)section;

@end

@interface GoodsCartsHeaderView : UITableViewHeaderFooterView

+ (UIImage *)goodsSelectedImage;
+ (UIImage *)unGoodsSelectedImage;

@property (nonatomic, weak) id <GoodsCartsHeaderViewDelegate> delegate;
@property (nonatomic, assign) BOOL isChooseGoods;
@property (nonatomic, assign) NSInteger indexRow;

@property (nonatomic, strong) DDXShopCartGoods *goods;

@end
