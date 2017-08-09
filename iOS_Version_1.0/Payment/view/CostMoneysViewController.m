//
//  CostMoneysViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "CostMoneysViewController.h"
#define moneybtnwith (kScreen_Width-54*(kScreen_Width/375))/4
@interface CostMoneysViewController ()
@property(nonatomic,strong)UIButton * moneykindbtn;
@property(nonatomic,strong)UIButton* threechangebtn;
@property(nonatomic,strong)UILabel* moneycolorlabel;
@property(nonatomic,strong)UILabel* ertracolorlabel;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *moneyArray;
@property (nonatomic, strong) NSMutableArray *extraArray;
@property(nonatomic,strong)UILabel *amountnumber;
@end

@implementation CostMoneysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"充值";
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self buttonArray];
    [self moneyArray];
    [self extraArray];
    [self setcostview];
}

#pragma mark - init
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)moneyArray
{
    if (!_moneyArray) {
        _moneyArray = [NSMutableArray array];
    }
    return _moneyArray;
}

- (NSMutableArray *)extraArray
{
    if (!_extraArray) {
        _extraArray = [NSMutableArray array];
    }
    return _extraArray;
}


-(void)setcostview{
    
    UIView* activityview=[[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, 80*(kScreen_Height/677))];
    activityview.backgroundColor=DefaultImgBgColor ;
    [self.view addSubview:activityview];
    
    UIView* optionview=[[UIView alloc]initWithFrame:CGRectMake(0, 80*(kScreen_Height/677)+64, kScreen_Width, 227*(kScreen_Height/677))];
    optionview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:optionview];
    
    UILabel *amountlabel = [[UILabel alloc] init];
    amountlabel.font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    amountlabel.textColor=[UIColor colorWithHex:0xa6a6a6];
    amountlabel.text=@"充值金额";
    [optionview addSubview:amountlabel];
    [amountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*(kScreen_Height/677)));
        make.top.equalTo(@(15*(kScreen_Height/677)));
    }];

    for (int i=0; i<8; i++) {
        UIButton * moneykindbtn=[[UIButton alloc]init];
        [moneykindbtn addTarget:self action:@selector(gotorecharge:) forControlEvents:UIControlEventTouchUpInside];
        moneykindbtn.layer.cornerRadius=5*(kScreen_Height/677);
        moneykindbtn.layer.masksToBounds=YES;
        moneykindbtn.layer.borderColor=[UIColor colorWithHex:0xa6a6a6].CGColor;
        moneykindbtn.layer.borderWidth=1.0*(kScreen_Height/677);
       [moneykindbtn setTag:i+100];
        [optionview addSubview:moneykindbtn];
        if (i<4) {
            [moneykindbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(amountlabel.mas_bottom).equalTo(@(15*(kScreen_Height/677)));
                make.left.equalTo(@(12*(kScreen_Width/375)+(moneybtnwith+10*(kScreen_Width/375))*i));
                make.height.equalTo(@(60*(kScreen_Height/677)));
                make.width.equalTo(@(moneybtnwith));
            }];
        }else{
            [moneykindbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(amountlabel.mas_bottom).equalTo(@(90*(kScreen_Height/677)));
                make.left.equalTo(@(12*(kScreen_Width/375)+(moneybtnwith+10*(kScreen_Width/375))*(i-4)));
                make.height.equalTo(@(60*(kScreen_Height/677)));
                make.width.equalTo(@(moneybtnwith));
            }];
      
        }
        _moneykindbtn=moneykindbtn;
        [_buttonArray addObject:_moneykindbtn];

        UILabel* moneylabel=[UILabel new];
        moneylabel.frame=CGRectMake(0, 0, moneybtnwith, 40*(kScreen_Height/677));
        moneylabel.font = [UIFont systemFontOfSize:17*(kScreen_Height/677)];
        moneylabel.textColor=[UIColor colorWithHex:0x737373];
        moneylabel.textAlignment=NSTextAlignmentCenter;
        moneylabel.backgroundColor=[UIColor clearColor];
        [moneylabel setTag:i+100];
        [moneykindbtn addSubview:moneylabel];
        [self.moneyArray addObject:moneylabel];

        
        UILabel* extramoney=[UILabel new];
        extramoney.font = [UIFont systemFontOfSize:9*(kScreen_Height/677)];
        extramoney.textColor=[UIColor colorWithHex:0xf30867];
        extramoney.textAlignment=NSTextAlignmentCenter;
        extramoney.backgroundColor=[UIColor clearColor];
        [extramoney setTag:i+100];
        [moneykindbtn addSubview:extramoney];
        [extramoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moneylabel.mas_bottom).equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(@(moneybtnwith));
        }];
        [self.extraArray addObject:extramoney];
        
        switch (i) {
            case 0:
                moneylabel.text=@"6元";
                extramoney.text=@"赠送12搭搭币";
                break;
            case 1:
                moneylabel.text=@"18元";
                extramoney.text=@"赠送36搭搭币";
                break;
            case 2:
                moneylabel.text=@"25元";
                extramoney.text=@"赠送50搭搭币";
                break;
            case 3:
                moneylabel.text=@"50元";
                extramoney.text=@"赠送150搭搭币";
                break;
            case 4:
                moneylabel.text=@"98元";
                extramoney.text=@"赠送294搭搭币";
                break;
            case 5:
                moneylabel.text=@"168元";
                extramoney.text=@"赠送672搭搭币";
                break;
            case 6:
                moneylabel.text=@"328元";
                extramoney.text=@"赠送1312搭搭币";
                break;
            case 7:
                moneylabel.text=@"648元";
                extramoney.text=@"赠送3240搭搭币";
                break;
            default:
                break;
        }
 
}
    
    //富文本
    UILabel *amountnumber = [[UILabel alloc] init];
    amountnumber.font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    amountnumber.textColor=[UIColor colorWithHex:0xfc5c98];
    amountnumber.textAlignment=NSTextAlignmentLeft;
    [optionview addSubview:amountnumber];
    amountnumber.attributedText=[self setnewattstr:@"0"];
    [amountnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-15*(kScreen_Height/677)));
        make.right.equalTo(@(-12*(kScreen_Height/677)));
    }];
    _amountnumber=amountnumber;
    
    UIButton * nextstepbtn=[[UIButton alloc]init];
    [nextstepbtn setBackgroundImage:[UIImage imageNamed:@"wallet_btn"] forState:UIControlStateNormal];
    [nextstepbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextstepbtn setTitle:@"确定" forState:UIControlStateNormal];
    [nextstepbtn addTarget:self action:@selector(nextstep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextstepbtn];
    [nextstepbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(optionview.mas_bottom).equalTo(@(25*(kScreen_Height/677)));
        make.left.equalTo(@(38*(kScreen_Height/677)));
        make.right.height.equalTo(@(-38*(kScreen_Height/677)));
        make.height.equalTo(@(45*(kScreen_Height/677)));
    }];
}

-(void)gotorecharge:(UIButton*)btn{
  
    NSLog(@"%ld",(long)btn.tag);
    
    [self.threechangebtn setBackgroundColor:[UIColor whiteColor]];
    self.threechangebtn=self.buttonArray[btn.tag-100];
    [self.threechangebtn setBackgroundColor:[UIColor colorWithHex:0xf30867]];
    
    self.moneycolorlabel.textColor=[UIColor colorWithHex:0x737373];
    self.moneycolorlabel=self.moneyArray[btn.tag-100];
    self.moneycolorlabel.textColor=[UIColor whiteColor];
    
    self.ertracolorlabel.textColor=[UIColor colorWithHex:0xf30867];
    self.ertracolorlabel=self.extraArray[btn.tag-100];
    self.ertracolorlabel.textColor=[UIColor whiteColor];
    
    switch (btn.tag-100) {
        case 0:
        {
            NSString* number=@"600";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            break;
        case 1:
        {
            NSString* number=@"1800";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            break;
        case 2:
        {
            NSString* number=@"2500";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            
            break;
        case 3:
        {
            NSString* number=@"5000";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            
            break;
        case 4:
        {
            NSString* number=@"9800";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            
            break;
        case 5:
        {
            NSString* number=@"16800";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            
            break;
        case 6:
        {
            NSString* number=@"32800";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            
            break;
        case 7:
        {
            NSString* number=@"64800";
            _amountnumber.attributedText=[self setnewattstr:number];
        }
            
            break;
        default:
            break;
    }

}

-(NSMutableAttributedString*)setnewattstr:(NSString*)conststr{
   
      NSString* dadanumber=@"搭币数量:";
      NSString*praisestr = [NSString stringWithFormat:@"%@ %@ 搭币",dadanumber,conststr];
      NSMutableAttributedString *costattrDescribeStr = [[NSMutableAttributedString alloc] initWithString:praisestr];
      [costattrDescribeStr addAttribute:NSForegroundColorAttributeName
     
                                value:[UIColor colorWithHex:0x737373]
     
                                range:[praisestr  rangeOfString:dadanumber]];
    
      [costattrDescribeStr addAttribute:NSFontAttributeName
     
                                value:[UIFont systemFontOfSize:18*(kScreen_Height/677)]
     
                                range:[praisestr  rangeOfString:conststr]];
  
    
    return costattrDescribeStr;

}


-(void)nextstep{
    NSLog(@"确定充值");
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
