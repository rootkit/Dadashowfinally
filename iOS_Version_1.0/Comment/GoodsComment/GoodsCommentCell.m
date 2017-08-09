//
//  GoodsCommentCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "GoodsCommentCell.h"
#import "UIColorHF.h"
#import "UIImageView+Comment.h"
#import <YYKit/YYKit.h>

#define PORTRAIT_WIDTH_HEIGHT 42
@interface GoodsCommentCell ()
{
    BOOL _TouchLikeImage;
    UIView *bottomView;
}

@property (nonatomic, strong) UIImageView *portraitIMG;
@property (nonatomic, strong) UILabel *usernameLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *levelLb;

@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIImageView *goodsIMG;

@property (nonatomic, strong) UILabel *watchCountLb;
@property (nonatomic, strong) UIImageView *likeIconIMG;
@property (nonatomic, strong) YYLabel *likeCountLb;

@end

@implementation GoodsCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
    GoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
    _portraitIMG.backgroundColor = [UIColor themeColor];
    [_portraitIMG handleCornerRadiusWithRadius:PORTRAIT_WIDTH_HEIGHT/2];
    
    [bottomView addSubview:_portraitIMG];
    
    _usernameLb = [UILabel new];
    _usernameLb.font = [UIFont systemFontOfSize:13];
    _usernameLb.textColor = [UIColor colorWithHex:0x5a5a5a];
    [bottomView addSubview:_usernameLb];
    
    _levelLb = [UILabel new];
    _levelLb.font = [UIFont systemFontOfSize:12];
    _levelLb.textColor = ThemeColor;
    [bottomView addSubview:_levelLb];
    
    _timeLb = [UILabel new];
    _timeLb.font = [UIFont systemFontOfSize:10];
    _timeLb.textColor = [UIColor colorWithHex:0xa5a7a9];
    [bottomView addSubview:_timeLb];
    
    _contentLb = [UILabel new];
    _contentLb.font = [UIFont systemFontOfSize:13];
    _contentLb.numberOfLines = 0;
    _contentLb.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLb.textColor = [UIColor colorWithHex:0x5a5a5a];
    [bottomView addSubview:_contentLb];
    
    _goodsIMG = [UIImageView new];
    [self.contentView addSubview:_goodsIMG];
    
    _watchCountLb = [UILabel new];
    _watchCountLb.font = [UIFont systemFontOfSize:12];
    _watchCountLb.textColor = [UIColor colorWithHex:0x505050];
    [bottomView addSubview:_watchCountLb];
    
    _likeIconIMG = [UIImageView new];
    _likeIconIMG.image = [self unGoodsLikeImage];
    [bottomView addSubview:_likeIconIMG];
    
    YYLabel *likeCountLabel = [YYLabel new];
    _likeCountLb = likeCountLabel;
    _likeCountLb.textAlignment = NSTextAlignmentCenter;
    _likeCountLb.font = [UIFont systemFontOfSize:12];
    _likeCountLb.textColor = IconTextColor;
    _likeCountLb.displaysAsynchronously = YES;
    _likeCountLb.fadeOnAsynchronouslyDisplay = NO;
    _likeCountLb.fadeOnHighlight = NO;
    [bottomView addSubview:_likeCountLb];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    bottomView.frame = CGRectMake(0, 3, CGRectGetWidth(self.contentView.frame), _goodsCommentItem.rowHeight);
    
    _portraitIMG.frame = _goodsCommentItem.goodsCommentLayoutInfo.userPortraitIMGFrame;
    _usernameLb.frame = _goodsCommentItem.goodsCommentLayoutInfo.userNameLbFrame;
    _levelLb.frame = _goodsCommentItem.goodsCommentLayoutInfo.levelLbFrame;
    _timeLb.frame = _goodsCommentItem.goodsCommentLayoutInfo.timeLbFrame;
    
    _contentLb.frame = _goodsCommentItem.goodsCommentLayoutInfo.contentLbFrame;
    
    if (_goodsCommentItem.images.count > 0) {
        _goodsIMG.frame = _goodsCommentItem.goodsCommentLayoutInfo.imageVFrame;
        _watchCountLb.frame = _goodsCommentItem.goodsCommentLayoutInfo.watchCountLbFrame;
        
        [self fillImages];
    } else {}
    
    _likeIconIMG.frame = _goodsCommentItem.goodsCommentLayoutInfo.likeIMGFrame;
    _likeCountLb.frame = _goodsCommentItem.goodsCommentLayoutInfo.likeLbFrame;
}

- (void)fillImages
{
    CGFloat imagePadding = (CGRectGetWidth(_goodsCommentItem.goodsCommentLayoutInfo.imageVFrame) - 3*image_W)/2;
    [_goodsCommentItem.images enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *IMG = [[UIImageView alloc] init];
        [IMG loadPicture:[NSURL URLWithString:imageName]];
        IMG.frame = CGRectMake((image_W+imagePadding)*idx, 0, image_W, image_H);
        [_goodsIMG addSubview:IMG];
    }];
}

#pragma mark - set

- (void)setGoodsCommentItem:(GoodsCommentItem *)goodsCommentItem
{
    _goodsCommentItem = goodsCommentItem;
    
    [_portraitIMG loadPortrait:[NSURL URLWithString:goodsCommentItem.portraitUrl]];
    _usernameLb.text = goodsCommentItem.username;
    _levelLb.text = [NSString stringWithFormat:@"Lv%ld", (long)goodsCommentItem.level];
    _timeLb.text = goodsCommentItem.time;
    
    _contentLb.text = goodsCommentItem.content;
    _watchCountLb.text = [NSString stringWithFormat:@"浏览%ld次", (long)goodsCommentItem.watchCount];
    _likeIconIMG.image = goodsCommentItem.isLike ? [self goodsLikeImage] : [self unGoodsLikeImage];
    _likeCountLb.text = [NSString stringWithFormat:@"%@", (goodsCommentItem.isLike ? @"已赞" : @"点赞")];
    _likeCountLb.textColor = goodsCommentItem.isLike ? ThemeColor : IconTextColor;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _TouchLikeImage = NO;
    
    UITouch *touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:_likeIconIMG];
    if (CGRectContainsPoint(_likeIconIMG.bounds, point)) {
        _TouchLikeImage = YES;
    } else {
        [super touchesBegan:touches withEvent:event];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_TouchLikeImage) {
        if ([_delegate respondsToSelector:@selector(touchLikeAction:)]) {
            [_delegate touchLikeAction:self];
        }
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_TouchLikeImage) {
        [super touchesCancelled:touches withEvent:event];
    }
}

//点赞动画效果
- (void)setLikeStatus:(BOOL)isLike animation:(BOOL)isNeedAnimation
{
    UIImage* image = isLike ? [self goodsLikeImage] : [self unGoodsLikeImage];
    if (isNeedAnimation) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            _likeIconIMG.layer.transformScale = 1.7;
        } completion:^(BOOL finished) {
            
            _likeIconIMG.image = image;
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                _likeIconIMG.layer.transformScale = 0.9;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                    _likeIconIMG.layer.transformScale = 1;
                } completion:^(BOOL finished) {
                    [self operationGoodsLabel:_likeCountLb isLike:isLike];//oodsCommentItem.isLike];
                }];
            }];
        }];
    } else {
        [_likeIconIMG setImage:image];
        [self operationGoodsLabel:_likeCountLb isLike:isLike];//_goodsCommentItem.isLike];
    }
}

@end
