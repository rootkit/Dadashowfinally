//
//  MessagelistTableViewCell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/21.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MessagelistTableViewCellIdentifier @"MessagelistTableViewCell"

@class MessageModel;
@interface MessagelistTableViewCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) MessageModel *message;

@end

////
@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *time;

@end
