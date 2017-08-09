//
//  CardScrollView.h
//  TestScrollCardView
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 ping_L. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CardScrollViewDelegate <NSObject>

@optional

//滚动代理方法
-(void)cardScrollViewDidSelectedAt:(NSInteger)index;

@end

@interface CardScrollView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                 forItemWidth:(CGFloat)itemWidth
                forItemHeight:(CGFloat)itemHeight
               forItemSpacing:(CGFloat)itemSpacing;

@property (weak,nonatomic) id<CardScrollViewDelegate>delegate;

@end
