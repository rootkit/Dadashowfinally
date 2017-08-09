//
//  FWContentTextCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//
/****** 动态文字cell  *****/
#import "FWContentCell.h"
#import "FWContentItem.h"

#define FWContentTextCellIdentifier @"FWContentellIdentifier"
@interface FWContentTextCell : FWContentCell <FWContentCellDelegate>

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) FWContentItem *contentItem;

@property (nonatomic, assign) id <FWContentCellDelegate> myDelegate;

@end
