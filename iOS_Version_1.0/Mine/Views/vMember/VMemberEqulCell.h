//
//  VMemberEqulCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EqulModel;
#define VMemberEqulCellIdentifier @"VMemberEqulCell"
@interface VMemberEqulCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, strong) EqulModel *model;

@end


@interface EqulModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *descStr;

@end
