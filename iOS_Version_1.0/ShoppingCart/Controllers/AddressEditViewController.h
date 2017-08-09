//
//  AddressEditViewController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDXConsignee.h"

@interface AddressEditViewController : UIViewController

- (instancetype)initWithMessage:(BOOL)isEditing consignee:(DDXConsignee *)consig;
@property (nonatomic, copy) NSString *phoneNum;
@property(nonatomic,assign)BOOL rightbtnishide;
@property(nonatomic,strong)void(^saveaddressblock)();

@end
