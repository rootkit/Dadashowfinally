//
//  CommodityTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/2.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CommodityTableViewCell.h"
#import "UIColor+CustomColor.h"
@implementation CommodityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setcommoditycell];
        
        
    }
    return  self;
}
-(void)setcommoditycell{
    UIImageView *shopsimage = [[UIImageView alloc] init];
    shopsimage.image=[UIImage imageNamed:@"限时抢购"];
    [self.contentView addSubview:shopsimage];
    [shopsimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@120);
        make.height.equalTo(@120);
    }];
    
    UILabel *shopnames = [[UILabel alloc] init];
    shopnames.font = [UIFont systemFontOfSize:14.0];
//    shopnames.backgroundColor=[UIColor greenColor];
    shopnames.text=@"韩版时尚刺绣半高领衬衫";
    [self.contentView addSubview:shopnames];
    [shopnames mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(shopsimage.mas_right).equalTo(@5);
//        make.height.equalTo(@25);
    }];
    //进度条
    UIProgressView*oneProgressView = [[UIProgressView alloc]init];
    oneProgressView.progress=0.8;
    oneProgressView.layer.cornerRadius = 7;
    oneProgressView.layer.masksToBounds = YES;
//    oneProgressView.backgroundColor= [UIColor redColor];//设置背景色
    oneProgressView.progressViewStyle = UIProgressViewStyleDefault;//进度条风
    oneProgressView.progressTintColor= [UIColor yellowColor];//设置已过进度部分
    oneProgressView.trackTintColor= [UIColor colorWithHex:0xa8a8a8];//设置未过进度部分的颜色
    [oneProgressView setProgress:0.3 animated:YES]; //设置初始值，可以看到动画效果
    [self.contentView addSubview:oneProgressView];//添加到视图上
    [oneProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopnames.mas_bottom).equalTo(@5);
        make.left.equalTo(shopsimage.mas_right).equalTo(@5);
        make.height.equalTo(@7);
         make.right.equalTo(@-14);
    }];
     //已售出的数量
    UILabel *sellout= [[UILabel alloc] init];
    sellout.font = [UIFont systemFontOfSize:12.0];
    //    shopnames.backgroundColor=[UIColor greenColor];
    sellout.text=@"已抢购52件";
    sellout.textColor=[UIColor colorWithHex:0xa8a8a8];
    [self.contentView addSubview:sellout];
    [sellout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneProgressView.mas_bottom).equalTo(@5);
        make.left.equalTo(shopsimage.mas_right).equalTo(@5);
       
    }];
    
    // 还剩下的数量
    UILabel *remain= [[UILabel alloc] init];
    remain.font = [UIFont systemFontOfSize:12.0];
    //    shopnames.backgroundColor=[UIColor greenColor];
    remain.text=@"仅剩190件";
    remain.textColor=[UIColor colorWithHex:0xfc5c98];
    remain.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:remain];
    [remain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneProgressView.mas_bottom).equalTo(@5);
        make.right.equalTo(oneProgressView.mas_right);
        
    }];
    //价格标签
    UILabel *priceslabel= [[UILabel alloc] init];
    priceslabel.font = [UIFont systemFontOfSize:18.0];
    //    shopnames.backgroundColor=[UIColor greenColor];
    priceslabel.text=@"$79.00";
    priceslabel.textColor=[UIColor blackColor];
    priceslabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:priceslabel];
    [priceslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sellout.mas_bottom).equalTo(@20);
       make.left.equalTo(shopsimage.mas_right).equalTo(@5);
        
    }];
    //历史价格
    UILabel *historyprice= [[UILabel alloc] init];
    historyprice.font = [UIFont systemFontOfSize:11.0];
    //    shopnames.backgroundColor=[UIColor greenColor];
    historyprice.text=@"$199.00";
    historyprice.textColor=[UIColor colorWithHex:0xa8a8a8];
    historyprice.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:historyprice];
    [historyprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceslabel.mas_bottom).equalTo(@2);
        make.left.equalTo(shopsimage.mas_right).equalTo(@5);
        
    }];
    UILabel* line=[UILabel new];
    line.backgroundColor=[UIColor colorWithHex:0xa8a8a8];
//    line.backgroundColor=[UIColor redColor];
//    line.frame=CGRectMake(0, 5, historyprice.frame.size.width, 2);
    [historyprice addSubview:line];
     [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@6);
        make.left.equalTo(historyprice.mas_left);
        make.height.equalTo(@2);
        make.right.equalTo(historyprice.mas_right);
        
    }];
    // 付款按钮
    UIButton * buyingbtn=[[UIButton alloc]init];
    [buyingbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyingbtn setTitle:@"立刻抢购" forState:UIControlStateNormal];
    [buyingbtn setBackgroundColor:[UIColor colorWithHex:0xfc5c98]];
    buyingbtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
     buyingbtn.userInteractionEnabled = YES;
    [self.contentView addSubview:buyingbtn];
    [buyingbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceslabel.mas_top);
        make.right.equalTo(oneProgressView.mas_right);
        make.width.equalTo(@81);
        make.height.equalTo(@27);
    }];
    _buyingbtn=buyingbtn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
