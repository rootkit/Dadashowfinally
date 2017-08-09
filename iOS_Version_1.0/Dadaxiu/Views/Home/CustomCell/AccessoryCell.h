//
//  AccessoryCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 饰品类 图片：上一下三 ****/
#import <UIKit/UIKit.h>
#import "DDXHomeModel.h"
#define AccessoryCellIdentifier @"AccessoryCell"
@class AccessoryCell;

@protocol AccessoryCellDelegate <NSObject>

- (void)clickActionWithAccessoryCell:(AccessoryCell *)cell forIndexTags:(NSInteger)indexTag;

@end

@interface AccessoryCell : UITableViewCell

+ (instancetype)returnResueCellFormTableView:(UITableView *)tableView
                                   indexPath:(NSIndexPath *)indexPath
                                  identifier:(NSString *)identifier;

@property (nonatomic, weak) id <AccessoryCellDelegate> delegate;

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* cartiermodel;

@property (nonatomic, strong) NSMutableArray <DDXPlateModel *>* tammymodel;

@property(nonatomic,assign)NSInteger imagecount;//Carcenter数组个数

@property(nonatomic,assign)NSInteger tammycount; //TAMMY TANGS数组个数

@end
