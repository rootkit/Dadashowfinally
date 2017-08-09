//
//  GuessLikeCCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GuessLikeCCellIdentifier @"GuessLikeCCell"

@protocol GuessLikeCCellDelegate <NSObject>

- (void)pushGoodsToCartAction;

@end

@interface GuessLikeCCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <GuessLikeCCellDelegate> delegate;

@end
