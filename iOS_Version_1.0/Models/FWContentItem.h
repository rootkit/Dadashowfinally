//
//  FWContentItem.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenSizeW [UIScreen mainScreen].bounds.size.width

#define rating kScreen_Width/375

#define cell_padding_left 12
#define cell_padding_right cell_padding_left
#define cell_padding_bottom 15
#define cell_padding_top 12

#define operationBtn_H 15
#define icon_width 16
#define icon_height 12
#define icon_num_padding 4
#define num_icon_padding 25

// 动态 图文类
#define cell_top_name cell_padding_top+4
#define nameLabel_Height 16

#define portrait_name_padding 10
#define name_time_padding 5
#define time_height 12

#define portrait_content_padding 17
#define content_image_padding 10
#define content_icon_padding 15
#define image_icon_padding 18

#define image_Width (kScreenSizeW - cell_padding_left - cell_padding_right)// * (kScreenSizeW/375)
#define image_Height (image_Width * 336)/700

#define more_Image_Width 110*kScreenSizeW/375
#define more_Image_Height more_Image_Width
#define more_Image_padding (kScreenSizeW - cell_padding_left - cell_padding_right - 3*more_Image_Width)/2

#define more_bg_Image_Width kScreenSizeW - cell_padding_left - cell_padding_right
#define more_bg_single_Image_Height more_Image_Width
#define more_bg_double_Image_Height more_Image_Width*2+more_Image_padding

#define moreLb_H 15
#define moreLb_W 90
#define cell_nameLB_fontsize 14
#define cell_contentLB_fontsize 14
#define cell_infoLB_fontsize 12

//动态 视频类

#define videoView_width (kScreenSizeW-cell_padding_left-cell_padding_right)// * (kScreenSizeW/375)
#define videoView_Height (videoView_width * 400)/700

#define videoView_title_padding 14
#define title_portrait_padding 14
#define title_username_padding 26

#define portrait_W_H 32
#define videoUsernameLB_height 14
#define portrait_name_padding 10

#define cell_titleLB_fontsize 13
#define cell_videoUserNameLB_fontsize 11

//

typedef struct {
    CGRect userPortraitIMGFrame;
    CGRect userNameLbFrame;
    CGRect timeLbFrame;
    CGRect contentLbFrame;
    
    CGRect watchIconFrame;
    CGRect watchCountFrame;
    
    CGRect likeIconFrame;
    CGRect likeCountFrame;
    
    CGRect commentIconFrame;
    CGRect commentCountFrame;
    
//    CGRect transIconFrame;
//    CGRect transCountFrame;
    
    CGRect imageFrame;//图片
    CGRect moreLbFrame;//更多按钮 （我的专用）
    
} FWContentLayoutInfo;

typedef struct {
    CGRect videoVFrame;
    CGRect titleLbFrame;
    CGRect userPortraitIMGFrame;
    CGRect userNameLbFrame;
    
    CGRect watchIconFrame;
    CGRect watchCountFrame;
    
    CGRect likeIconFrame;
    CGRect likeCountFrame;
    
    CGRect commentIconFrame;
    CGRect commentCountFrame;
    
    CGRect moreLbFrame;//更多按钮 （我的专用）
    
} FWContentVideoLayoutInfo; //视频

@interface FWContentItem : NSObject

@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, strong) NSString  *url;//图片或视频地址
@property (nonatomic, assign) int publishId;//用户、商家ID
@property (nonatomic, strong) NSString  *publishTitle;// 标题

@property (nonatomic, copy) NSString *publishDate;// 发布时间
@property (nonatomic, assign) CircleFriendsPublicType  publishType;//类型

@property (nonatomic, assign) int id;//发布的id
@property (nonatomic, copy) NSString *alias;//用户名
@property (nonatomic, copy) NSString *headerUrl;//用户头像

@property (nonatomic, assign) NSInteger browseNum;//浏览数
@property (nonatomic, assign) NSInteger commentNum;//评论数
@property (nonatomic, assign) NSInteger forwardNum;// 转发数
@property (nonatomic, assign) NSInteger praiseNum;//点赞数
@property (nonatomic, copy) NSString *isPraise;//是否点赞

@property (nonatomic, strong) NSArray *images; //处理后的视频
//@property (nonatomic, assign) NSInteger watchCount;
//@property (nonatomic, assign) int  praiseNum;
//@property (nonatomic, assign) NSInteger transCount;

////@property (nonatomic, strong) NSString  *content;// 正文
//@property (nonatomic, assign) int createUser;//创建者
//@property (nonatomic, assign) int  type;
//
//


/*
 browseNum = 0; 浏览数
 content = imy2; 发布内容
 createUser = 10; 创建人ID
 forwardNum = 0;转发数
 id = 45; 动态ID
 praiseNum = 0;点赞数
 publishDate = "2017-05-02 17:10:43";发布时间
 publishId = 32; 发布动态的用户ID
 publishTitle = "i\U6d4b\U8bd5"; 发布标题
 publishType = 1; 发布动态类型
 type = 1; 发布动态者类型
 */

//视频
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat portraitW;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) FWContentLayoutInfo contentLayout; //动态图文类
@property (nonatomic, assign) FWContentVideoLayoutInfo contentVideoLayout; //动态视频类

- (void)calculateLayoutWithPortraitW:(CGFloat)portraitWidth withImage:(NSArray *)images isHaveMoreBtn:(BOOL)haveMoreBtn;
- (void)calculateVideoLayoutIsHaveMoreBtn:(BOOL)haveMoreBtn;

@end
