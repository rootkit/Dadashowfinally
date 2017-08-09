//
//  SearchKindCollectionViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SearchKindCellIdentifier @"SearchKindCell"
@interface SearchKindCollectionViewCell : UICollectionViewCell
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
