//
//  BrandsHeaderCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

/******  甄大牌，惠来购...  2_cell ******/
#import <UIKit/UIKit.h>

#define BrandsHeaderCellIdentifier @"BrandsHeaderCell"
@class BrandsHeaderCell;

@protocol BrandsHeaderCellDelegate <NSObject>

- (void)clickActionWithBrandsHeaderCellDelegate:(BrandsHeaderCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface BrandsHeaderCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <BrandsHeaderCellDelegate> delegate;

@end
