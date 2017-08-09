//
//  VMemberEncycCell.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "VMemberEncycCell.h"

@implementation VMemberEncycCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString
{
    VMemberEncycCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString forIndexPath:indexPath];
    
    return cell;
}

@end
