//
//  DrawbackDetailViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 退款详情 ****/
#import "DrawbackDetailViewController.h"
#import "DrawBackListViewController.h"

#define rating kScreen_Width/375
@interface DrawbackDetailViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *InfoView;

@end

@implementation DrawbackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退款详情";
    self.view.backgroundColor = BackCellColor;
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.InfoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - init

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, 254*rating)];
        _headerView.backgroundColor = [UIColor whiteColor];
        [self layoutCustomHeadView];
    }
    return _headerView;
}

- (UIView *)InfoView
{
    if (!_InfoView) {
        _InfoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)+12*rating, kScreen_Width, 250*rating)];
        _InfoView.backgroundColor = [UIColor whiteColor];
        [self layoutCustomInfoView];
    }
    return _InfoView;
}

- (void)layoutCustomHeadView
{
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100*rating)];
    [self layerForCycleScrollViewTitle:headview];
    [_headerView addSubview:headview];
    
    UILabel *statelabel = [UILabel new];
    statelabel.text = @"请等待商家处理";
    statelabel.font = [UIFont systemFontOfSize:15*rating];
    statelabel.textColor = [UIColor whiteColor];
    [headview addSubview:statelabel];
    [statelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(32*rating));
        make.left.equalTo(@(40*rating));
    }];
    
    UILabel *reasonlabel = [UILabel new];
    reasonlabel.text = @"还剩1天23时48分";
    reasonlabel.font = [UIFont systemFontOfSize:11*rating];
    reasonlabel.textColor = [UIColor whiteColor];
    [headview addSubview:reasonlabel];
    [reasonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(statelabel.mas_bottom).equalTo(@(9*rating));
        make.left.equalTo(statelabel.mas_left);
    }];
    
    UILabel *infoOneLb = [UILabel new];
    infoOneLb.text = @"您已成功发起退款申请，请耐心等待商家处理";
    infoOneLb.font = [UIFont systemFontOfSize:12*rating];
    infoOneLb.textColor = InfoTextColor;
    [_headerView addSubview:infoOneLb];
    [infoOneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headview.mas_bottom).equalTo(@(9*rating));
        make.left.equalTo(@(12*rating));
    }];
    
    UILabel *infoLine = [UILabel new];
    infoLine.backgroundColor = BackCellColor;
    [_headerView addSubview:infoLine];
    [infoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(infoOneLb.mas_bottom).with.offset(7*rating);
        make.right.equalTo(@(-12*rating));
        make.height.equalTo(@(0.5));
    }];
    
    UIView *point1 = [UIView new];
    point1.backgroundColor = [UIColor colorWithHex:0xc5c3c3];
    point1.layer.cornerRadius = 3*rating;
    [_headerView addSubview:point1];
    [point1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*rating));
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(6*rating));
    }];
    
    UILabel *point1InfoLb = [UILabel new];
    point1InfoLb.text = @"商家同意或者超时未处理，系统将退款给你";
    point1InfoLb.textColor = [UIColor colorWithHex:0xc5c3c3];
    point1InfoLb.font = [UIFont systemFontOfSize:11*rating];
    [_headerView addSubview:point1InfoLb];
    [point1InfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(point1.mas_right).with.offset(4*rating);
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(infoLine.mas_bottom).with.offset(7*rating);
        make.centerY.equalTo(point1);
    }];
    
    UIView *point2 = [UIView new];
    point2.layer.cornerRadius = 3*rating;
    point2.backgroundColor = [UIColor colorWithHex:0xc5c3c3];
    [_headerView addSubview:point2];
    [point2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(point1.mas_left);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(6*rating));
    }];
    
    UILabel *point2InfoLb = [UILabel new];
    point2InfoLb.text = @"如果商家拒绝，您可以修改退款申请后再次发起，商家会重新处理";
    point2InfoLb.textColor = [UIColor colorWithHex:0xc5c3c3];
    point2InfoLb.font = [UIFont systemFontOfSize:11*rating];
    [_headerView addSubview:point2InfoLb];
    [point2InfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(point1InfoLb.mas_left);
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(point1InfoLb.mas_bottom).with.offset(7*rating);
        make.centerY.equalTo(point2);
    }];
    
    UIButton *editBtn = [UIButton new];
    [editBtn setTitle:@"修改申请" forState:UIControlStateNormal];
    [editBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:13*rating];
    [editBtn handleBoardWidth:1 andBorderColor:ThemeColor];
    [editBtn addTarget:self action:@selector(editPostAction) forControlEvents:UIControlEventTouchUpInside];
    editBtn.layer.cornerRadius = 4*rating;
    editBtn.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(point2InfoLb.mas_bottom).with.offset(7*rating);
        make.right.equalTo(@(-12*rating));
        make.width.equalTo(@(80*rating));
        make.height.equalTo(@(27*rating));
    }];
    
    UILabel *bottomLine = [UILabel new];
    bottomLine.backgroundColor = BackCellColor;
    [_headerView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(editBtn.mas_bottom).with.offset(9*rating);
        make.right.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *historyInfoLb = [UILabel new];
    historyInfoLb.text = @"协商历史";
    historyInfoLb.textColor = InfoTextColor;
    historyInfoLb.font = [UIFont systemFontOfSize:12*rating];
    [_headerView addSubview:historyInfoLb];
    [historyInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(bottomLine.mas_bottom).with.offset(9*rating);
    }];
    
    UIButton *pushActionBtn = [UIButton new];
    [pushActionBtn addTarget:self action:@selector(pushToHistoryInfoAction) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:pushActionBtn];
    [pushActionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(bottomLine.mas_bottom);
        make.bottom.equalTo(_headerView.mas_bottom);
        make.width.equalTo(@(100*rating));
    }];
    
    UIImageView *pushImg = [UIImageView new];
    pushImg.image = [UIImage imageNamed:@"ico_push"];
    [pushActionBtn addSubview:pushImg];
    [pushImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-12*rating));
        make.centerY.equalTo(pushActionBtn);
        make.width.equalTo(@(6*rating));
        make.height.equalTo(@(12*rating));
    }];
}

- (void)layoutCustomInfoView
{
    //// 1
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30*rating)];
    [_InfoView addSubview:titleView];
    
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"退款信息";
    titleLb.textColor = InfoTextColor;
    titleLb.font = [UIFont systemFontOfSize:12*rating];
    [titleView addSubview:titleLb];
    [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.centerY.equalTo(titleView);;
    }];
    
    //// 2
    UIView *orderDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), kScreen_Width, 96*rating)];
    orderDetailView.backgroundColor = BackCellColor;
    [_InfoView addSubview:orderDetailView];
    
    UIImageView *goodsImg = [UIImageView new];
    goodsImg.backgroundColor = DefaultImgBgColor;
    [goodsImg handleCornerRadiusWithRadius:3*rating];
    [orderDetailView addSubview:goodsImg];
    [goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.centerY.equalTo(orderDetailView);
        make.width.equalTo(@(70*rating));
        make.height.equalTo(@(70*rating));
    }];
    
    UILabel *goodsNameLb = [UILabel new];
    goodsNameLb.textColor = FirstTextColor;
    goodsNameLb.text = @"乐町2017夏季新款女装绿色短款刺绣宽松短袖T恤女夏韩版纯色上衣";
    goodsNameLb.font = [UIFont systemFontOfSize:12*rating];
    goodsNameLb.numberOfLines = 0;
    goodsNameLb.lineBreakMode = NSLineBreakByWordWrapping;
    [orderDetailView addSubview:goodsNameLb];
    [goodsNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsImg.mas_right).with.offset(12*rating);
        make.top.equalTo(goodsImg.mas_top);
        make.right.equalTo(@(-12*rating));
    }];
    
    UILabel *detailInfoLb = [UILabel new];
    detailInfoLb.text = @"颜色：橙色； 尺码：M";
    detailInfoLb.font = [UIFont systemFontOfSize:12*rating];
    detailInfoLb.textColor = IconTextColor;
    [orderDetailView addSubview:detailInfoLb];
    [detailInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsNameLb.mas_bottom).with.offset(10*rating);
        make.left.equalTo(goodsNameLb.mas_left);
        make.right.equalTo(goodsNameLb.mas_right);
    }];
    
    //// 3
    UIView *orderInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderDetailView.frame), kScreen_Width, 80*rating)];
    [_InfoView addSubview:orderInfoView];
    
    UILabel *orderNumLb = [UILabel new];
    orderNumLb.text = @"订单编号：1064793483978938900";
    orderNumLb.textColor = [UIColor colorWithHex:0x949393];
    orderNumLb.font = [UIFont systemFontOfSize:11*rating];
    [orderInfoView addSubview:orderNumLb];
    [orderNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.right.equalTo(@(-12*rating));
        make.top.equalTo(orderDetailView.mas_bottom).with.offset(12*rating);
    }];
    
    UILabel *dadaNumLb = [UILabel new];
    dadaNumLb.text = @"搭搭交易号：129432943829024";
    dadaNumLb.textColor = [UIColor colorWithHex:0x949393];
    dadaNumLb.font = [UIFont systemFontOfSize:11*rating];
    [orderInfoView addSubview:dadaNumLb];
    [dadaNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderNumLb.mas_left);
        make.right.equalTo(orderNumLb.mas_right);
        make.top.equalTo(orderNumLb.mas_bottom).with.offset(9*rating);
    }];
    
    UILabel *timeLb = [UILabel new];
    timeLb.text = @"创建时间：2017-05-05 19:30:16";
    timeLb.textColor = [UIColor colorWithHex:0x949393];
    timeLb.font = [UIFont systemFontOfSize:11*rating];
    [orderInfoView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderNumLb.mas_left);
        make.right.equalTo(orderNumLb.mas_right);
        make.top.equalTo(dadaNumLb.mas_bottom).with.offset(9*rating);
    }];
    
    UIView *infoLine = [UIView new];
    infoLine.backgroundColor = BackCellColor;
    [orderInfoView addSubview:infoLine];
    [infoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(@(0.5));
    }];
    
    //// 4
    UIView *actionView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(orderInfoView.frame), kScreen_Width, 44*rating)];
    [_InfoView addSubview:actionView];
    
    UILabel *hLine = [UILabel new];
    hLine.backgroundColor = BackCellColor;
    [actionView addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(0.5));
        make.centerX.equalTo(actionView);
    }];
    
    UIButton *leftBtn = [UIButton new];
    [actionView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(clickcontact) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.right.equalTo(hLine.mas_left);
    }];
    
    UIButton *rightBtn = [UIButton new];
    [actionView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clickcall) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hLine.mas_right);
        make.top.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(0));
    }];
    
    //
    UIImageView *contactIcon = [UIImageView new];
    contactIcon.image = [UIImage imageNamed:@"联系卖家图标"];
    [leftBtn addSubview:contactIcon];
    [contactIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftBtn);
        make.left.equalTo(@(53*rating));
        make.width.equalTo(@(26*rating));
        make.height.equalTo(@(26*rating));
    }];
    
    //
    UILabel* contactlabel = [UILabel new];
    contactlabel.text = @"联系卖家";
    contactlabel.font = [UIFont systemFontOfSize:12*rating];
    contactlabel.textColor = InfoTextColor;
    [leftBtn addSubview:contactlabel];
    [contactlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftBtn);
        make.left.equalTo(contactIcon.mas_right).equalTo(@(7*rating));
    }];
    //////
    //
    UILabel* callphone = [UILabel new];
    callphone.text = @"拨打电话";
    callphone.font = [UIFont systemFontOfSize:12*rating];
    callphone.textColor = InfoTextColor;
    [rightBtn addSubview:callphone];
    [callphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(actionView);
        make.right.equalTo(@(-53*rating));
    }];
    //
    UIImageView *callphoneIcon = [UIImageView new];
    callphoneIcon.image = [UIImage imageNamed:@"拨打电话图标"];
    [rightBtn addSubview:callphoneIcon];
    [callphoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(actionView);
        make.right.equalTo(callphone.mas_left).equalTo(@(-8*rating));
        make.width.equalTo(@(26*rating));
        make.height.equalTo(@(26*rating));
    }];
}

#pragma mark - 渐变色

- (void)layerForCycleScrollViewTitle:(UIView *)bottomView
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[
                     (__bridge id)[UIColor colorWithHex:0xff116a].CGColor,
                     (__bridge id)[UIColor colorWithHex:0xfe4f90].CGColor,
                     ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = bottomView.bounds;
    
    [bottomView.layer addSublayer:layer];
}

#pragma mark - action
- (void)editPostAction
{
    NSLog(@"修改申请");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushToHistoryInfoAction
{
    NSLog(@"查看协商历史");
    
    [self.navigationController pushViewController:[DrawBackListViewController new] animated:YES];
}

-(void)clickcontact{
    
    NSLog(@"联系买家");
    
}

-(void)clickcall{
    
    NSLog(@"拨打电话");
    
}

@end
