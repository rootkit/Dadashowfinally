//
//  DPlayCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** D.PLAY类 图片：左一右二 ****/
#import <UIKit/UIKit.h>
#import "DDXHomeModel.h"
#define DPlayCellIdentifier @"DPlayCell"
@class DPlayCell;

@protocol DPlayCellDelegate <NSObject>

- (void)clickActionWithDPlayCellDelegate:(DPlayCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface DPlayCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <DPlayCellDelegate> delegate;

@property(nonatomic,strong)NSMutableArray <DDXPlateModel *>* hotpeoplemodel;//人气新款模型
@property(nonatomic,strong)NSMutableArray <DDXPlateModel *>* dplaymodel;//人气新款模型
@end

