//
//  MywalletViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/13.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "MywalletViewController.h"
#import "WalletTableViewCell.h"
#import "TransactionViewController.h"
#import "ReamlnameViewController.h"
#import "PaymentSettingtableview.h"
#import "IntegralViewController.h"
#import "HelpCenterController.h"
#import "CostMoneysViewController.h"
@interface MywalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *wallettableview;
@property(nonatomic,strong)UIView* secondview;
@end

@implementation MywalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的钱包";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"消费记录"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(consume)];
    
     self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
   
    [self setwalletview];
}

#pragma mark - back action

-(void)setwalletview{
    UIView* walletheadview=[UIView new];
    walletheadview.frame=CGRectMake(0, 0, kScreen_Width, 220*(kScreen_Height/667));
    UIImage* image=[UIImage imageNamed:@"wallet_img"];
    walletheadview.layer.contents =(UIImage*)image.CGImage;
    [self.view addSubview:walletheadview];
    
    UILabel *scorelabel = [[UILabel alloc] init];
    scorelabel .font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    scorelabel .textColor=[UIColor whiteColor];
    scorelabel .text=@"积分";
    [walletheadview addSubview:scorelabel ];
    [scorelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(86*(kScreen_Height/667)));
        make.left.equalTo(@(45*(kScreen_Height/667)));
       
    }];
    
    UILabel *scorenumber = [[UILabel alloc] init];
    scorenumber .font = [UIFont systemFontOfSize:34*(kScreen_Height/677)];
    scorenumber .textColor=[UIColor whiteColor];
    scorenumber .text=@"102986";
    [walletheadview addSubview:scorenumber];
    [scorenumber  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scorelabel.mas_left);
        make.bottom.equalTo(@(-60*(kScreen_Height/667)));
        
    }];
    
    UIButton * rechargebtn=[[UIButton alloc]init];
    [rechargebtn setTitleColor:[UIColor colorWithHex:0xea3260] forState:UIControlStateNormal];
    [rechargebtn setTitle:@"充值" forState:UIControlStateNormal];
    rechargebtn.titleLabel.font=[UIFont systemFontOfSize:10];
    rechargebtn.layer.cornerRadius =7*kScreen_Height/667;
    rechargebtn.layer.masksToBounds=YES;
    rechargebtn.backgroundColor=[UIColor colorWithHex:0xffd6e2];
    [rechargebtn addTarget:self action:@selector(recharge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rechargebtn];
    [rechargebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scorelabel.mas_top);
        make.right.equalTo(@(-34*kScreen_Height/667));
        make.width.height.equalTo(@(39*kScreen_Height/667));
        make.height.equalTo(@(15*kScreen_Height/667));
    }];
    
    for (int i=0; i<3; i++) {
        UILabel* linecenter=[UILabel new];
        linecenter.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:linecenter];
        [linecenter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(87*(kScreen_Height/667)+i*35*(kScreen_Height/667)));
            make.left.equalTo(@((kScreen_Width/2)-0.5));
            make.width.equalTo(@0.5);
            make.height.equalTo(@(29*(kScreen_Height/667)));
        }];
    }
    
    UILabel *currency = [[UILabel alloc] init];
    currency .font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    currency .textColor=[UIColor whiteColor];
    currency .text=@"搭搭币";
    [walletheadview addSubview:currency ];
    [currency  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((kScreen_Width/2)+45*(kScreen_Height/667)));
        make.top.equalTo(scorelabel.mas_top);
        
    }];

    UILabel *currencynumber = [[UILabel alloc] init];
    currencynumber .font = [UIFont systemFontOfSize:34*(kScreen_Height/677)];
    currencynumber .textColor=[UIColor whiteColor];
    currencynumber .text=@"126548";
    [walletheadview addSubview:currencynumber];
    [currencynumber  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currency.mas_left);
        make.bottom.equalTo(@(-60*(kScreen_Height/667)));
        
    }];
    
    UIView* secondview=[UIView new];
    secondview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:secondview];
    [secondview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(walletheadview.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(98*(kScreen_Height/667)));
    }];
    _secondview=secondview;
    
    
    UIButton * storebtn=[[UIButton alloc]init];
    [storebtn setBackgroundImage:[UIImage imageNamed:@"wallet_integral"] forState:UIControlStateNormal];
    [storebtn addTarget:self action:@selector(gostore) forControlEvents:UIControlEventTouchUpInside];
    [secondview addSubview:storebtn];
    [storebtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(16*(kScreen_Height/667)));
            make.left.equalTo(@((70*(kScreen_Height/667))));
            make.width.height.equalTo(@(45*(kScreen_Height/667)));
            make.height.equalTo(@(45*(kScreen_Height/667)));
        }];
    
    UILabel *storelabel = [[UILabel alloc] init];
    storelabel.font = [UIFont systemFontOfSize:13*(kScreen_Height/677)];
    storelabel.textColor=[UIColor colorWithHex:0x333333];
    storelabel.text=@"积分商城";
    storelabel.textAlignment=NSTextAlignmentCenter;
    [secondview  addSubview:storelabel ];
    [storelabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storebtn.mas_bottom).equalTo(@(16*(kScreen_Height/667)));
        make.left.equalTo(@((71*(kScreen_Height/667))));
        
    }];
   
    UIButton * privilegebtn=[[UIButton alloc]init];
    [privilegebtn setBackgroundImage:[UIImage imageNamed:@"wallet_coupons"] forState:UIControlStateNormal];
    [privilegebtn addTarget:self action:@selector(privilege) forControlEvents:UIControlEventTouchUpInside];
    [secondview addSubview:privilegebtn];
    [privilegebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16*(kScreen_Height/667)));
        make.right.equalTo(@((-71*(kScreen_Height/667))));
        make.width.height.equalTo(@(45*(kScreen_Height/667)));
        make.height.equalTo(@(45*(kScreen_Height/667)));
    }];
    
    UILabel *privilegelabel = [[UILabel alloc] init];
    privilegelabel.font = [UIFont systemFontOfSize:13*(kScreen_Height/677)];
    privilegelabel.textColor=[UIColor colorWithHex:0x333333];
    privilegelabel.text=@"优惠卷";
    privilegelabel.textAlignment=NSTextAlignmentCenter;
    [secondview  addSubview:privilegelabel];
    [privilegelabel   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storelabel.mas_top);
        make.right.equalTo(privilegebtn.mas_right);
        
    }];
    UILabel* linetow=[[UILabel alloc]init];
    linetow.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [secondview addSubview:linetow];
    [linetow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@((kScreen_Width/2)-0.5));
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@-0);
    }];

    [self wallettableview];
    
}

#pragma mark - init tableview
- (UITableView *)wallettableview
{
    if (!_wallettableview) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled=NO;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.rowHeight=50*(kScreen_Height/667);
       [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_secondview.mas_bottom).equalTo(@(13*(kScreen_Height/667)));
            make.left.equalTo(@0);
            make.right.equalTo(@-0);
            make.height.equalTo(@(200*(kScreen_Height/667)));
        }];
        _wallettableview = tableView;
        [_wallettableview  registerClass:[WalletTableViewCell class] forCellReuseIdentifier:WalletTableViewCellIdentifier];
    }
    return _wallettableview;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletTableViewCell *cell = [WalletTableViewCell returnResueCellFormTableView:self.wallettableview indexPath:indexPath identifier:WalletTableViewCellIdentifier];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            NSLog(@"实名认证");{
            ReamlnameViewController*  reamvc=[[ReamlnameViewController alloc]init];
            [self.navigationController pushViewController:reamvc animated:YES];
            }
        break;
        case 1:{
            NSLog(@"支付设置");
            PaymentSettingtableview*  reamvc=[[PaymentSettingtableview alloc]init];
            [self.navigationController pushViewController:reamvc animated:YES];
        }
        break;
        case 2:
            NSLog(@"安全中心");
        break;
        case 3:
            NSLog(@"帮助中心");
            [self.navigationController pushViewController:[HelpCenterController new] animated:YES];
        break;
            
        default:
            break;
    }
}


-(void)recharge{
    NSLog(@"充值");
    CostMoneysViewController* cosvc=[CostMoneysViewController new];
    [self.navigationController pushViewController:cosvc animated:YES];
    
}


-(void)privilege{
    NSLog(@"优惠价");
}

-(void)gostore{
    NSLog(@"进入积分商城");
    IntegralViewController* invc=[[IntegralViewController alloc]init];
    [self.navigationController pushViewController:invc animated:YES];
}

//-(void)recharge{
//    NSLog(@"充值");
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:UIBarStyleDefault];
}
-(void)consume{
    NSLog(@"消费记录");
    TransactionViewController* rvc=[[TransactionViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
    
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
 
}


@end
