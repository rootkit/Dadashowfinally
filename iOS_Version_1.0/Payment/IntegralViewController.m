//
//  IntegralViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "IntegralViewController.h"

@interface IntegralViewController ()

@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"积分商城";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setintergralview];
}

-(void)setintergralview{
    
    UIImageView* integrimage=[[UIImageView alloc]init];;
    integrimage.image=[UIImage imageNamed:@"img_developing"];
    [self.view addSubview:integrimage];
    [integrimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@156);
        make.left.equalTo(@((kScreen_Width-130)/2));
        make.width.equalTo(@130);
        make.height.equalTo(@190);
        
    }];
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor=[UIColor colorWithHex:0x747474];
        label.frame=CGRectMake(0, 360+i*35, kScreen_Width, 35);
        label.textAlignment=NSTextAlignmentCenter;
        if (i==0) {
        label.font = [UIFont systemFontOfSize:14];
        label.text=@"非常抱歉";
            
        }
        else if (i==1){
        label.font = [UIFont systemFontOfSize:12];
        label.text=@"程序员正在赶来搬砖的路上";
        }
        else{
        label.font = [UIFont systemFontOfSize:14];
        label.text=@"敬请期待";
            
        }
        label.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
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
