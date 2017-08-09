//
//  DetailComment.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <Foundation/Foundation.h>
#define cell_padding_left 38
#define cell_padding_right cell_padding_left
#define cell_padding_bottom 15

#define cell_top_portrait 15
#define cell_top_name 20

#define portrait_width 42
#define portrait_height portrait_width

#define portrait_name_padding 10
#define name_time_padding 5
#define time_content_padding 17
#define cell_left_content 38


#define cell_nameLB_fontsize 13
#define cell_timeLB_fontsize 10
#define cell_contentLB_fontsize 13

#define time_height 10

#define kScreenSizeW [UIScreen mainScreen].bounds.size.width

typedef struct {
    CGRect userPortraitIMGFrame;
    CGRect userNameLbFrame;
    CGRect timeLbFrame;
    CGRect contentLbFrame;
    CGRect subcontentLbFrame;
}
CommentLayoutInfo;

@interface DetailComment : NSObject


@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *portraitUrl;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *content;
@property(nonatomic,strong)NSMutableArray* stringarray;
@property(nonatomic,strong)NSMutableArray* friendnamearray;

@property (nonatomic, assign) CommentLayoutInfo commentLayoutInfo;
@property (nonatomic, assign) CGFloat rowHeight;

- (void)calculateLayout;

@end
