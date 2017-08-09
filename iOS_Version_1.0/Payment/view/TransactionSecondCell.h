//
//  TransactionSecondCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/16.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TransactionSecondCellIdentifier @"TransactionSecondCell"
@interface TransactionSecondCell : UITableViewCell
+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;
@end
