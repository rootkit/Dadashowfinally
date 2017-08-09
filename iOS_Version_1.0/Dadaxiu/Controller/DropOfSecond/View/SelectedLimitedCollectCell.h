//
//  SelectedLimitedCollectCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/2.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SelectedLimitedCollectCellIdentifier @"SelectedLimitedCollectCell"
@interface SelectedLimitedCollectCell : UICollectionViewCell

+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
