//
//  FWContentItem.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FWContentItem.h"
#import "OSCModelHandler.h"

@implementation FWContentItem

//+ (NSDictionary *)modelCustomPropertyMapper {
//    
//    return @{@"userid":@"id"};
//}

- (void)calculateLayoutWithPortraitW:(CGFloat)portraitWidth withImage:(NSArray *)images isHaveMoreBtn:(BOOL)haveMoreBtn
{
    CGFloat rowHeight = 0;
    CGRect portraitFrame = (CGRect){{cell_padding_left, cell_padding_top}, {portraitWidth, portraitWidth}};
    _contentLayout.userPortraitIMGFrame = portraitFrame;
    
    CGRect usernameFrame = (CGRect){{CGRectGetMaxX(portraitFrame) + portrait_name_padding, cell_top_name}, {kScreenSizeW - (CGRectGetMaxX(portraitFrame) + portrait_name_padding) - cell_padding_right, nameLabel_Height}};
    _contentLayout.userNameLbFrame = usernameFrame;
    
    CGRect timeFrame = (CGRect){{CGRectGetMinX(usernameFrame), CGRectGetMaxY(usernameFrame)+name_time_padding}, {kScreenSizeW - (CGRectGetMaxX(portraitFrame) + portrait_name_padding) - cell_padding_right, time_height}};
    _contentLayout.timeLbFrame = timeFrame;
    
    CGRect contentFrame;
    if (self.content.length > 0) {
        CGSize contentSize = (CGSize)[self.content boundingRectWithSize:(CGSize){(kScreenSizeW - cell_padding_left - cell_padding_right), MAXFLOAT}
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_contentLB_fontsize]}
                                                                context:nil].size;
        contentFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(portraitFrame)+portrait_content_padding}, {kScreenSizeW - cell_padding_left - cell_padding_right, contentSize.height}};
        _contentLayout.contentLbFrame = contentFrame;//contentSize.width
    } else {
        contentFrame = CGRectMake(cell_padding_left, CGRectGetMaxY(portraitFrame)+content_image_padding, kScreenSizeW - cell_padding_left - cell_padding_right, 0);
    }
    
    
    CGRect imageFrame;
    CGFloat heightFloat = 0;//记录iconY坐标
    
    if (images.count == 1) {
        imageFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(contentFrame)+content_image_padding}, {image_Width, image_Height}};
        heightFloat = CGRectGetMaxY(imageFrame)+image_icon_padding;
    } else if (images.count > 1 && images.count < 4) {
        imageFrame  = (CGRect){{cell_padding_left, CGRectGetMaxY(contentFrame)+content_image_padding}, {kScreen_Width-cell_padding_left-cell_padding_right, more_bg_single_Image_Height}};
        heightFloat = CGRectGetMaxY(imageFrame)+image_icon_padding;
    } else if (images.count > 3 && images.count < 7) {
        imageFrame  = (CGRect){{cell_padding_left, CGRectGetMaxY(contentFrame)+content_image_padding}, {kScreen_Width-cell_padding_left-cell_padding_right, more_bg_double_Image_Height}};
        heightFloat = CGRectGetMaxY(imageFrame)+image_icon_padding;
    } else {
        imageFrame = CGRectZero;
        heightFloat = CGRectGetMaxY(contentFrame)+content_icon_padding;
    }

    _contentLayout.imageFrame = imageFrame;
    
    if (!haveMoreBtn) {
        //查看
        CGRect watchIconFrame = (CGRect){{cell_padding_left, heightFloat+2}, {icon_width, icon_height}};
        _contentLayout.watchIconFrame = watchIconFrame;
        
        CGSize watchCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_browseNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
        CGRect watchCountFrame = (CGRect){{CGRectGetMaxX(watchIconFrame)+icon_num_padding, heightFloat}, {watchCountSize.width, operationBtn_H}};
        _contentLayout.watchCountFrame = watchCountFrame;
        
//        //转发
//        CGSize transCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_forwardNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
//        CGRect transCountFrame = (CGRect){{kScreenSizeW - cell_padding_right - transCountSize.width, heightFloat}, {transCountSize.width, operationBtn_H}};
//        _contentLayout.transCountFrame = transCountFrame;
//        
//        CGRect transIconFrame = (CGRect){{kScreenSizeW - cell_padding_right - transCountSize.width - icon_num_padding- icon_width, heightFloat+2}, {icon_width, icon_height}};
//        _contentLayout.transIconFrame = transIconFrame;
        
        //评论
        CGSize commentCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_commentNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
        CGRect commentCountFrame = (CGRect){{kScreenSizeW - cell_padding_right - commentCountSize.width, heightFloat}, {commentCountSize.width, operationBtn_H}};//(CGRect){{CGRectGetMinX(transIconFrame) - num_icon_padding - commentCountSize.width, heightFloat}, {commentCountSize.width, operationBtn_H}};
        _contentLayout.commentCountFrame = commentCountFrame;
        
        CGRect commentIconFrame = (CGRect){{kScreenSizeW - cell_padding_right - commentCountSize.width - icon_num_padding- icon_width, heightFloat+2}, {icon_width, icon_height}};//(CGRect){{CGRectGetMinX(commentCountFrame) -icon_num_padding - icon_width, heightFloat+2}, {icon_width, icon_height}};
        _contentLayout.commentIconFrame = commentIconFrame;
        
        //点赞
//        CGSize likeCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_praiseNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
        CGRect likeCountFrame = (CGRect){{CGRectGetMinX(commentIconFrame) - 36*rating, heightFloat}, {36*rating, operationBtn_H}};//(CGRect){{CGRectGetMinX(commentIconFrame) - num_icon_padding - likeCountSize.width, heightFloat}, {likeCountSize.width, operationBtn_H}};
        _contentLayout.likeCountFrame = likeCountFrame;
        
        CGRect likeIconFrame = (CGRect){{CGRectGetMinX(likeCountFrame) -icon_num_padding - icon_width, heightFloat+2}, {icon_width, icon_height}};//(CGRect){{CGRectGetMinX(likeCountFrame) - icon_num_padding - icon_width, heightFloat+2}, {icon_width, icon_height}};
        _contentLayout.likeIconFrame = likeIconFrame;
        
        rowHeight = CGRectGetMaxY(watchCountFrame);
        
    } else {
        CGRect moreLbFrame = (CGRect){{kScreenSizeW - cell_padding_right - moreLb_W, heightFloat}, {moreLb_W, moreLb_H}};
        _contentLayout.moreLbFrame = moreLbFrame;
        
        rowHeight = CGRectGetMaxY(moreLbFrame);
        
    }
    
    rowHeight += cell_padding_bottom;
    
    _rowHeight = ceil(rowHeight);
    _portraitW = portraitWidth;
}

- (void)calculateVideoLayoutIsHaveMoreBtn:(BOOL)haveMoreBtn
{
    CGFloat rowHeight = 0;
    
    CGRect videoVFrame = (CGRect){{cell_padding_left, cell_padding_top}, {videoView_width, videoView_Height}};
    _contentVideoLayout.videoVFrame = videoVFrame;
    
    CGSize titleSize = (CGSize)[self.content boundingRectWithSize:(CGSize){(kScreenSizeW - cell_padding_left - cell_padding_right), MAXFLOAT}
                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_titleLB_fontsize]}
                                                            context:nil].size;
    CGRect titleFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(videoVFrame)+videoView_title_padding}, {kScreenSizeW - cell_padding_left - cell_padding_right, titleSize.height}};
    _contentVideoLayout.titleLbFrame = titleFrame;
    
    CGRect portraitFrame = (CGRect){{cell_padding_left, CGRectGetMaxY(titleFrame)+title_portrait_padding}, {portrait_W_H, portrait_W_H}};
    _contentVideoLayout.userPortraitIMGFrame = portraitFrame;
    
    CGSize usernameSize = (CGSize)[self.alias sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_videoUserNameLB_fontsize]}];
    CGRect usernameFrame = (CGRect){{CGRectGetMaxX(portraitFrame)+portrait_name_padding, CGRectGetMaxY(titleFrame)+title_username_padding}, {usernameSize.width, videoUsernameLB_height}};
    _contentVideoLayout.userNameLbFrame = usernameFrame;
    
    if (!haveMoreBtn) {
        //评论
        CGSize commentCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_commentNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
        CGRect commentCountFrame = (CGRect){{kScreenSizeW - cell_padding_right - commentCountSize.width, CGRectGetMaxY(titleFrame) +title_username_padding}, {commentCountSize.width, operationBtn_H}};
        _contentVideoLayout.commentCountFrame = commentCountFrame;
        
        CGRect commentIconFrame = (CGRect){{kScreenSizeW - cell_padding_right - commentCountSize.width - icon_num_padding- icon_width, CGRectGetMaxY(titleFrame) +title_username_padding+2}, {icon_width, icon_height}};
        _contentVideoLayout.commentIconFrame = commentIconFrame;
        
        //点赞
//        CGSize likeCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_praiseNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
        CGRect likeCountFrame = (CGRect){{CGRectGetMinX(commentIconFrame) - 36*rating, CGRectGetMaxY(titleFrame) +title_username_padding}, {36*rating, operationBtn_H}};
        _contentVideoLayout.likeCountFrame = likeCountFrame;
        
        CGRect likeIconFrame = (CGRect){{CGRectGetMinX(likeCountFrame) -icon_num_padding - icon_width, CGRectGetMaxY(titleFrame) +title_username_padding+2}, {icon_width, icon_height}};
        _contentVideoLayout.likeIconFrame = likeIconFrame;
        
        //查看
//        CGSize watchCountSize = (CGSize)[[NSString stringWithFormat:@"%ld", (long)_browseNum] sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cell_infoLB_fontsize]}];
        CGRect watchCountFrame = (CGRect){{CGRectGetMinX(likeIconFrame) - 36*rating, CGRectGetMaxY(titleFrame) +title_username_padding}, {36*rating, operationBtn_H}};
        _contentVideoLayout.watchCountFrame = watchCountFrame;
        
        CGRect watchIconFrame = (CGRect){{CGRectGetMinX(watchCountFrame) - icon_num_padding - icon_width, CGRectGetMaxY(titleFrame) +title_username_padding+2}, {icon_width, icon_height}};
        _contentVideoLayout.watchIconFrame = watchIconFrame;
        
        rowHeight = CGRectGetMaxY(portraitFrame);
    } else {
        CGRect moreLbFrame = (CGRect){{kScreenSizeW - cell_padding_right - moreLb_W, CGRectGetMaxY(titleFrame)+title_portrait_padding+3}, {moreLb_W, moreLb_H}};
        _contentVideoLayout.moreLbFrame = moreLbFrame;
        
        rowHeight = CGRectGetMaxY(portraitFrame);
    }
    
    rowHeight += cell_padding_bottom;
    
    _rowHeight = ceil(rowHeight);
}

@end
