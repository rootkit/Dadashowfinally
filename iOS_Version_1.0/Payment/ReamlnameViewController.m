//
//  ReamlnameViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ReamlnameViewController.h"
#import "UIColor+CustomColor.h"
#import "ReamlnameView.h"
@interface ReamlnameViewController ()
@property(nonatomic,strong)ReamlnameView* review;

@end

@implementation ReamlnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"实名认证";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithHex:0x353535]}];
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self reamlnameveiw];
}

#pragma mark - info

-(void)reamlnameveiw{
    UIView* messageview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, 48)];
    messageview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self.view addSubview:messageview];
    
    UIImageView* mainimage=[[UIImageView alloc]init];
    mainimage.image=[UIImage imageNamed:@"certification_name"];
    mainimage.frame=CGRectMake(12, 14, 19, 19);
    [messageview addSubview:mainimage];
    
    UILabel *safetylabel = [[UILabel alloc] init];
    safetylabel .font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    safetylabel .textColor=[UIColor colorWithHex:0x747474];
    safetylabel .text=@"为了保障您的账户安全,请完善您的个人信息！";
    [messageview addSubview:safetylabel ];
    [safetylabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(mainimage.mas_right).equalTo(@7);
        make.right.equalTo(@-0);
        make.bottom.equalTo(@-0);
    }];
    
    
    UIView* writeview=[[UIView alloc]initWithFrame:CGRectMake(0, 112, kScreen_Width, 111)];
    writeview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:writeview];
    
    UITextField* nametextfield=[[UITextField alloc]init];
    UIImageView* leftimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 16, 16, 16)];
    leftimage.image=[UIImage imageNamed:@"certification_name"];
    nametextfield.leftView=leftimage;
    nametextfield.leftViewMode = UITextFieldViewModeAlways;
    nametextfield.font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    nametextfield.tintColor = [UIColor themeColor];
    nametextfield.placeholder=@"请输入您的真实姓名";
    [nametextfield setValue:[NSNumber numberWithInt:16] forKey:@"paddingLeft"];
    nametextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
//    nametextfield.backgroundColor=[UIColor greenColor];
    [writeview addSubview:nametextfield];
    [nametextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.equalTo(@12);
        make.right.equalTo(@0);
        make.height.equalTo(@55);
    }];
    
//    //中间横线
    UILabel* label=[UILabel new];
    label.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [writeview addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nametextfield.mas_bottom).equalTo(@1);
        make.right.equalTo(@-0);
        make.height.equalTo(@1);
        make.left.equalTo(@0);
    
    }];
    
    UITextField* accounttextfield=[[UITextField alloc]init];
    UIImageView* leftaccount=[[UIImageView alloc]initWithFrame:CGRectMake(0, 16, 16, 16)];
    leftaccount.image=[UIImage imageNamed:@"certification_identity"];
    accounttextfield.leftView=leftaccount;
    accounttextfield.leftViewMode = UITextFieldViewModeAlways;
    accounttextfield.font = [UIFont systemFontOfSize:14];
    accounttextfield.tintColor = [UIColor themeColor];
    accounttextfield.placeholder=@"请输入您的身份证号";
    [accounttextfield setValue:[NSNumber numberWithInt:16] forKey:@"paddingLeft"];
    accounttextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [writeview addSubview:accounttextfield];
    [accounttextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).equalTo(@0);
        make.left.equalTo(@12);
        make.right.equalTo(@0);
        make.height.equalTo(@54);
    }];
    
    UIButton * nextstepbtn=[[UIButton alloc]init];
    [nextstepbtn setBackgroundImage:[UIImage imageNamed:@"wallet_btn"] forState:UIControlStateNormal];
    [nextstepbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextstepbtn setTitle:@"下一步" forState:UIControlStateNormal];

    [nextstepbtn addTarget:self action:@selector(nextstep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextstepbtn];
    [nextstepbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accounttextfield.mas_bottom).equalTo(@25);
        make.left.equalTo(@38);
        make.right.height.equalTo(@-38);
        make.height.equalTo(@45);
    }];

    
}
-(void)nextstep{
    NSLog(@"下一步");
    _review=[ReamlnameView new];
    _review.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.review];
    [self.review setNeedsLayout];

    [UIView animateWithDuration:0.005 animations:^{
        self.review.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.review.backgroundColor=[UIColor blackColor];
        self.review.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self.view setNeedsLayout];
          
      } completion:^(BOOL finished) {
          NSLog(@"%ld",(long)finished);
       
      }];
    __weak __typeof(self)weakSelf = self;
    self.review.changeblock=^(){
        NSLog(@"点击空白处 ");
        [weakSelf.review removeFromSuperview];
    };

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
