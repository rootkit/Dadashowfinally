//
//  FollowListCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/6.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FollowListCell;
@protocol FollowListCellDelegate <NSObject>

- (void)clickPortraitAction:(FollowListCell *)cell indexPathRow:(NSInteger)row;
- (void)clickFollowingAction:(FollowListCell *)cell indexPathRow:(NSInteger)row;

@end

#define FollowListCellIdentifier @"FollowListCell"

@interface FollowListCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <FollowListCellDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;

- (void)changeBtnTitle:(BOOL)isFollow; //关注按钮变化

@end
