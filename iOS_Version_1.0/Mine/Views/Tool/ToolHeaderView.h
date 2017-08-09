//
//  ToolHeaderView.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ToolHeaderViewIdentifier @"ToolHeaderView"
@interface ToolHeaderView : UICollectionReusableView
+ (instancetype)returnResueCellFormTableView:(UICollectionView *)collectionView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, strong) UIColor *headerViewBgColor;

@end
