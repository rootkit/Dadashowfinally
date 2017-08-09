//
//  ShopClassifyCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/19.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ShopClassifyCellIdentifier @"ShopClassifyCell"
@interface ShopClassifyCell : UICollectionViewCell

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) NSString *title;

@end
