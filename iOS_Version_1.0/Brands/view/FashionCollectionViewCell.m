//
//  FashionCollectionViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FashionCollectionViewCell.h"
#import "UIColor+CustomColor.h"

@implementation FashionCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self loadCellWithFram:frame];
        
    }
    return self;
}
- (void)loadCellWithFram:(CGRect)frame{
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
    bgImageView.image=[UIImage imageNamed:@"品牌街"];
    [self.contentView addSubview:bgImageView];
    
    UILabel* describehlabel=[UILabel new];
    describehlabel.textColor=[UIColor colorWithHex:0x2e2e2e];
    describehlabel.backgroundColor=[UIColor clearColor];
    describehlabel.text=@"飞亚达特别款手表";
    describehlabel.textAlignment=NSTextAlignmentLeft;
    describehlabel.numberOfLines=2;
    describehlabel.font=[UIFont systemFontOfSize:12*(kScreen_Width/375)];
    [self addSubview:describehlabel];
    [describehlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(9*(kScreen_Width/375)));
        make.top.equalTo(bgImageView.mas_bottom).equalTo(@1);
        make.width.equalTo(@(kScreen_Width/3));
//        make.height.equalTo(@45);
    }];
    UILabel* pricelabel=[UILabel new];
    pricelabel.textColor=[UIColor colorWithHex:0xff39cc];
    pricelabel.backgroundColor=[UIColor clearColor];
    pricelabel.text=@"$8888888";
    pricelabel.textAlignment=NSTextAlignmentLeft;
    pricelabel.numberOfLines=2;
    pricelabel.font=[UIFont systemFontOfSize:12*(kScreen_Width/375)];
    [self addSubview:pricelabel];
    [pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(9*(kScreen_Width/375)));
        make.top.equalTo(describehlabel.mas_bottom).equalTo(@1);
        make.width.equalTo(@(kScreen_Width/3));
        make.height.equalTo(@(29*(kScreen_Width/375)));
    }];
    
    
}
@end
