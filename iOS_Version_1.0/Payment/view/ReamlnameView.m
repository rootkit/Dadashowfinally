//
//  ReamlnameView.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ReamlnameView.h"
@interface ReamlnameView ()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger numTimer; /**< 计数 */
@property (nonatomic, strong) NSTimer *timer; /**< 验证码定时器 */
@property(nonatomic,strong)UIButton* getcodebtn;
@property(nonatomic,strong)UIButton * surebtn;
@end
@implementation ReamlnameView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self reamlview];
        UITapGestureRecognizer *fathertap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fateherviewtap)];
        [self addGestureRecognizer:fathertap ];
        
    }
    return  self;
}


-(void)reamlview{
//    self.backgroundColor=[UIColor redColor];
    UIView* mainview=[UIView new];
    mainview.frame=CGRectMake(15, (kScreen_Height-255)/2, kScreen_Width-30, 255);
    mainview.backgroundColor=[UIColor whiteColor];
    [mainview.layer setMasksToBounds:YES];
    [mainview.layer setCornerRadius:5.0];//设置矩形四个圆角半径
    [self addSubview:mainview];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainviewtap)];
    [mainview addGestureRecognizer:tap ];
    
    UILabel *mainLabel = [[UILabel alloc] init];
    mainLabel.font = [UIFont systemFontOfSize:18*(kScreen_Height/667)];
    mainLabel.textColor=[UIColor colorWithHex:0x353434];
    mainLabel.text=@"实名认证";
    mainLabel.textAlignment=NSTextAlignmentCenter;
    [mainview addSubview:mainLabel];
    [mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@50);
    }];
   
    UILabel * bodyLabel = [[UILabel alloc] init];
    bodyLabel.textColor=[UIColor colorWithHex:0x353535];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 10.0; //设置行间距
    bodyLabel.numberOfLines=2;
    paraStyle.hyphenationFactor =0;// 设置每行的最后单词是否截断
    paraStyle.firstLineHeadIndent =0;//文本首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;//段落后面的距离
    paraStyle.headIndent = 0;//非首行文本缩进
    paraStyle.tailIndent = 0;//文本缩进（负的为右端）
    paraStyle.alignment = NSTextAlignmentLeft;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:16*(kScreen_Height/667)], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@2.0f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"本次操作需要短信确认, 校验码已发送至您的手机18888888888" attributes:dic];
    bodyLabel.attributedText = attributeStr;
    [mainview addSubview:bodyLabel];
    [bodyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainLabel.mas_bottom).equalTo(@10);
        make.left.equalTo(@23);
        make.right.equalTo(@-23);
    }];
    
    UIButton * getcodebtn= [UIButton buttonWithType:UIButtonTypeCustom];
    getcodebtn.backgroundColor=[UIColor colorWithHex:0xff4489];
    [getcodebtn setTitle:@"获取" forState:UIControlStateNormal];
    getcodebtn.titleLabel.font=[UIFont systemFontOfSize:17*(kScreen_Height/667)];
    getcodebtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [getcodebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getcodebtn addTarget:self action:@selector(getcode) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:getcodebtn];
    [getcodebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bodyLabel.mas_bottom).equalTo(@12);
        make.right.equalTo(bodyLabel.mas_right);
        make.width.equalTo(@(119*(kScreen_Height/667)));
        make.height.equalTo(@(50*(kScreen_Height/667)));
    }];
    _getcodebtn=getcodebtn;
    
    UITextField *codefield = [[UITextField alloc] init];
    codefield.backgroundColor = [UIColor colorWithHex:0xeeeeee];
    codefield.font = [UIFont systemFontOfSize:14.0f];
    codefield.textColor = [UIColor blackColor];
    [codefield addTarget:self action:@selector(textFieldDidChange:)   forControlEvents:UIControlEventEditingChanged];
    [mainview addSubview:codefield];
    [codefield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bodyLabel.mas_bottom).equalTo(@12);
        make.left.equalTo(bodyLabel.mas_left);
        make.right.equalTo(getcodebtn.mas_left).equalTo(@0);
        make.height.equalTo(@(50*(kScreen_Height/667)));
        
    }];
    
    
    UIButton * cancelbtn= [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.titleLabel.font=[UIFont systemFontOfSize:17*(kScreen_Height/667)];
    cancelbtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [cancelbtn setTitleColor:[UIColor colorWithHex:0x353535] forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:cancelbtn];
    [cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-0);
        make.left.equalTo(@0);
        make.width.equalTo(@(mainview.bounds.size.width/2));
        make.height.equalTo(@50);
    }];
    
    UIButton * surebtn= [UIButton buttonWithType:UIButtonTypeCustom];
    surebtn.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    surebtn.userInteractionEnabled=NO;
    [surebtn setTitle:@"提交" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:17*(kScreen_Height/667)];
    surebtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [surebtn setTitleColor:[UIColor colorWithHex:0x9c9c9c]  forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:surebtn];
    [surebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@-0);
        make.right.equalTo(@-0);
        make.width.equalTo(@(mainview.bounds.size.width/2));
        make.height.equalTo(@50);
    }];
    _surebtn=surebtn;
    
}
-(void)cancel{
    NSLog(@"取消");
    
}
-(void)sure{
     NSLog(@"确定");
    if (self.changeblock) {
        self.changeblock();
    }
}


-(void)textFieldDidChange :(UITextField *)textField{
    NSLog(@"%@",textField.text);
    if (textField.text.length>0) {
        [_surebtn setTitleColor:[UIColor colorWithHex:0xff337e]  forState:UIControlStateNormal];
        _surebtn.userInteractionEnabled=YES;
    }else{
        _surebtn.userInteractionEnabled=NO;
       [_surebtn setTitleColor:[UIColor colorWithHex:0x9c9c9c]  forState:UIControlStateNormal];
    }
}
-(void)getcode{
    NSLog(@"获取验证码 ");
    self.numTimer = 60;
    self.getcodebtn.enabled = NO;
    [self.getcodebtn setTitle:[NSString stringWithFormat:@"%ldS", (long)self.numTimer] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timersStart) userInfo:nil repeats:YES];
}


/**
 *  定时器的响应方式
 */
- (void)timersStart {
    
    self.numTimer--;
    [self.getcodebtn setTitle:[NSString stringWithFormat:@"%dS", (int)self.numTimer] forState:UIControlStateNormal];
    if (self.numTimer == 0) {
        
        [self.getcodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.getcodebtn.enabled = YES;
        
    }
}
-(void)dealloc{
    [self.timer invalidate];
}

-(void)fateherviewtap{
    if (self.changeblock) {
      self.changeblock();
    }
}
-(void)mainviewtap{
    NSLog(@"子视图手势");
}

@end
