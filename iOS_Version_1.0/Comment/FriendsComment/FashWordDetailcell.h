//
//  FashWordDetailcell.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailComment.h"
@class FashWordDetailcell;

@protocol FashWordDetailcellDelegate <NSObject>

//-(void)clickfirendusername:(FashWordDetailcell*)cell;
-(void)clickfirendusername:(FashWordDetailcell*)cell firendid:(NSString*)friendid;
@end
#define commentCellIdentifier @"commentCellIdentifier"
@interface FashWordDetailcell : UITableViewCell
+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, strong) DetailComment *commentItem;
@property (nonatomic, weak) id <FashWordDetailcellDelegate> delegate;
@end
