//
//  CommentItem.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem

- (void)calculateLayout
{
    CGFloat rowHeight = 0;
    
    CGRect portraitFrame = (CGRect){{cell_padding_left, cell_top_portrait},
                                    {portrait_width, portrait_height}};
    _commentLayoutInfo.userPortraitIMGFrame = portraitFrame;
    
    CGSize nameSize = (CGSize)[self.alias.length ? self.alias : @"火星人" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_nameLB_fontsize]}];
    CGRect nameFrame = (CGRect){{CGRectGetMaxX(portraitFrame)+portrait_name_padding, cell_top_name},
                                {kScreenSizeW - (CGRectGetMaxX(portraitFrame)+portrait_name_padding+cell_padding_right), nameSize.height}};
    _commentLayoutInfo.userNameLbFrame = nameFrame;
    
    CGRect timeFrame = (CGRect){{CGRectGetMaxX(portraitFrame)+portrait_name_padding, CGRectGetMaxY(nameFrame)+name_time_padding},
                                {kScreenSizeW - (CGRectGetMaxX(portraitFrame)+portrait_name_padding+cell_padding_right) ,time_height}};
    _commentLayoutInfo.timeLbFrame = timeFrame;
    
    CGSize contentSize = (CGSize)[self.content boundingRectWithSize:(CGSize){(kScreenSizeW - cell_left_content - cell_padding_right), MAXFLOAT}
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_contentLB_fontsize]}
                                                            context:nil].size;//= (CGSize)[self.content sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_contentLB_fontsize]}];
    CGRect contentFrame = (CGRect){{cell_left_content, CGRectGetMaxY(timeFrame)+time_content_padding}, {kScreenSizeW-cell_left_content-cell_padding_right, contentSize.height}};
    _commentLayoutInfo.contentLbFrame = contentFrame;
    
    rowHeight += cell_top_name;
    rowHeight += nameFrame.size.height;
    rowHeight += name_time_padding;
    rowHeight += time_height;
    rowHeight += time_content_padding;
    rowHeight += contentFrame.size.height;
    rowHeight += cell_padding_bottom;
    
    _rowHeight = ceil(rowHeight);
}

@end
