//
//  TableViewCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BrandsListCellIdentifier @"BrandsListCell"
@interface BrandsListCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

@property (weak, nonatomic) IBOutlet UIImageView *brandsIconImg;
@property (weak, nonatomic) IBOutlet UILabel *brandsTitleLb;

@end
