//
//  OrderLogisticsDetailCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define rating kScreen_Width/375
#define OrderLogisticsDetailCellIdentifier @"OrderLogisticsDetailCell"

@interface OrderLogisticsDetailCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

- (void)logisticsIsFirst:(BOOL)first isLast:(BOOL)last;

@end
