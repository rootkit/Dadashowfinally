//
//  FWContentCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//
/****** 动态cell父类  *****/
#import <UIKit/UIKit.h>

#import <YYKit/YYKit.h>

@class FWContentCell;
@protocol FWContentCellDelegate <NSObject>

- (void)touchLikeAction:(FWContentCell *)cell; // like action
- (void)touchCommentAction:(FWContentCell *)cell; // like action
- (void)setVideoStartPlay:(FWContentCell *)cell; //start play

@end

@interface FWContentCell : UITableViewCell

@property (nonatomic, copy) BOOL (^canPerformAction)(UITableViewCell *cell, SEL action);
@property (nonatomic, copy) void (^deleteObject)(UITableViewCell *cell);

- (void)copyText:(id)sender;
- (void)deleteObject:(id)sender;

- (UIImage *)videoImage;
- (UIImage *)watchImage;
- (UIImage *)likeImage;
- (UIImage *)unlikeImage;
- (UIImage *)commentImage;
- (UIImage *)transImage;

//
- (UIImage *)goodsLikeImage;
- (UIImage *)unGoodsLikeImage;

//点赞动画效果
- (void)setLikeStatus:(BOOL)isLike animation:(BOOL)isNeedAnimation;
- (void)operationLabel:(YYLabel *)label curCount:(NSInteger)count describeText:(NSString* )desText;
- (void)operationGoodsLabel:(YYLabel *)label isLike:(BOOL)isLike;

@end
