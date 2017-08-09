//
//  LogistCell.h
//  iOS_Version_1.0
//
//  Created by 李萍 on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

/****** 物流列表cell  *****/
#import <UIKit/UIKit.h>

@interface LogistCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@end
