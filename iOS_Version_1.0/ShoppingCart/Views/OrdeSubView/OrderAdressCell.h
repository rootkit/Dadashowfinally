//
//  OrderAdressCell.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OrderAdressCellIdentifierString @"OrderAdressCell"
#define rating kScreen_Width/375

@interface OrderAdressCell : UITableViewCell

+(instancetype)returnReuseCellFormTableView:(UITableView *)tableView
                                  indexPath:(NSIndexPath *)indexPath
                                 identifier:(NSString *)identifierString;

- (void)decideEvenHaveAddress;

@property (nonatomic, strong) DDXConsignee *consignee;

@end
