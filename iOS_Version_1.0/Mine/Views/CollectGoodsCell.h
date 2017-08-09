//
//  CollectGoodsCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineGoodsmodel.h"
#define rating kScreen_Width/375
#define CollectGoodsCellIdentifier @"CollectGoodsCell"

@interface CollectGoodsCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;
@property(nonatomic,strong)MineGoodsmodel* model;//收藏商品模型

@property(nonatomic,strong)Travelmodel* tranvemodel;//我的足迹模型
@end
