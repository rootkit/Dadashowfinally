//
//  GoodsCommentItem.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenSizeW [UIScreen mainScreen].bounds.size.width

#define cell_padding_left 12
#define cell_padding_right cell_padding_left
#define cell_padding_bottom 15

#define portrait_W_H 42
#define cell_top_portrait 15

#define portrait_name_padding 10
#define cell_top_name 21
#define name_level_padding 12

#define name_time_padding 5
#define time_H 12

#define portrait_content_padding 17

#define content_image_padding 15 //有图片
#define image_H 115
#define image_W 97

#define content_likeCount_padding 15

#define image_watch_padding 36
#define info_H 15
#define icon_num_padding 5
#define icon_width 16
#define icon_height 15

#define username_Font 13
#define time_Font 10
#define content_Font 13
#define info_Font 12

typedef struct {
    CGRect userPortraitIMGFrame;
    CGRect userNameLbFrame;
    CGRect levelLbFrame;
    CGRect timeLbFrame;
    
    CGRect contentLbFrame;
    CGRect imageVFrame;
    CGRect watchCountLbFrame;
    CGRect likeIMGFrame;
    CGRect likeLbFrame;
    
} GoodsCommentLayoutInfo;

@interface GoodsCommentItem : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *portraitUrl;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger watchCount;
@property (nonatomic, assign) BOOL isLike;

@property (nonatomic, assign) GoodsCommentLayoutInfo goodsCommentLayoutInfo;
@property (nonatomic, assign) CGFloat rowHeight;

- (void)calculateLayoutWithImages:(BOOL)isHaveImage;

@end
