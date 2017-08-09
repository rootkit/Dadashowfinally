//
//  FWContentImageCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//
/****** 动态图片cell  *****/
#import "FWContentCell.h"
#import "FWContentItem.h"
//@class FWContentImageCell;
//@protocol FWContentImageCellDelegate <NSObject>
//- (void)clickimagecell:(FWContentImageCell*)cell imagearray:(NSArray*)imagearray;
//
//@end
#define FWContentImageCellIdentifier @"FWContentImageCellIdentifier"
@interface FWContentImageCell : FWContentCell <FWContentCellDelegate>

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) FWContentItem *contentItem;

@property (nonatomic, weak) id <FWContentCellDelegate> myDelegate;

//@property(nonatomic,weak)id<FWContentImageCellDelegate> imagedelegate;

@end
