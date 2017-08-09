//
//  SelectedLimitedCell.h
//  testSecondsView
//
//  Created by ping_L on 2017/6/2.
//  Copyright © 2017年 ping_L. All rights reserved.
//

/***** 精选秒杀cell ****/
#import <UIKit/UIKit.h>

#define SelectedLimitedCellIdentifier @"SelectedLimitedCell"
@interface SelectedLimitedCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
