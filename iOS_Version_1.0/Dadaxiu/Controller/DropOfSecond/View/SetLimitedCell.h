//
//  SetLimitedCell.h
//  testSecondsView
//
//  Created by ping_L on 2017/6/2.
//  Copyright © 2017年 ping_L. All rights reserved.
//

/***** 限量秒杀cell ****/
#import <UIKit/UIKit.h>

#define SetLimitedCellIdentifier @"SetLimitedCell"
@class SetLimitedCell;
@protocol SetLimitedCellDelegate <NSObject>

- (void)clickSetLimitedCell:(SetLimitedCell *)cell;

@end

@interface SetLimitedCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <SetLimitedCellDelegate> delegate;

@end


///////
@interface LimitedSubView : UIView

@end
