//
//  GoodListCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXHomeModel.h"

#define GoodListCellIdentifier @"GoodListCell"
@interface GoodListCell : UICollectionViewCell
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, assign) GoodsThirdClassrifyType goodType;

@property (nonatomic, strong) DDXGoodsModel *goodsItem;


+ (UIImage *)goodsCollect;
+ (UIImage *)goodsfashion;
+ (UIImage *)goodsDIY;


@end
