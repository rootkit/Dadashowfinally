//
//  HZNormalHeader.m
//  Mjfreshgif
//
//  Created by liping on 2017/5/11.
//  Copyright © 2017年 梁亚海. All rights reserved.
//

#import "HZNormalHeader.h"

@implementation HZNormalHeader

//重新父类的动画方法
//刷新的动画大小根据你的图片大小来决定
-(void)prepare{
     [super prepare];
//    // 设置普通状态的动画图片(下拉刷新成功后显示的图片)
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=4; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
       UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //这边图片数量必须保持一致
    
//    // 设置正在刷新状态的动画图片
//    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;//设置时间显示的话会出现在左边动画
    //隐藏状态
    self.stateLabel.hidden = YES;//隐藏动态标签
}


@end
