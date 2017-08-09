//
//  FWContentVideoCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FWContentVideoCell.h"

#import "UIColorHF.h"
#import "UIImageView+Comment.h"
#import "Util.h"

#import <YYKit/YYKit.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

#define PORTRAIT_WIDTH_HEIGHT 32
#define Info_Font 12
#define videoButton_W 45

#define timeLB_W 50
#define timeLB_H 12

@interface FWContentVideoCell ()
{
    BOOL _TouchLikeImage;
    BOOL _TouchCommentImage;
    UIView *bottomView;
}

@property (nonatomic, strong) UIButton *videoStartBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *videoView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UIImageView *watchIMG;
@property (nonatomic, strong) UILabel *watchLabel;

@property (nonatomic, strong) UIImageView *likeIMG;
@property (nonatomic, strong) YYLabel *likeLabel;

@property (nonatomic, strong) UIImageView *commentIMG;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *moreLabel; //我的专用

@end

@implementation FWContentVideoCell

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
    FWContentVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = BackCellColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)initSubViews
{
    bottomView = [UIView new];
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    
    _videoView = [UIImageView new];
    _videoView.backgroundColor = DefaultImgBgColor;
    _videoView.contentMode = UIViewContentModeScaleAspectFit;
    _videoView.userInteractionEnabled = YES;
    [bottomView addSubview:_videoView];
    
    _videoStartBtn = [UIButton new];
    [_videoStartBtn setImage:[self videoImage] forState:UIControlStateNormal];
    [_videoStartBtn addTarget:self action:@selector(startPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_videoStartBtn];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor colorWithHex:0xa5a7a9];
    [self.contentView addSubview:_timeLabel];
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:cell_titleLB_fontsize];
    _titleLabel.textColor = [UIColor colorWithHex:0X343434];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [bottomView addSubview:_titleLabel];
    
    _portraitIMG = [UIImageView new];
    _portraitIMG.backgroundColor = DefaultImgBgColor;
    _portraitIMG.image = [UIImage imageNamed:@"userPortrait_default"];
    [_portraitIMG handleCornerRadiusWithRadius:PORTRAIT_WIDTH_HEIGHT/2];
    [bottomView addSubview:_portraitIMG];
    
    _usernameLabel = [UILabel new];
    _usernameLabel.font = [UIFont systemFontOfSize:cell_videoUserNameLB_fontsize];
    _usernameLabel.textColor = VideoUserNameTextColor;
    [bottomView addSubview:_usernameLabel];
    
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
    
    _videoView.frame = _contentItem.contentVideoLayout.videoVFrame;
    
    _videoStartBtn.frame = CGRectMake(CGRectGetMidX(_videoView.frame)-videoButton_W/2, CGRectGetMidY(_videoView.frame)-videoButton_W/2, videoButton_W, videoButton_W);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_videoView.frame)-timeLB_W, CGRectGetMaxY(_videoView.frame)-timeLB_H, CGRectGetWidth(_videoView.frame), timeLB_H);
    
    _titleLabel.frame = _contentItem.contentVideoLayout.titleLbFrame;
    _portraitIMG.frame = _contentItem.contentVideoLayout.userPortraitIMGFrame;
    _usernameLabel.frame = _contentItem.contentVideoLayout.userNameLbFrame;
    
    _watchIMG.frame = _contentItem.contentVideoLayout.watchIconFrame;
    _watchLabel.frame = _contentItem.contentVideoLayout.watchCountFrame;
    
    _likeIMG.frame = _contentItem.contentVideoLayout.likeIconFrame;
    _likeLabel.frame = _contentItem.contentVideoLayout.likeCountFrame;
    
    _commentIMG.frame = _contentItem.contentVideoLayout.commentIconFrame;
    _commentLabel.frame = _contentItem.contentVideoLayout.commentCountFrame;
    
    _moreLabel.frame = _contentItem.contentVideoLayout.moreLbFrame;
}

- (void)setContentItem:(FWContentItem *)contentItem
{
    _contentItem = contentItem;
    
    [_portraitIMG loadPortrait:[NSURL URLWithString:contentItem.headerUrl]];
    
    _likeIMG.image = [contentItem.isPraise isEqualToString:@"1"] ? [self likeImage] : [self unlikeImage];
    _watchLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.browseNum];
    _likeLabel.text = [NSString stringWithFormat:@"%ld", (long)contentItem.praiseNum];
    _commentLabel.text =[NSString stringWithFormat:@"%ld",(long)contentItem.commentNum];
//    _videoView.image = [self getVideoPreViewImage:[NSURL URLWithString:contentItem.url]];
    
    NSLog(@"主题%@",contentItem.publishTitle);
    _usernameLabel.text = contentItem.alias.length > 0 ? contentItem.alias : @"火星人";
    _titleLabel.text = [NSString stringWithFormat:@"%@",contentItem.content];
    _timeLabel.text = [NSString stringWithFormat:@"%@", contentItem.publishDate];//[contentItem.publishDate timeAgoSince];

    [self layoutSubviews];
}

// 获取视频第一帧
- (UIImage*)getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    gen.requestedTimeToleranceAfter = kCMTimeZero;
    gen.requestedTimeToleranceBefore = kCMTimeZero;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return videoImage;
}

#pragma mark - UIButton
- (void)startPlayAction:(UIButton *)btn
{
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(setVideoStartPlay:)]) {
        [_myDelegate setVideoStartPlay:self];
    }
}

- (void)copyText:(id)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_titleLabel.text];
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
