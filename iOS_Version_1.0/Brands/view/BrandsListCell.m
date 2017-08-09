//
//  TableViewCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "BrandsListCell.h"

@implementation BrandsListCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    BrandsListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
