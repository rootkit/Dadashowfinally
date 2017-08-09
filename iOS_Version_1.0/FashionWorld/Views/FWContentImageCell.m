//
//  FWContentImageCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FWContentImageCell.h"
#import "UIColorHF.h"
#import "UIImageView+Comment.h"
#import "Util.h"
#import "UIView+XLExtension.h"
#import "XLPhotoBrowser.h"
#import <YYKit/YYKit.h>
#import "UIImageView+WebCache.h"

#define Info_Font 12

@interface FWContentImageCell () <UIScrollViewDelegate,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>
{
    BOOL _TouchLikeImage;
    BOOL _TouchCommentImage;
    UIView *bottomView;
}

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *watchIMG;
@property (nonatomic, strong) UILabel *watchLabel;

@property (nonatomic, strong) UIImageView *likeIMG;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) UIImageView *commentIMG;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIImageView *transIMG;
@property (nonatomic, strong) UILabel *transLabel;

@property (nonatomic, strong) UIImageView *bottomImageView;
@property (nonatomic, strong) UIScrollView *scrollView; //旧版 滚动式呈现图片数组
@property (nonatomic, strong) UIView *imgsBgView; //新版 宫格形式
@property (nonatomic, strong) UILabel *moreLabel; //我的专用
@property(nonatomic,strong)NSMutableArray* imagearray;//图片数组
@property(nonatomic,assign)NSUInteger index;



@end

@implementation FWContentImageCell

- (NSMutableArray*)imagearray
{
    if (!_imagearray) {
        _imagearray= [NSMutableArray new];
    }
    return _imagearray;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _index=0;
        [self imagearray];
        [self initSubViews];
    }
    
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    FWContentImageCell * cell = [[FWContentImageCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.contentView.backgroundColor = BackCellColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)initSubViews
{
    bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    
    _portraitIMG = [UIImageView new];
    _portraitIMG.backgroundColor = DefaultImgBgColor;
    _portraitIMG.contentMode =  UIViewContentModeScaleAspectFill;
    _portraitIMG.clipsToBounds = YES;
    _portraitIMG.image = [UIImage imageNamed:@"userPortrait_default"];
    [_portraitIMG handleCornerRadiusWithRadius: _contentItem.portraitW/2];
    
    [bottomView addSubview:_portraitIMG];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = FirstTextColor;
    [bottomView addSubview:_nameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = IconTextColor;
    [bottomView addSubview:_timeLabel];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.textColor = FirstTextColor;
    [bottomView addSubview:_contentLabel];
    
    _bottomImageView = [UIImageView new];
    _bottomImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _bottomImageView.clipsToBounds = YES;
    [_bottomImageView handleCornerRadiusWithRadius:3];
    [bottomView addSubview:_bottomImageView];
    
    //
    _watchIMG = [UIImageView new];
    _watchIMG.image = [self watchImage];
    [bottomView addSubview:_watchIMG];
    
    _watchLabel = [UILabel new];
    _watchLabel.font = [UIFont systemFontOfSize:Info_Font];
    _watchLabel.textColor = IconTextColor;
    _watchLabel.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:_watchLabel];
    
    //
    _likeIMG = [UIImageView new];
    _likeIMG.image = [self unlikeImage];
    [bottomView addSubview:_likeIMG];
    
    YYLabel *likeCountLabel = [YYLabel new];
    _likeLabel = likeCountLabel;
    _likeLabel.font = [UIFont systemFontOfSize:Info_Font];
    _likeLabel.textColor = IconTextColor;
    _likeLabel.displaysAsynchronously = YES;
    _likeLabel.fadeOnAsynchronouslyDisplay = NO;
    _likeLabel.fadeOnHighlight = NO;
    [bottomView addSubview:_likeLabel];
    
    //
    _commentIMG = [UIImageView new];
    _commentIMG.image = [self commentImage];
    [bottomView addSubview:_commentIMG];
    
    _commentLabel = [UILabel new];
    _commentLabel.font = [UIFont systemFontOfSize:Info_Font];
    _commentLabel.textColor = IconTextColor;
    [bottomView addSubview:_commentLabel];
    
    //
    _transIMG = [UIImageView new];
    _transIMG.image = [self transImage];
    [bottomView addSubview:_transIMG];
    
    _transLabel = [UILabel new];
    _transLabel.font = [UIFont systemFontOfSize:Info_Font];
    _transLabel.textColor = IconTextColor;
    [bottomView addSubview:_transLabel];
    
    _imgsBgView = [UIView new];
    _imgsBgView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:_imgsBgView];
    
    _moreLabel = [UILabel new];
    _moreLabel.attributedText = [Util jointStringWithIcon:@"更多" iconName:@"ico_fh2"];
    _moreLabel.font = [UIFont systemFontOfSize:14];
    _moreLabel.textColor = ThemeColor;
    _moreLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:_moreLabel];
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    bottomView.frame = CGRectMake(0, 3, CGRectGetWidth(self.contentView.frame), _contentItem.rowHeight);
    
    _portraitIMG.frame = _contentItem.contentLayout.userPortraitIMGFrame;
    _nameLabel.frame = _contentItem.contentLayout.userNameLbFrame;
    _timeLabel.frame = _contentItem.contentLayout.timeLbFrame;
    _contentLabel.frame = _contentItem.contentLayout.contentLbFrame;
    
    
    _watchIMG.frame = _contentItem.contentLayout.watchIconFrame;
    _watchLabel.frame = _contentItem.contentLayout.watchCountFrame;
    
    _likeIMG.frame = _contentItem.contentLayout.likeIconFrame;
    _likeLabel.frame = _contentItem.contentLayout.likeCountFrame;
    
    _commentIMG.frame = _contentItem.contentLayout.commentIconFrame;
    _commentLabel.frame = _contentItem.contentLayout.commentCountFrame;
    
//    _transIMG.frame = _contentItem.contentLayout.transIconFrame;
//    _transLabel.frame = _contentItem.contentLayout.transCountFrame;
    
    if (_contentItem.images.count == 1) {
        _imgsBgView.frame = _contentItem.contentLayout.imageFrame;
        [self onlyOneImage];
        
    } else if (_contentItem.images.count > 1 && _contentItem.images.count < 4) {
        _imgsBgView.frame = _contentItem.contentLayout.imageFrame;
        [self singleImages];
        
    } else if (_contentItem.images.count > 3 && _contentItem.images.count < 7) {
        _imgsBgView.frame = _contentItem.contentLayout.imageFrame;
        [self doubleImages];
        
    } else {
        _bottomImageView.frame = _contentItem.contentLayout.imageFrame;
    }
    
    _moreLabel.frame = _contentItem.contentLayout.moreLbFrame;
//    [self.imagearray removeAllObjects];



}

/* 单图 */
- (void)onlyOneImage
{
    UIImageView *imageView = [UIImageView new];
    [imageView handleCornerRadiusWithRadius:3];
    imageView.contentMode =  UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView loadPicture:[NSURL URLWithString:_contentItem.images[0]]];
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(_imgsBgView.frame), CGRectGetHeight(_imgsBgView.frame));
    [_imgsBgView addSubview:imageView];
    imageView.tag=50;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagetap:)];
    imageView.userInteractionEnabled=YES;
    [imageView addGestureRecognizer:tap];
}

/* 2/3张图 */
- (void)singleImages
{
    CGFloat imagePadding = (CGRectGetWidth(_imgsBgView.frame) - 3*more_bg_single_Image_Height)/2;
    
    for (int i = 0; i < _contentItem.images.count; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView handleCornerRadiusWithRadius:3];
        [imageView loadPicture:[NSURL URLWithString:_contentItem.images[i]]];
        imageView.frame = CGRectMake((more_bg_single_Image_Height+imagePadding)*i, 0, more_bg_single_Image_Height, more_bg_single_Image_Height);
        [_imgsBgView addSubview:imageView];
        imageView.tag=i+50;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagetap:)];
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tap];
    }
    
}

/* 4/5/6张图 */
- (void)doubleImages
{
    CGFloat imagePadding = (CGRectGetWidth(_imgsBgView.frame) - 3*more_bg_single_Image_Height)/2;

    if (_contentItem.images.count == 4) {
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                UIImageView *imageView = [UIImageView new];
                imageView.contentMode =  UIViewContentModeScaleAspectFill;
                imageView.clipsToBounds = YES;
                [imageView handleCornerRadiusWithRadius:3];
                [imageView loadPicture:[NSURL URLWithString:_contentItem.images[2*i+j]]];
                imageView.frame = CGRectMake((more_bg_single_Image_Height+imagePadding)*i, (more_bg_single_Image_Height+imagePadding)*j, more_bg_single_Image_Height, more_bg_single_Image_Height);
                [_imgsBgView addSubview:imageView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagetap:)];
                imageView.userInteractionEnabled=YES;
                [imageView addGestureRecognizer:tap];
                imageView.tag=50+2*i+j;
            }
        }
    } else {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (3*i+j < _contentItem.images.count) {
                    UIImageView *imageView = [UIImageView new];
                    [imageView handleCornerRadiusWithRadius:3];
                    imageView.contentMode =  UIViewContentModeScaleAspectFill;
                    imageView.clipsToBounds = YES;
                     imageView.tag=50+3*i+j;
                    [imageView loadPicture:[NSURL URLWithString:_contentItem.images[3*i+j]]];
                    imageView.frame = CGRectMake((more_bg_single_Image_Height+imagePadding)*j, (more_bg_single_Image_Height+imagePadding)*i, more_bg_single_Image_Height, more_bg_single_Image_Height);
                    [_imgsBgView addSubview:imageView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagetap:)];
                    imageView.userInteractionEnabled=YES;
                    [imageView addGestureRecognizer:tap];
                }
                
            }
            
        }
    }
    
}

-(void)imagetap:(UITapGestureRecognizer*)tap{
    
    _index=self.tag;
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithCurrentImageIndex:tap.view.tag-50 imageCount:_contentItem.images.count datasource:self];
    
    // 设置长按手势弹出的地步ActionSheet数据,不实现此方法则没有长按手势
    [browser setActionSheetWithTitle:@"" delegate:self cancelButtonTitle:nil deleteButtonTitle:nil otherButtonTitles:@"发送给朋友",@"保存图片",nil];
    // 自定义pageControl的一些属性
    browser.pageDotColor = [UIColor whiteColor]; ///< 此属性针对动画样式的pagecontrol无效
    browser.currentPageDotColor = ThemeColor;
    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;///< 修改底部pagecontrol的样式为系统样式,默认是弹性动画的样式


}
#pragma mark    -   XLPhotoBrowserDatasource

- (UIImage *)photoBrowser:(XLPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_contentItem.images[index]];

}

- (UIView *)photoBrowser:(XLPhotoBrowser *)browser sourceImageViewForIndex:(NSInteger)index
{
//    FWContentImageCell *cell =[self viewWithTag:self.tag];
    return self.imgsBgView.subviews[index];
}



#pragma mark    -   XLPhotoBrowserDelegate

- (void)photoBrowser:(XLPhotoBrowser *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex
{
    // do something yourself
    switch (actionSheetindex) {
        case 1: // 保存
        {
            NSLog(@"点击了actionSheet索引是:%zd , 当前展示的图片索引是:%zd",actionSheetindex,currentImageIndex);
            [browser saveCurrentShowImage];
        }
        break;
        default:
        break;
    }
}



- (void)setContentItem:(FWContentItem *)contentItem
{
    _contentItem = contentItem;
    _nameLabel.text = contentItem.alias.length > 0 ? contentItem.alias : @"火星人";
    _contentLabel.text =  contentItem.content;
    _likeIMG.image = [contentItem.isPraise isEqualToString:@"1"] ? [self likeImage] : [self unlikeImage];
    _watchLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.browseNum];
    _likeLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.praiseNum];
    _transLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.forwardNum];
    [_portraitIMG handleCornerRadiusWithRadius:_contentItem.portraitW/2];
    [_portraitIMG loadPortrait:[NSURL URLWithString:_contentItem.headerUrl]];
    _timeLabel.text = [NSString stringWithFormat:@"%@", contentItem.publishDate];//[contentItem.publishDate timeAgoSince];//
//    if (_contentItem.images.count == 1) {
//        [_bottomImageView loadPortrait:[NSURL URLWithString:_contentItem.images[0]]];
//    }
//    
//    [_bottomImageView loadPortrait:[NSURL URLWithString:@"http://scimg.jb51.net/allimg/150713/14-150G315153Q16.jpg"]];
    if (contentItem.commentNum) {
        _commentLabel.text =[NSString stringWithFormat:@"%ld",(long)contentItem.commentNum];
    } else {
        _commentLabel.text=@"0";
    }
    [self layoutSubviews];
}

- (void)copyText:(id)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_contentLabel.text];
}

- (BOOL)canBecomeFirstResponder{
    return NO;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _TouchLikeImage = NO;
    _TouchCommentImage = NO;
    
    UITouch *touch = touches.anyObject;
    CGRect customPraiseFrame = CGRectMake(0, 0, CGRectGetWidth(_likeIMG.frame)*3, CGRectGetHeight(_likeIMG.frame)*3);
    CGPoint point = [touch locationInView:_likeIMG];
    
    CGRect customCommentFrame = CGRectMake(0, 0, CGRectGetWidth(_commentIMG.frame)*3, CGRectGetHeight(_commentIMG.frame)*3);
    CGPoint point2 = [touch locationInView:_commentIMG];
    
    if (CGRectContainsPoint(customPraiseFrame, point)) {
        _TouchLikeImage = YES;
    } else if (CGRectContainsPoint(customCommentFrame, point2)) {
        _TouchCommentImage = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_TouchLikeImage) {
        if ([_myDelegate respondsToSelector:@selector(touchLikeAction:)]) {
            [_myDelegate touchLikeAction:self];
        }
    } else if (_TouchCommentImage) {
        if ([_myDelegate respondsToSelector:@selector(touchCommentAction:)]) {
            [_myDelegate touchCommentAction:self];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_TouchLikeImage || !_TouchCommentImage) {
        [super touchesCancelled:touches withEvent:event];
    }
}

//点赞动画效果
- (void)setLikeStatus:(BOOL)isLike animation:(BOOL)isNeedAnimation
{
    UIImage* image = isLike ? [self likeImage] : [self unlikeImage];
    if (isNeedAnimation) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            _likeIMG.layer.transformScale = 1.7;
        } completion:^(BOOL finished) {
            
            _likeIMG.image = image;
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                _likeIMG.layer.transformScale = 0.9;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                    _likeIMG.layer.transformScale = 1;
                } completion:^(BOOL finished) {
                    [self operationLabel:_likeLabel curCount:_contentItem.praiseNum describeText:@"0"];
                }];
            }];
        }];
    } else {
        [_likeIMG setImage:image];
        [self operationLabel:_likeLabel curCount:_contentItem.praiseNum describeText:@"0"];
    }
}





@end
