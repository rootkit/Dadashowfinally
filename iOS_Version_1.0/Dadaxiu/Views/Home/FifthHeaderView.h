//
//  FifthHeaderView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/11.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  甄大牌，惠来购...  3_View ******/
#import <UIKit/UIKit.h>

@protocol FifthHeaderViewDelegate <NSObject>

- (void)clickPerferGoodsWithTags:(NSInteger)indexRow;

@end

@interface FifthHeaderView : UIView

@property (nonatomic, weak) id <FifthHeaderViewDelegate> delegate;

@end

