//
//  RechargesuccessViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "RechargesuccessViewController.h"
#import "UIColor+CustomColor.h"
@interface RechargesuccessViewController ()

@end

@implementation RechargesuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    self.title=@"充值结果";
    self.moneynumber=@"3360";
    [self rechargeview];
}

-(void)rechargeview{
    UIView* headchargeview=[UIView new];
    headchargeview.backgroundColor=[UIColor whiteColor];
    headchargeview.frame=CGRectMake(0, 64, kScreen_Width, 290);
    [self.view addSubview:headchargeview];
    
    UIImageView* foximage=[[UIImageView alloc]init];;
    foximage.image=[UIImage imageNamed:@"yes_recharge"];
    [headchargeview addSubview:foximage];
    [foximage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@60);
        make.left.equalTo(@((kScreen_Width-198)/2));
        make.width.equalTo(@198);
        make.height.equalTo(@128);
        
    }];
    
    UILabel *moneylabel = [[UILabel alloc] init];
    moneylabel.font = [UIFont systemFontOfSize:13];
    moneylabel.textColor=[UIColor colorWithHex:0xf30867];
    moneylabel.text=[NSString stringWithFormat:@"获得%@搭搭币",self.moneynumber];
    moneylabel.textAlignment=NSTextAlignmentCenter;
    [headchargeview addSubview:moneylabel];
    [moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(foximage.mas_bottom).equalTo(@31);
        make.left.equalTo(foximage.mas_left);
        make.right.equalTo(foximage.mas_right);
    }];
    
    UIButton * pursebtn=[[UIButton alloc]init];
    [pursebtn setBackgroundImage:[UIImage imageNamed:@"ViewWallet_btn"] forState:UIControlStateNormal];
    [pursebtn addTarget:self action:@selector(purse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pursebtn];
    [pursebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headchargeview.mas_bottom).equalTo(@45);
        make.left.equalTo(@38);
        make.right.height.equalTo(@-38);
        make.height.equalTo(@45);
    }];

}
-(void)purse{
    NSLog(@"查看钱包");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
