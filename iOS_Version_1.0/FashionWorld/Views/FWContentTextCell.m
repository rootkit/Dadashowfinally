//
//  FWContentTextCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FWContentTextCell.h"
#import "UIColorHF.h"
#import "UIImageView+Comment.h"
#import "Util.h"

#import <YYKit/YYKit.h>

#define Info_Font 12

@interface FWContentTextCell ()
{
    BOOL _TouchLikeImage;
    BOOL _TouchCommentImage;
    UIView *bottomView;
}

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *watchIMG;
@property (nonatomic, strong) UILabel *watchLabel;

@property (nonatomic, strong) UIImageView *likeIMG;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) UIImageView *commentIMG;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIImageView *transIMG;
@property (nonatomic, strong) UILabel *transLabel;

@property (nonatomic, strong) UILabel *moreLabel; //我的专用

@end

@implementation FWContentTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier
{
    FWContentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    _portraitIMG.image = [UIImage imageNamed:@"userPortrait_default"];
    [_portraitIMG handleCornerRadiusWithRadius:_contentItem.portraitW/2];
    
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
    _moreLabel.frame = _contentItem.contentLayout.moreLbFrame;
}

- (void)setContentItem:(FWContentItem *)contentItem
{
    _contentItem = contentItem;
    
    [_portraitIMG handleCornerRadiusWithRadius:_contentItem.portraitW/2];
    [_portraitIMG loadPortrait:[NSURL URLWithString:contentItem.headerUrl]];
    _nameLabel.text = contentItem.alias.length > 0 ? contentItem.alias : @"火星人";
    _timeLabel.text = [NSString stringWithFormat:@"%@", contentItem.publishDate];//[contentItem.publishDate timeAgoSince];
    _contentLabel.text = contentItem.content;
    _likeIMG.image = [contentItem.isPraise isEqualToString:@"1"] ? [self likeImage] : [self unlikeImage];
    _watchLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.browseNum];
    _likeLabel.text = [NSString stringWithFormat:@"%ld", contentItem.praiseNum];
    _commentLabel.text = [NSString stringWithFormat:@"%ld", contentItem.commentNum];
    _transLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.forwardNum];
    
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
