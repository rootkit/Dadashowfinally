//
//  FWContentVideoCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/28.
//  Copyright © 2017年 李萍. All rights reserved.
//
/****** 动态视频cell  *****/
#import "FWContentCell.h"
#import "FWContentItem.h"

#define FWContentVideoCellIdentifier @"FWContentVideoCellIdentifier"

@interface FWContentVideoCell : FWContentCell <FWContentCellDelegate>

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) FWContentItem *contentItem;

@property (nonatomic, assign) id <FWContentCellDelegate> myDelegate;

@end
