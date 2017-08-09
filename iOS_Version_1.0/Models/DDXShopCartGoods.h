//
//  DDXShopCartGoods.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 购物车商品列表model ****/
#import <Foundation/Foundation.h>

@interface DDXShopCartGoods : NSObject

@property (nonatomic, assign) NSInteger storeId; //门店 ID
@property (nonatomic, copy) NSString *sku; //平台 SKU
@property (nonatomic, copy) NSString *storeSku; //门店 SKU
@property (nonatomic, copy) NSString *storeName; //门店 名称
@property (nonatomic, copy) NSString *storeAddress; //门店 地址
@property (nonatomic, copy) NSString *storePhoneNum; //门店 电话
@property (nonatomic, copy) NSString *itemName; //商品的名称
@property (nonatomic, assign) int itemNum; //商品数量

@property (nonatomic, assign) double itemPrice; //商品原单价
@property (nonatomic, assign) double itemPriceNow; //商品现单价
@property (nonatomic, copy) NSString *itemModel; //商品型号
@property (nonatomic, assign) NSInteger itemDiscount; //商品优惠金额，无优惠值为 0
@property (nonatomic, assign) NSInteger orderDiscountTypeId; //优惠方式 id，活动 id


@property (nonatomic, copy) NSString *orderDiscountType; //优惠方式，活动名称
@property (nonatomic, assign) NSInteger itemDiscountRate; //折扣率
@property (nonatomic, assign) NSInteger couponId; //优惠券 id
@property (nonatomic, assign) NSInteger itemColorId; //颜色 id
@property (nonatomic, copy) NSString *itemColor; //颜色

@property (nonatomic, copy) NSString *imageUrl; //图片
@property (nonatomic, assign) NSInteger itemSizeId; //尺寸 id
@property (nonatomic, copy) NSString *itemSize; //尺寸

//购物车
@property (nonatomic, assign) BOOL isChooseGoods; //选中状态
@property (nonatomic, assign) BOOL changeEditingStyle;//编辑状态





@end


@interface DDXLikeGoodsModel : NSObject

//猜你喜欢
@property (nonatomic, assign) NSInteger id; //id
@property (nonatomic, copy) NSString *sku; //平台 SKU
@property (nonatomic, copy) NSString *storeSku; //门店 SKU
@property (nonatomic, assign) NSInteger categoryId; //品类 id
@property (nonatomic, assign) NSInteger goodId; //分类 id

@property (nonatomic, copy) NSString *goodsName; //商品名称
@property (nonatomic, copy) NSString *goodsShortName; //商品短名称
@property (nonatomic, assign) NSInteger clickCount; //点击数
@property (nonatomic, assign) NSInteger brandId; //品牌ID
@property (nonatomic, assign) NSInteger storeId; //门店id

@property (nonatomic, assign) double marketPrice; //市场售价
@property (nonatomic, assign) double shopPrice; //本店售价
@property (nonatomic, assign) NSInteger itemColorId; //颜色 id
@property (nonatomic, copy) NSString *itemColor; //颜色
@property (nonatomic, assign) NSInteger itemSizeId; //尺寸 id
@property (nonatomic, copy) NSString *itemSize; //尺寸

@property (nonatomic, assign) NSInteger isGroup; //是否是组合商品
@property (nonatomic, assign) NSInteger groupId; //组合商品 id
@property (nonatomic, assign) NSInteger sort; //尺寸 id

@property (nonatomic, copy) NSString *longDescription; //商品长描述
@property (nonatomic, copy) NSString *imageUrl; //图片
@property (nonatomic, copy) NSString *imageAlt; //图片alt值


@end

@interface DDXDetailGoodsModel : NSObject

//商品详情
@property (nonatomic, assign) NSInteger id; //id
@property (nonatomic, copy) NSString *sku; //平台 SKU
@property (nonatomic, copy) NSString *storeSku; //门店 SKU
@property (nonatomic, assign) NSInteger categoryId; //品类 id
@property (nonatomic, assign) NSInteger goodsTypeId; //分类 id
@property (nonatomic, copy) NSString *goodsName; //商品名称

@property (nonatomic, copy) NSString *goodsShortName; //商品短名称
@property (nonatomic, assign) NSInteger clickCount; //点击数
@property (nonatomic, assign) NSInteger brandId; //品牌ID
@property (nonatomic, assign) NSInteger storeId; //门店id

@property (nonatomic, assign) double marketPrice; //市场售价
@property (nonatomic, assign) double shopPrice; //本店售价
@property (nonatomic, copy) NSString *shortDescription; //

@property (nonatomic, copy) NSString *storeName; //门店 名称
@property (nonatomic, copy) NSString *storeAddress; //门店 地址
@property (nonatomic, copy) NSString *storePhoneNum; //门店 电话

@property (nonatomic, assign) NSInteger itemColorId; //颜色 id
@property (nonatomic, copy) NSString *itemColor; //颜色
@property (nonatomic, assign) NSInteger itemSizeId; //尺寸 id
@property (nonatomic, copy) NSString *itemSize; //尺寸

@property (nonatomic, assign) NSInteger isGroup; //是否是组合商品
@property (nonatomic, assign) NSInteger groupId; //组合商品 id
@property (nonatomic, assign) NSInteger sort; //尺寸 id

@property (nonatomic, copy) NSString *longDescription; //商品长描述
@property (nonatomic, copy) NSString *imageUrl; //图片
@property (nonatomic, copy) NSString *imageAlt; //图片alt值

@property (nonatomic, assign) NSInteger itemNum;//


@end








