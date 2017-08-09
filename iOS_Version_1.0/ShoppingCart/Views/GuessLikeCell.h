//
//  GuessLikeCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/3.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXShopCartGoods.h"

@protocol GuessLikeItemDelegate <NSObject>

- (void)pushGoodsToCart;

@end

#define GuessLikeItemIdentifier  @"GuessLikeCell"
@interface GuessLikeCell : UICollectionViewCell

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <GuessLikeItemDelegate> delegate;
@property (nonatomic, strong) DDXLikeGoodsModel *likeModel;
@end
