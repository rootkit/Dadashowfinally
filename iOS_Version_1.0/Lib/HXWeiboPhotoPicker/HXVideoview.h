//
//  HXVideoview.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXPhotoManager.h"
/*
 *  使用选择照片之后自动布局的功能时就创建此块View. 初始化方法传入照片管理类
 */
@protocol HXPhotoViewDelegate <NSObject>

// 代理返回 选择、移动顺序、删除之后的图片以及视频
- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal;

// 当view更新高度时调用
- (void)photoViewUpdateFrame:(CGRect)frame WithView:(UIView *)view;

@end

@interface HXVideoview : UIView

@property (weak, nonatomic) id<HXPhotoViewDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *currentIndexPath; // 自定义转场动画时用到的属性
- (instancetype)initWithFrame:(CGRect)frame WithManager:(HXPhotoManager *)manager;
- (instancetype)initWithManager:(HXPhotoManager *)manager;
+ (instancetype)photoManager:(HXPhotoManager *)manager;
@end
