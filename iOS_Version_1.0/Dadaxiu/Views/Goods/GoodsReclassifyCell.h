//
//  GoodsReclassifyCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KindClothesCollectionViewCell.h"

#define GoodsReclassifyCellIdentifier @"GoodsReclassifyCell"

@class GoodsFirstClassifyModel;
@interface GoodsReclassifyCell : UICollectionViewCell

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) GoodsFirstClassifyModel *model;

@end

/**** GoodsSecondClassifyModel ****/

@interface GoodsSecondClassifyModel : NSObject

@property (nonatomic, copy) NSString *secondTitle;
@property (nonatomic, strong) NSMutableArray <GoodsFirstClassifyModel *> *thirdClassify;

@end
