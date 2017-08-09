//
//  GoodsCommentItem.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsCommentItem.h"

@implementation GoodsCommentItem

- (void)calculateLayoutWithImages:(BOOL)isHaveImage
{
    CGFloat rowHeight = 0;
    
    CGRect portraitFrame = (CGRect){{cell_padding_left, cell_top_portrait}, {portrait_W_H, portrait_W_H}};
    _goodsCommentLayoutInfo.userPortraitIMGFrame = portraitFrame;
    
    CGSize nameSize = (CGSize)[self.username sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:username_Font]}];
    CGRect nameFrame = (CGRect){{CGRectGetMaxX(portraitFrame)+portrait_name_padding, cell_top_name},
        {nameSize.width, nameSize.height}};
    _goodsCommentLayoutInfo.userNameLbFrame = nameFrame;
    
    CGRect levelFrame = (CGRect){{CGRectGetMaxX(nameFrame)+name_level_padding, cell_top_name}, {kScreenSizeW - (CGRectGetMaxX(nameFrame)+name_level_padding+cell_padding_right), nameSize.height}};
    _goodsCommentLayoutInfo.levelLbFrame = levelFrame;
    
    CGRect timeFrame = (CGRect){{CGRectGetMaxX(portraitFrame)+portrait_name_padding, CGRectGetMaxY(nameFrame)+name_time_padding}, {kScreenSizeW - (CGRectGetMaxX(portraitFrame)+portrait_name_padding+cell_padding_right), time_H}};
    _goodsCommentLayoutInfo.timeLbFrame = timeFrame;
    
    CGSize contentSize = (CGSize)[self.content boundingRectWithSize:(CGSize){(kScreenSizeW - cell_padding_left - cell_padding_right), MAXFLOAT}
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:content_Font]}
                                                            context:nil].size;
    CGRect contentFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(portraitFrame)+portrait_content_padding}, {kScreenSizeW-cell_padding_left - cell_padding_right, contentSize.height}};
    _goodsCommentLayoutInfo.contentLbFrame = contentFrame;
    
    CGFloat info_MixY = 0;
    if (isHaveImage) {
        CGRect imageFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(contentFrame)+content_image_padding}, {kScreenSizeW-cell_padding_left-cell_padding_right, image_H}};
        _goodsCommentLayoutInfo.imageVFrame = imageFrame;
        
        CGSize watchCountSize = (CGSize)[[NSString stringWithFormat:@"浏览%ld次", (long)self.watchCount] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:info_Font]}];
        CGRect watchCountFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(imageFrame)+image_watch_padding}, {watchCountSize.width, info_H}};
        _goodsCommentLayoutInfo.watchCountLbFrame = watchCountFrame;
        
        info_MixY = CGRectGetMinY(watchCountFrame);
    } else {
        info_MixY = CGRectGetMaxY(contentFrame)+content_likeCount_padding;
    }
    
    CGSize likeCountSize = (CGSize)[[NSString stringWithFormat:@"点赞"] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:info_Font]}];
    CGRect likeCountFrame = (CGRect){{kScreenSizeW-cell_padding_right-likeCountSize.width, info_MixY}, {likeCountSize.width, info_H}};
    _goodsCommentLayoutInfo.likeLbFrame = likeCountFrame;
    
    CGRect likeIconFrame = (CGRect){{CGRectGetMinX(likeCountFrame) -icon_num_padding - icon_width, info_MixY}, {icon_width, icon_height}};
    _goodsCommentLayoutInfo.likeIMGFrame = likeIconFrame;
    
    rowHeight = CGRectGetMaxY(likeIconFrame);
    rowHeight +=cell_padding_bottom;
    _rowHeight = ceil(rowHeight);
}

@end
