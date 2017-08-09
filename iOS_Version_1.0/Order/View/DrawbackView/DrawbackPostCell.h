//
//  DrawbackPostCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 买家发起申请 ****/
#import <UIKit/UIKit.h>

#define rating kScreen_Width/375
#define DrawbackPostCellIdentifier @"DrawbackPostCell"
@class DrawbackModel;
@interface DrawbackPostCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (nonatomic, strong) DrawbackModel *model;
@property (nonatomic, strong) UIColor *popColor;
@property (nonatomic, strong) UIColor *textAndBgColor;

@end

@interface DrawbackModel : NSObject

@property (nonatomic, copy) NSString *stateStr;
@property (nonatomic, copy) NSString *info;

@end

