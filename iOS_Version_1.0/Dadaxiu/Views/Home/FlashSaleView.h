//
//  FlashSaleView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/11.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 滴搭秒 *****/
#import <UIKit/UIKit.h>

@protocol FlashSaleViewDelegate <NSObject>

- (void)clickSaleGoodsWithTags:(NSInteger)brandType;

@end

@interface FlashSaleView : UIView

@property (nonatomic, weak) id <FlashSaleViewDelegate> delegate;

@end


//////
@interface SaleSubView : UIView

@end
