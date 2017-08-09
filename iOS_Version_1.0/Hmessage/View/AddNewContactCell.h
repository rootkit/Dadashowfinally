//
//  AddNewContactCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AddNewContactCellIdentifier @"AddNewContactCell"

@interface AddNewContactCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
