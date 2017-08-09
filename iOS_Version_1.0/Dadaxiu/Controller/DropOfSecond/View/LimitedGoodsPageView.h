//
//  LimitedGoodsPageView.h
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

/***** 滚动内容栏 *****/
#import <UIKit/UIKit.h>

@interface LimitedGoodsPageView : UIView

@property (nonatomic, strong) void(^didEndScrollView)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame childVC:(NSArray *)childVC;

- (void)setCurrentIndex:(NSInteger)index;

@end
