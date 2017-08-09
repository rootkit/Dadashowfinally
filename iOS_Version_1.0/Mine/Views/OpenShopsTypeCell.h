//
//  OpenShopsTypeCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OpenShopsTypeCellIdentifier @"OpenShopsTypeCell"

@interface OpenShopsTypeCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, copy) NSString *title;
@property(nonatomic,strong)UIButton *button;

@end

