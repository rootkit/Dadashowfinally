//
//  SalesReturnViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 退货退款 *****/
#import "SalesReturnViewController.h"
#import "DrawbackDetailViewController.h"

#import "SalesBackHeadView.h"
#import "SalesReturnReasonPopView.h"

@interface SalesReturnViewController () <SalesReturnReasonManagerDelegate>

@property (nonatomic, strong) SalesBackHeadView *headView;
@property (nonatomic, strong) UIView *reasonView;
@property (nonatomic, strong) UIView *amountView;
@property (nonatomic, strong) UIView *photoView;
@property (nonatomic, strong) UIButton *getBtn;

@property (nonatomic, strong) UILabel *reasonTextLb;

@end

@implementation SalesReturnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退货退款";
    self.view.backgroundColor = BackCellColor;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.reasonView];
    [self.view addSubview:self.amountView];
    [self.view addSubview:self.photoView];
    [self.view addSubview:self.getBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init

- (SalesBackHeadView *)headView
{
    if (!_headView) {
        _headView = [[SalesBackHeadView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, 97*rating)];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}

- (UIView *)reasonView
{
    if (!_reasonView) {
        _reasonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+12*rating, kScreen_Width, 60*rating)];//173
        _reasonView.backgroundColor = [UIColor whiteColor];
        [self layoutCustomReasonView];
    }
    return _reasonView;
}

- (UIView *)amountView
{
    if (!_amountView) {
        _amountView  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.reasonView.frame)+12*rating, kScreen_Width, 73*rating)];
        [self layoutCustomAmountView];
    }
    return _amountView;
}

- (UIView *)photoView
{
    if (!_photoView) {
        _photoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.amountView.frame), kScreen_Width, 130*rating)];
        _photoView.backgroundColor = [UIColor whiteColor];
        [self layoutCustomPhotoiew];
    }
    return _photoView;
}

- (UIButton *)getBtn
{
    if (!_getBtn) {
        UIButton *getBtn = [UIButton new];
        [getBtn setTitle:@"提交" forState:UIControlStateNormal];
        [getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        getBtn.titleLabel.font = [UIFont systemFontOfSize:20*rating];
        getBtn.backgroundColor = ThemeColor;
        [getBtn addTarget:self action:@selector(getPushAction) forControlEvents:UIControlEventTouchUpInside];
        getBtn.layer.cornerRadius = 5*rating;
        getBtn.layer.shadowColor = ThemeColor.CGColor;
        getBtn.layer.shadowOffset = CGSizeMake(2, 2);
        getBtn.layer.shadowOpacity = 0.57;
        [self.view addSubview:getBtn];
        self.getBtn = getBtn;
        
        [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(348*rating));
            make.height.equalTo(@(45*rating));
            make.bottom.equalTo(@(-75*rating));
            make.centerX.equalTo(self.view);
        }];
    }
    return _getBtn;
}


- (void)layoutCustomReasonView
{
    UILabel *reasonLb = [UILabel new];
    reasonLb.text = @"退款原因";
    reasonLb.textColor = InfoTextColor;
    reasonLb.font = [UIFont systemFontOfSize:13*rating];
    [self.reasonView addSubview:reasonLb];
    [reasonLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(@(12*rating));
    }];
    
    UIImage *image = [UIImage imageNamed:@"ico_sales_reason"];
    UIButton *btn = [UIButton new];
    [btn setTitle:@"请选择" forState:UIControlStateNormal];
    [btn setTitleColor:IconTextColor forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20*rating)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 85*rating, 0, 0)];
    btn.titleLabel.font = [UIFont systemFontOfSize:13*rating];
    [btn addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.reasonView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.centerY.equalTo(reasonLb);
        make.width.equalTo(@(120*rating));
    }];
    
    UILabel *reaonTextLb = [UILabel new];
    reaonTextLb.text = @"退款原因描述";
    reaonTextLb.textColor = IconTextColor;
    reaonTextLb.font = [UIFont systemFontOfSize:12*rating];
    [self.reasonView addSubview:reaonTextLb];
    [reaonTextLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(reasonLb.mas_bottom).with.offset(12*rating);
    }];
    _reasonTextLb = reaonTextLb;

}

- (void)layoutCustomAmountView
{
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [self.amountView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.top.equalTo(@(0));
        make.height.equalTo(@(36*rating));
    }];
    
    UILabel *amountLb = [UILabel new];
    amountLb.attributedText = [Util changeAttributedStrWithfrontStr:@"退款金额：" withBehindStr:@"¥168" withFrontColor:InfoTextColor withBehindColor:ThemeColor];
    amountLb.font = [UIFont systemFontOfSize:13*rating];
    [topView addSubview:amountLb];
    [amountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.centerY.equalTo(topView );
    }];
    
    UILabel *amountInfoLb = [UILabel new];
    amountInfoLb.text = @"最多¥168。00，含发货邮费¥0.00";
    amountInfoLb.textColor = IconTextColor;
    amountInfoLb.font = [UIFont systemFontOfSize:12*rating];
    [self.amountView addSubview:amountInfoLb];
    [amountInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.top.equalTo(topView.mas_bottom).with.offset(13*rating);
    }];
}

- (void)layoutCustomPhotoiew
{
    UILabel *photoTagLb = [UILabel new];
    photoTagLb.text = @"上传凭证";
    photoTagLb.textColor = InfoTextColor;
    photoTagLb.font = [UIFont systemFontOfSize:13*rating];
    [self.photoView addSubview:photoTagLb];
    [photoTagLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*rating));
        make.top.equalTo(@(12*rating));
    }];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 23, kScreen_Width, 107)];
//    bottomView.backgroundColor = ThemeColor;
    bottomView.userInteractionEnabled = YES;
    [self.photoView addSubview:bottomView];
    
    UIImage *image = [UIImage imageNamed:@"icon_sales_photo"];
    UIButton *btn = [UIButton new];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(choosePhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoTagLb.mas_bottom).with.offset(19*rating);
        make.left.equalTo(@(19*rating));
        make.width.equalTo(@(39*rating));
        make.height.equalTo(@(37*rating));
    }];
    
    UILabel *photoInfoLb = [UILabel new];
    photoInfoLb.text = @"上传凭证\n(最多3张)";
    photoInfoLb.numberOfLines = 2;
    photoInfoLb.lineBreakMode = NSLineBreakByWordWrapping;
    photoInfoLb.textAlignment = NSTextAlignmentCenter;
    photoInfoLb.textColor = [UIColor colorWithHex:0x7f7f7f];
    photoInfoLb.font = [UIFont systemFontOfSize:10*rating];
    [bottomView addSubview:photoInfoLb];
    [photoInfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.width.equalTo(@(55*rating));
        make.top.equalTo(btn.mas_bottom).with.offset(6*rating);
    }];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(77*rating+99*rating*i, 12*rating, 88*rating, 88*rating)];
        imageV.backgroundColor = DefaultImgBgColor;
        [bottomView addSubview:imageV];
        
        imageV.userInteractionEnabled = YES;
        UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(80*rating, -8*rating, 16*rating, 16*rating)];
        actionBtn.tag = i+1;
        [actionBtn setImage:[UIImage imageNamed:@"icon_sales_photoDel"] forState:UIControlStateNormal];
        [actionBtn addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:actionBtn];
    }
}

#pragma mark - choose reason
- (void)chooseAction
{
    NSLog(@"退款原因弹出框");
    SalesReturnReasonManager *popViewManager = [SalesReturnReasonManager salesReturnReasonManager];
    [popViewManager showSalesReturnReasonWithStateType:@[@"退运费", @"质量问题", @"商品与描述不符", @"发票问题", @"卖家发错货", @"其它"]];
    popViewManager.delegate = self;
}

- (void)choosePhotoAction
{
    NSLog(@"选择照片");
}


- (void)deletePhoto:(UIButton *)btn
{
    NSLog(@"删除第%ld个图片", (long)btn.tag);
}

#pragma mark - push data
- (void)getPushAction
{
    NSLog(@"提交退货退款 成功后跳转至退款详情");
    [self.navigationController pushViewController:[DrawbackDetailViewController new] animated:YES];
}

#pragma mark - SalesReturnReasonManagerDelegate

- (void)delegateForSalesReturnReasonManager:(NSInteger)selectedIndex
{
    NSString *str = @[@"退运费", @"质量问题", @"商品与描述不符", @"发票问题", @"卖家发错货", @"其它"][selectedIndex];
    _reasonTextLb.text = str;
}


@end
