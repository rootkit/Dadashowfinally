//
//  DrawbackDealCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 卖家处理 ****/
#import <UIKit/UIKit.h>

#define rating kScreen_Width/375
#define DrawbackDealCellIdentifier @"DrawbackDealCell"
@interface DrawbackDealCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@end
