//
//  DDXAPI.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/25.
//  Copyright © 2017年 李萍. All rights reserved.
//

#ifndef DDXAPI_h
#define DDXAPI_h

#define DDXAPI_HTTP_PREFIX_Friend      @"http://119.23.15.157:8080" //时尚圈
//#define DDXAPI_HTTP_PREFIX_Friend      @"http://192.168.1.52:8080"  //谢

#define DDXAPI_HTTP_PREFIX_Loign      @"http://119.23.75.159:8080" //登录注册
//#define DDXAPI_HTTP_PREFIX_Loign      @"http://192.168.1.107:8082" //王   //@"http://192.168.1.55:8080" //蔡

#define DDXAPI_HTTP_PREFIX_Goods      @"http://119.23.73.250:8080" //商品接口
#define DDXAPI_HTTP_PREFIX_Order      @"http://119.23.222.219:8080" //订单接口


#define DDXAPI_HTTP_PREIX_Search     @"http://39.108.131.116:8080" //搜索接口、

#define DDXAPI_HTTP_PREFIX_Activity   @"http://119.23.27.172:8080" //活动商品
//#define DDXAPI_HTTP_PREFIX_Activity   @"http://192.168.1.107:8083" //王

#pragma mark - 首页

#define DDXAPI_SHOPMMS_MMS              @"/shop-mms/mms/index/plate"  //首页
#define DDXAPI_SHOPMMS_MMS_PLATEDETAIL  @"/detail" //首页板块
#define DDXAPI_SHOPMMS_Sort             @"/shop-mms/mms/index/plate/category"//首页上装裙装等分类

#define DDXAPI_SHOPMMS_Keywords         @"/shop-solr/sr/account/searchPage" //  搜索关键字
#define DDXAPI_SHOPMMS_History          @"/shop-solr/sr/account/history"// 历史记录
#define DDXAPI_SHOPMMS_DeleteHistory    @"/shop-solr/sr/account/historyDelete"//删除历史记录
#pragma mark - 微圈

#define DDXAPI_SHOPFRIEND_SR                     @"/shop-friend/sr"

#define DDXAPI_SHOPFRIEND_SR_CF_LIST             @"/circleFriends/list"        //动态列表
#define DDXAPI_SHOPFRIEND_SR_CF_DETAILINFO       @"/circleFriends/detailInfo"  //动态详情
#define DDXAPI_SHOPFRIEND_SR_CF_PUBLISHLIST      @"/circleFriends/publishList" //具体某一用户或商家动态列表
#define DDXAPI_SHOPFRIEND_SR_CF_ADD              @"/circleFriends/add"         //发布 文字
#define DDXAPI_SHOPFRIEND_SR_CF_UPLOADINFO       @"/circleFriends/uploadInfo"  //发布 图片/视频
#define DDXAPI_SHOPFRIEND_SR_CF_DELETE           @"/circleFriends/delete"      //删除
#define DDXAPI_SHOPFRIEND_SR_CF_PRAISE           @"/circleFriends/praise"      //点赞/取消点赞

#pragma mark -  微圈评论

#define DDXAPI_SHOPFRIEND_SR_FC_LIST     @"/friendsComment/list" //评论列表
#define DDXAPI_SHOPFRIEND_SR_FC_ADD      @"/friendsComment/add" //发表评论
#define DDXAPI_SHOPFRIEND_SR_FC_DELETE   @"/friendsComment/delete" //删除评论

#define DDXAPI_SHOPFRIEND_SR_UF_ADD             @"/userFollowFriend/add" //关注用户
#define DDXAPI_SHOPFRIEND_SR_USERINFO_LIST      @"/userInfo/list" //关注用户

#pragma mark - 登录

#define DDXAPI_SHOPPASSWORD_SR                  @"/shop-password/sr"//
#define DDXAPI_SHOPPASSWORD_SR_LOGIN            @"/userInfo/login"    //登录
#define DDXAPI_SHOPPASSWORD_SR_LOGIN_OUT        @"/userInfo/logout"  //退出登录
#define DDXAPI_SHOPPASSWORD_SR_USERINFO_EDIT    @"/userInfo/editUserInfo" //用户基本信息更改
#define DDXAPI_SHOPPASSWORD_SR_USERPHOTO        @"/userInfo/editUserPhoto" //更改用户头像
#define DDXAPI_SHOPPASSWORD_SR_SENDVERIFYCODE   @"/userInfo/sendVerifyCode" //获取验证码
#define DDXAPI_SHOPPASSWORD_SR_REGISTER         @"/userInfo/register"    //注册
#define DDXAPI_SHOPPASSWORD_SR_EDITPASSWARDFIRST         @"/userInfo/editPassWordFrist"    //忘记密码第一步
#define DDXAPI_SHOPPASSWORD_SR_EDITPASSWARDSECOND        @"/userInfo/editPassWordSecond"    //忘记密码第二步

#pragma mark - 购物车

#define DDXAPI_SHOPORDER_OMS                  @"/shop-order/oms/api" //订单
#define DDXAPI_SHOPORDER_OMS_GETSHOPPINGCART  @"/getShoppingCart"    //购物车查询
#define DDXAPI_SHOPORDER_OMS_DELSHOPPINGCART  @"/delShoppingCart"    //购物车清空
#define DDXAPI_SHOPORDER_OMS_GETORDER         @"/getOrder"           //订单列表
#define DDXAPI_SHOPORDER_OMS_PLACEORDER       @"/placeOrder"         //确认订单

#define DDXAPI_SHOPORDER_OMS_FINDCONSIGNEE    @"/findConsignee"      //收件人列表
#define DDXAPI_SHOPORDER_OMS_MODIFYCONSIGNEE  @"/modifyConsignee"     //新增、修改收件人
#define DDXAPI_SHOPORDER_OMS_DELCONSIGNEE  @"/delConsignee"     //删除收件人

#pragma mark - 活动

#define DDXAPI_ACTIVITY_SR          @"/shop-activity/sr/activitygoods"
#define DDXAPI_ACTIVITY_LIST        @"/list"                            //活动商品列表

#pragma mark - DIY 衣柜

#define DDXAPI_DIY              @"http://119.23.46.204/app/fittingRoom/DIYwardrobe.html" //DIY
#define DDXAPI_FITTINGROOM      @"http://119.23.46.204/app/fittingRoom/mywardrobe.html" //试衣间
#define DDXAPI_PET              @"http://119.23.46.204/app/fittingRoom/pet.html"    //宠物

#pragma mark -  我的

#define DDXAPI_Minecollect          @"/shop-mms/mms/goods/getfollowlist" //我的商品收藏
#define DDXAPI_Minetravel           @"/shop-mms/mms/goods/getShopFootprint"//我的足迹
#define DDXAPI_likeList             @"/shop-mms/mms/typege/sales" //猜你喜欢

#define DDXAPI_GOODS_Detail         @"/shop-mms/mms/goods" //商品详情


#endif /* DDXAPI_h */
