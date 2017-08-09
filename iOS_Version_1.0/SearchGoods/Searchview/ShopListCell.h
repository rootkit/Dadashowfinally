//
//  ShopListCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXHomeModel.h"
#define ShopListCellIdentifier @"GoodListCell"
@interface ShopListCell : UICollectionViewCell
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;
@property(nonatomic,strong)DDXSearchModel* listmodel;//搜索模型

@end
