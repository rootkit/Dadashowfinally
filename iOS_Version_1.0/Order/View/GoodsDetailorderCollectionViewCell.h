//
//  GoodsDetailorderCollectionViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****我的订单详情商品订单cell ****/
#import <UIKit/UIKit.h>
#define GoodsDetailorderIdentifier @"GoodsDetailorderCell"
@interface GoodsDetailorderCollectionViewCell : UICollectionViewCell
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;


@end
