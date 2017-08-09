//
//  LimitedGoodsTimePageView.h
//  testSecondsView
//
//  Created by ping_L on 2017/6/1.
//  Copyright © 2017年 ping_L. All rights reserved.
//

/***** 滚动标题栏 *****/
#import <UIKit/UIKit.h>

@interface LimitedGoodsTimePageView : UIView

@property (nonatomic, strong) void(^didTitleClick)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)setCurrentTitleIndex:(NSInteger)index;

@end


@interface CustomHTitleButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame withTopTitle:(NSString *)topTitle withBottomTitle:(NSString *)bottomTitle withFont:(UIFont *)font;

@end
