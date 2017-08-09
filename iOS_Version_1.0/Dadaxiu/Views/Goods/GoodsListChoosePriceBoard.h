//
//  GoodsListChoosePriceBoard.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 商品筛选按钮弹出框 ****/
#import <Foundation/Foundation.h>

@protocol GoodsListChoosePriceBoardDelegate <NSObject>

- (void)clickeWithPrice:(NSString *)minPrice max:(NSString *)maxPrice;

@end

@interface GoodsListChoosePriceBoard : NSObject

@property (nonatomic, weak) id <GoodsListChoosePriceBoardDelegate> delegate;

+ (instancetype)goodsListChoosePriceBoardManager;
- (void)showBoard;
- (void)hiddenBoard;

@end


///////

@protocol GoodsListChoosePriceViewDelegate <NSObject>

- (void)clickeWithPrice:(NSString *)minPrice max:(NSString *)maxPrice;

@end

@interface GoodsListChoosePriceView : UIView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceViewY;

@property (nonatomic, weak) id <GoodsListChoosePriceViewDelegate> delegate;

+ (instancetype)showGoodsListChoosePriceView;

@end
