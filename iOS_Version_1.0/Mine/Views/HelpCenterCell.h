//
//  HelpCenterCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HelpCenterCellIdentifier @"HelpCenterCell"

@class HelpCenterCell, HelpCenterModel;
@protocol HelpCenterCellDelegate <NSObject>

- (void)clickToPulldownAction:(HelpCenterCell *)cell;

@end

@interface HelpCenterCell : UITableViewHeaderFooterView

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                 identifier:(NSString *)identifierString;

@property (nonatomic, weak) id <HelpCenterCellDelegate> delegate;
@property (nonatomic, copy) HelpCenterModel *model;

- (void)changePulldownImg:(BOOL)isPulldown;

@end


/********/

@interface HelpCenterModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

@end
