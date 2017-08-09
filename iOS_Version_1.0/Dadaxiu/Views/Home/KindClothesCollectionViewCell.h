//
//  KindClothesCollectionViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  商品分类  2_View ******/
#import <UIKit/UIKit.h>

#define KindClothesCollectionViewCellIdentifier @"KindClothesCollectionViewCell"

@class GoodsFirstClassifyModel;
@interface KindClothesCollectionViewCell : UICollectionViewCell

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) GoodsFirstClassifyModel *model;

@end


@interface GoodsFirstClassifyModel : NSObject

@property (nonatomic, copy) NSString* goodsId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *dicArray;

@end
