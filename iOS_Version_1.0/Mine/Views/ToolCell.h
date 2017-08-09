//
//  ToolCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ToolCellIdentifier @"ToolCell"

@class ToolModel;
@interface ToolCell : UICollectionViewCell
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) ToolModel *toolModel;

@end

@interface ToolModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;

@end
