//
//  AllgoodsTableViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/25.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AllgoodsTableViewCellIdentifier @"AllgoodsTableViewCell"
@interface AllgoodsTableViewCell : UITableViewCell
+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;
@end
