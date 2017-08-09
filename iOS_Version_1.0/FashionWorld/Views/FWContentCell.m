//
//  FWContentCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FWContentCell.h"

@implementation FWContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO; // Remove touch delay for iOS 7
            break;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundView.backgroundColor = [UIColor whiteColor];;
    self.contentView.backgroundColor = [UIColor whiteColor];;
    self.backgroundColor = [UIColor whiteColor];
//    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
//    self.selectedBackgroundView.backgroundColor = [UIColor selectCellSColor];
    return self;
}

#pragma mark - image

static UIImage *_videoImage;
- (UIImage *)videoImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _videoImage = [UIImage imageNamed:@"Play-copy"];
    });
    return _videoImage;
}

static UIImage *_watchImage;
- (UIImage *)watchImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _watchImage = [UIImage imageNamed:@"ico_watch"];
    });
    return _watchImage;
}

static UIImage *_likeImage;
- (UIImage *)likeImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _likeImage = [UIImage imageNamed:@"ico_like"];
    });
    return _likeImage;
}

static UIImage *_unlikeImage;
- (UIImage *)unlikeImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unlikeImage = [UIImage imageNamed:@"ico_unlike"];
    });
    return _unlikeImage;
}

static UIImage *_commentImage;
- (UIImage *)commentImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _commentImage = [UIImage imageNamed:@"ico_comment"];
    });
    return _commentImage;
}

static UIImage *_transImage;
- (UIImage *)transImage {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _transImage = [UIImage imageNamed:@"ico_trans"];
    });
    return _transImage;
}

//
static UIImage *_goodsLikeImage;
- (UIImage *)goodsLikeImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _goodsLikeImage = [UIImage imageNamed:@"likeGoods"];
    });
    return _goodsLikeImage;
}
static UIImage *_unGoodsLikeImage;
- (UIImage *)unGoodsLikeImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unGoodsLikeImage = [UIImage imageNamed:@"unLikeGoods"];
    });
    return _unGoodsLikeImage;
}

#pragma mark - delegate
//start play
- (void)setVideoStartPlay:(FWContentCell *)cell
{
    
}

//点赞动画效果
- (void)setLikeStatus:(BOOL)isLike animation:(BOOL)isNeedAnimation
{
    
}
//更换点赞数
- (void)operationLabel:(YYLabel* )label curCount:(NSInteger)count describeText:(NSString* )desText
{
    
}
//商品点赞更换状态
- (void)operationGoodsLabel:(YYLabel *)label isLike:(BOOL)isLike
{
    label.text = isLike ? @"已赞" : @"点赞";
}

#pragma mark - 处理长按操作

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _canPerformAction(self, action);
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)copyText:(id)sender
{
    
}

- (void)deleteObject:(id)sender
{
    _deleteObject(self);
}

@end
