//
//  NotideatilTableViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NotideatilTableViewCellIdentifier @"NotideatilTableViewCell"
@interface NotideatilTableViewCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@end
