//
//  DDXHomeModel.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

/*******  首页板块主信息  *******/
@interface DDXHomeModel : NSObject

@property (nonatomic, assign) int id; //模块id
@property (nonatomic, copy) NSString *plateCode; //板块编码
@property (nonatomic, assign) int isReplace; //是否轮播 1 Y, 0 N
@property (nonatomic, copy) NSString *imageSize; //次图大小
@property (nonatomic, copy) NSString *plateName; //板块名称
@property (nonatomic, strong) NSDate *replaceDate; //模块图片更换/轮播频次时间
@property (nonatomic, copy) NSString *imageMainSize; //主图大小
@property (nonatomic, assign) int imageNumber; //图片数量

@end

/*******  子板块信息  *******/
@interface DDXPlateModel : NSObject

@property (nonatomic, assign) int id; //模块详情序列 id
@property (nonatomic, assign) int plateId; //首页模块 id
@property (nonatomic, copy) NSString *imageUrl; //模块图片地址
@property (nonatomic, copy) NSString *imageAlt; //图片 alt 值
@property (nonatomic, copy) NSString *imageLink; //图片连接地址
@property (nonatomic, assign) int imageLinkType; //图片连接类型:0:品牌，1:门店，2:商品 类型，3:商品
@property (nonatomic, copy) NSString *imageLinkId; //图片连接类型，对应不同的连接 id
@property(nonatomic,assign)double shopPrice;//商品价格
@end

/*******上衣，裙装，裤子，包包模型 *******/
@interface DDXSortModel : NSObject
@property (nonatomic, assign) int id; //模块详情序列 id
@property (nonatomic, copy) NSString *categoryName; //品类名称
@property(nonatomic,copy)NSString* categoryKeywords;//品类关键字
@property (nonatomic, copy) NSString *categoryDesc; //分类描述
@property (nonatomic, assign) int sortOrder; //分类 id
@property (nonatomic, copy) NSString *categoryImage; // 分类图片
@end

/*******首页搜索列表模型 *******/
@interface DDXSearchModel : NSObject
@property (nonatomic, copy) NSString* goodsName; //商品品类名称
@property(nonatomic,copy)NSString* goodsKeywords;//商品关键字
@property(nonatomic,copy)NSString* imageUrl;// 商品图片
@property (nonatomic, copy) NSString* shopPrice; //商品价格
@property (nonatomic, copy) NSString* shortDescription; //商品描述
@property (nonatomic, copy) NSString* sku; //SKU
@property (nonatomic, copy) NSString* storeSku; //门店sku

@end



// 品牌优选
@interface Brandsselectarray : NSObject

@property (nonatomic, strong) NSMutableArray * brandselectarray;

+(Brandsselectarray *)sharedArray;

@end


//Carcenter数组个数
@interface Carcenter : NSObject

@property (nonatomic, assign) NSInteger  carcentercount;

+(Carcenter*)sharedCount;

@end

//TAMMY TANGs数组个数
@interface Tammytangs : NSObject

@property (nonatomic, assign) NSInteger  tammycount;

+(Tammytangs*)sharedTcount;

@end


/************ 商品列表数据 ***********/

@interface DDXGoodsModel : NSObject

@property (nonatomic, assign) long id;//商品ID
@property (nonatomic, copy) NSString *goodsName;//商品名称
@property (nonatomic, copy) NSString *goodsShortName;//商品简称
@property (nonatomic, assign) NSInteger marketPrice;//市场售价
@property (nonatomic, assign) NSInteger shopPrice;//本店售价
@property (nonatomic, copy) NSString *imageUrl;//图片链接
@property (nonatomic, copy) NSString *sku;//商品SKU
@property (nonatomic, assign) NSInteger goodsInventory;//库存数量

@end










