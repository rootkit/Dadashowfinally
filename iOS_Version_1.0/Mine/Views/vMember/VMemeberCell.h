//
//  VMemeberCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VMemeberCellIdentifier @"VMemeberCell"
@interface VMemeberCell : UITableViewCell
+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@end
