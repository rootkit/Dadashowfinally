//
//  FWCommentCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//
/****** 动态评论cell  *****/
#import <UIKit/UIKit.h>
#import "CommentItem.h"

#define commentCellIdentifier @"commentCellIdentifier"
@interface FWCommentCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) CommentItem *commentItem;

@property (nonatomic, copy) BOOL (^canPerformAction)(UITableViewCell *cell, SEL action);
@property (nonatomic, copy) void (^deleteObject)(UITableViewCell *cell);

- (void)copyText:(id)sender;
- (void)deleteObject:(id)sender;

@end
