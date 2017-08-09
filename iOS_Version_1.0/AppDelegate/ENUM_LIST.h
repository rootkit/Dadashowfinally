//
//  ENUM_LIST.h
//  TestProject
//
//  Created by 李萍 on 2017/4/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#ifndef ENUM_LIST_h
#define ENUM_LIST_h

typedef NS_ENUM(NSInteger, CountButtonType)
{
    CountButtonTypeForSub = 1 ,//减
    CountButtonTypeForAdd,//加
};

typedef NS_ENUM(NSInteger, TabbarType)
{
    TabbarTypeForDadaxiu = 1 ,
    TabbarTypeForFashionWorld,
    TabbarTypeForShoppingCart,
    TabbarTypeForMine,
};

typedef NS_ENUM(NSInteger, ThirdLoginType)
{
    ThirdLoginTypeForQQ = 1,
    ThirdLoginTypeForWechat,
    ThirdLoginTypeForWeibo,
};

/**** 动态类型(纯文字，图片，视频) ****/
typedef NS_ENUM(NSInteger, CircleFriendsPublicType)
{
    CircleFriendsPublicTypeText = 1,
    CircleFriendsPublicTypeImage,
    CircleFriendsPublicTypeVedio,
};

/**** 商品类型(正常，试衣间，DIY) ****/
typedef NS_ENUM(NSInteger, GoodsThirdClassrifyType)
{
    GoodsThirdClassrifyTypeNormal = 1,
    GoodsThirdClassrifyTypeFittingroom,
    GoodsThirdClassrifyTypeDIY,
};

/**** 首页商品(品牌街，爆款女装， 私人订制，门店) ****/
typedef NS_ENUM(NSInteger, HomeBrandsType)
{
    HomeBrandsTypeBrand = 1,
    HomeBrandsTypeHot,
    HomeBrandsTypePrivate,
    HomeBrandsTypeShops,
};

typedef NS_ENUM(NSInteger, Hometype)
{
    HometypeForUpOneDownFour = 1,//上滚动图，下四张图
    HometypeForUpOneDownThree,//上一大图，下三张小图
    HometypeForLeftOneRightTwo,//左一大图，右两小图
    HometypeForDaDaVedio,//搭搭影视
    HometypeForDaDaFood,//搭搭吃货
    HometypeForDaDaMusic,//搭搭音乐
    HometypeForAdvertisement,//搭搭广告
    HometypeForNone,//猜你喜欢
    HometypeTAMMYANGX, // 模块YAMMY YANGS
    HometypeDPLAY,  // 模块Dplay
    HometypeBigBrands,  //模块甄大牌
}; //UI布局区别

typedef NS_ENUM(NSInteger, HomeModetype)//首页版块区分
{
    HomeModetypeForOfficial = 1,//官方系列
    HomeModetypeForDaDa,//搭搭系列
    HomeModetypeForShops,//店铺系列
    HomeModetypeForNone,//没有标题 ：如广告
    HomeModetypeBigBrands, //没有标题：甄大牌
}; //标题栏区别

typedef NS_ENUM(NSInteger, GoodsOrderTypes) {
    GoodsOrderTypesWithAll = 0, //全部订单
    GoodsOrderTypesWithObligation = 1, //待付款
    GoodsOrderTypesWithWaitForReceiv, //待收货
    GoodsOrderTypesWithRemainTobeEvaluated, //待评价
    GoodsOrderTypesWithAfterSale, //售后
};

typedef NS_ENUM(NSInteger, PayTypes) {
    GoodsPayTypesWithAll = 0,    //无
    GoodsPayTypesWithWeChat = 1, //微信支付
    GoodsPayTypesWithAlipay,     //支付宝支付
};

typedef NS_ENUM(NSInteger, UserSexType)
{
    UserSexTypeForDefault = 0 ,//保密
    UserSexTypeForMale = 1,//男
    UserSexTypeForFemale,//女
};

typedef NS_ENUM(NSInteger, ActivityTypes)//活动类型
{
    ActivityTypesForBrands = 0,//品牌街
    ActivityTypesForHots = 1,//爆款女装
    ActivityTypesForBrandsRecom = 3,//品牌街推荐
    ActivityTypesForBigBrands = 4,//甄大牌
    ActivityTypesForFavoBrands = 5,//惠来购
    ActivityTypesForChooseBrands = 6,//品牌优选
    ActivityTypesForActFirst = 7,//活动一
    ActivityTypesForActSecond = 8,//活动二
    ActivityTypesForActThird = 9,//活动三
    ActivityTypesForActFour = 7,//活动四
};

typedef NS_ENUM(NSInteger, ConsigneeAddressType)
{
    ConsigneeAddressTypeForUnDefault = 0 ,//不是默认地址
    ConsigneeAddressTypeForDefault = 1,//默认地址
};

typedef NS_ENUM(NSInteger, HometypeForAdvertisementSort) //广告顺序
{
    HometypeForAdvertisementSortOne = 0 ,//广告一
    HometypeForAdvertisementSortTwo = 1,//广告二
    HometypeForAdvertisementSortThree = 2,//广告三
    HometypeForAdvertisementSortFour = 3,//广告四
};

typedef NS_ENUM(NSInteger, HometypeForUpOneDownThreeSort) //上一下三顺序
{
    HometypeForUpOneDownThreeSortOne = 0 ,//一
    HometypeForUpOneDownThreeSortTwo = 1,//二
    HometypeForUpOneDownThreeSortThree = 2,//三
    HometypeForUpOneDownThreeSortFour = 3,//四
    HometypeForUpOneDownThreeSortFive = 4,//五
};

typedef NS_ENUM(NSInteger, HometypeForLeftOneRightTwoSort) //左一右两顺序
{
    HometypeForLeftOneRightTwoSortOne = 0 ,//一
    HometypeForLeftOneRightTwoSortTwo = 1,//二
    HometypeForLeftOneRightTwoSortThree = 2,//三
    HometypeForLeftOneRightTwoSortFour = 3,//四
};

#endif /* ENUM_LIST_h */
