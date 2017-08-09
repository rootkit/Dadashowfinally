//
//  NewContactCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/17.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NewContactCellIdentifier @"NewContactCell"
@class ContactModel, NewContactCell;

@protocol NewContactCellDelegate <NSObject>

- (void)clickFollowAction:(NewContactCell *)cell;

@end

@interface NewContactCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, weak) id <NewContactCellDelegate> delegate;
@property (nonatomic, strong) ContactModel *model;

@end


@interface ContactModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;

@end
