//
//  HelpCenterDescCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "HelpCenterDescCell.h"

@implementation HelpCenterDescCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    HelpCenterDescCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textViewLabel.userInteractionEnabled = NO;
    
    return cell;
}

@end
