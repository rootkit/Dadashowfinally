//
//  Listtabelveiw.h
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Listtabelveiw;
@protocol ListtabelveiwDelegate <NSObject>

-(void)clickdissmiss;
-(void)pushdetailvc :(NSString*)goodkeystring;
@end
@interface Listtabelveiw : UITableView

@property(nonatomic,weak)id<ListtabelveiwDelegate> dimissdelegate;

@end
