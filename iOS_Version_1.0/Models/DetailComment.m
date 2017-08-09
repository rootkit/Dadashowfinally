//
//  DetailComment.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DetailComment.h"

@implementation DetailComment
- (void)calculateLayout
{
    CGFloat rowHeight = 0;
    
    CGRect portraitFrame = (CGRect){{cell_padding_left, cell_top_portrait},
        {portrait_width, portrait_height}};
    _commentLayoutInfo.userPortraitIMGFrame = portraitFrame;
    
    CGSize nameSize = (CGSize)[self.username sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_nameLB_fontsize]}];
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
    NSString*  subcommentstring=nil;
    
    
   if (self.friendnamearray.count==0||self.stringarray==0) {
       subcommentstring=@"";
        rowHeight += cell_top_name;
        rowHeight += nameFrame.size.height;
        rowHeight += name_time_padding;
        rowHeight += time_height;
        rowHeight += time_content_padding;
        rowHeight += contentFrame.size.height;
        rowHeight += cell_padding_bottom;
        _rowHeight = ceil(rowHeight);
    }else{
    subcommentstring=[NSString stringWithFormat:@"%@%@",self.friendnamearray[0],self.stringarray[0]];
    for (int i=0; i<self.stringarray.count-1; i++) {
            subcommentstring=[NSString stringWithFormat:@"%@\n%@%@",subcommentstring,self.friendnamearray[i+1],self.stringarray[i+1]];
    }
        CGSize subcontentSize = (CGSize)[subcommentstring boundingRectWithSize:(CGSize){(kScreenSizeW - cell_left_content - cell_padding_right), MAXFLOAT}
                                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_contentLB_fontsize]}
                                                                       context:nil].size;
        
        CGRect subcontentFrame=(CGRect){{cell_left_content, CGRectGetMaxY(contentFrame)+name_time_padding}, {kScreenSizeW-cell_left_content-cell_padding_right,  subcontentSize.height}};
        _commentLayoutInfo.subcontentLbFrame=subcontentFrame;
        rowHeight += cell_top_name;
        rowHeight += nameFrame.size.height;
        rowHeight += name_time_padding;
        rowHeight += time_height;
        rowHeight += time_content_padding;
        rowHeight += contentFrame.size.height;
        rowHeight += cell_padding_bottom;
        rowHeight +=subcontentFrame.size.height;
        rowHeight += cell_padding_bottom;
        _rowHeight = ceil(rowHeight);
    }
}

@end
