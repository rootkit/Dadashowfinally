//
//  CollectShopsCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CollectShopsCellIdentifier @"CollectShopsCell"
@interface CollectShopsCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
