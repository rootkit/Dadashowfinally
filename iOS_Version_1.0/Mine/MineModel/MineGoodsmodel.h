//
//  MineGoodsmodel.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineGoodsmodel : NSObject

@property (nonatomic, copy) NSString *goodsName;//商品名称
@property (nonatomic, assign) double shopPrice;//本店售价
@property (nonatomic, assign) double marketPrice;//商品原价
@property (nonatomic, copy) NSString *sku;//商品SKU
@property (nonatomic, copy) NSString *imageUrl;//商品图片

@end


@interface Travelmodel : NSObject

@property (nonatomic, copy) NSString *goodsName;//商品名称
@property (nonatomic, assign) double shopPrice;//本店售价
@property (nonatomic, assign) double marketPrice;//商品原价
@property (nonatomic, copy) NSString *sku;//商品SKU
@property (nonatomic, copy) NSString *imageUrl;//商品图片

@end


