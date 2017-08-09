//
//  PopularCollectionViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PopularCollectionViewCell.h"
#import "UIColor+CustomColor.h"
@implementation PopularCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadCellWithFram:frame];
        
    }
    return self;
}
- (void)loadCellWithFram:(CGRect)frame{
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*(kScreen_Width/375), 10*(kScreen_Width/375), 125*(kScreen_Width/375), 125*(kScreen_Width/375))];
    bgImageView.image=[UIImage imageNamed:@"首页"];
    bgImageView.layer.cornerRadius = 5*(kScreen_Width/375);
    bgImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgImageView];
   
    
    UILabel* pricelabel=[UILabel new];
    pricelabel.textColor=[UIColor colorWithHex:0xff39cc];
    pricelabel.backgroundColor=[UIColor clearColor];
    pricelabel.text=@"$399";
    pricelabel.textAlignment=NSTextAlignmentLeft;
    pricelabel.numberOfLines=2;
    pricelabel.font=[UIFont systemFontOfSize:12*(kScreen_Width/375)];
    [self addSubview:pricelabel];
    [pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(34*(kScreen_Width/375)));
        make.top.equalTo(bgImageView.mas_bottom).equalTo(@(13*(kScreen_Width/375)));
    }];
    UILabel* historicalprice=[UILabel new];
    historicalprice.textColor=[UIColor colorWithHex:0xa8a8a8];
    historicalprice.backgroundColor=[UIColor clearColor];
    historicalprice.text=@"$999";
    historicalprice.textAlignment=NSTextAlignmentLeft;
    historicalprice.numberOfLines=2;
    historicalprice.font=[UIFont systemFontOfSize:10*(kScreen_Width/375)];
    [self addSubview:historicalprice];
    [historicalprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageView.mas_bottom).equalTo(@(14*(kScreen_Width/375)));
        make.left.equalTo(pricelabel.mas_right).equalTo(@(20*(kScreen_Width/375)));
    }];
        UILabel* numberlabel=[UILabel new];
       numberlabel.textColor=[UIColor colorWithHex:0x2e2e2e];
        numberlabel.backgroundColor=[UIColor clearColor];
        numberlabel.text=@"117件已经售出";
        numberlabel.textAlignment=NSTextAlignmentLeft;
        numberlabel.numberOfLines=2;
        numberlabel.font=[UIFont systemFontOfSize:12.0*(kScreen_Width/375)];
        [self addSubview:numberlabel];
        [numberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(38*(kScreen_Width/375)));
            make.top.equalTo(pricelabel.mas_bottom).equalTo(@0);

        }];
    
    
    
    
}
@end
