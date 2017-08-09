//
//  DrawBackListViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

/**** 协商退货退款 ****/
#import "DrawBackListViewController.h"
#import "SalesReturnViewController.h"

#import "DrawbackPostCell.h"
#import "DrawbackDealCell.h"
#import "DrawbackPostTwoCell.h"
#import "DrawbackSuccessCell.h"

#define rating kScreen_Width/375
#define bottomView_height 50*rating
@interface DrawBackListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DrawBackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"协商退货退款";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.tableView registerClass:[DrawbackPostCell class] forCellReuseIdentifier:DrawbackPostCellIdentifier];
    [self.tableView registerClass:[DrawbackDealCell class] forCellReuseIdentifier:DrawbackDealCellIdentifier];
    [self.tableView registerClass:[DrawbackPostTwoCell class] forCellReuseIdentifier:DrawbackPostTwoCellIdentifier];
    [self.tableView registerClass:[DrawbackSuccessCell class] forCellReuseIdentifier:DrawbackSuccessCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            DrawbackPostCell *postCell = [DrawbackPostCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:DrawbackPostCellIdentifier];

            DrawbackModel *model = [DrawbackModel new];
            model.stateStr = @"买家发起了申请";
            model.info = @"发起了退货退款申请，货物状态：已发货，原因：未按照约定的物品详情发货，金额168.00元。";
            postCell.model = model;
            postCell.popColor = [UIColor colorWithHex:0xefefef];
            postCell.textAndBgColor = SecondTextColor;
            
            return postCell;
        }
            break;
        case 1:
        {
            DrawbackDealCell *dealCell = [DrawbackDealCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:DrawbackDealCellIdentifier];
            
            return dealCell;
        }
            break;
        case 2:
        {
            DrawbackPostCell *postCell = [DrawbackPostCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:DrawbackPostCellIdentifier];
            
            DrawbackModel *model = [DrawbackModel new];
            model.stateStr = @"卖家同意了申请";
            model.info = @"卖家同意了本次退货退款申请";
            postCell.model = model;
            postCell.popColor = [UIColor colorWithHex:0x62b1e8];
            postCell.textAndBgColor = [UIColor whiteColor];
            
            return postCell;
        }
            break;
        case 3:
        {
            DrawbackPostTwoCell *postTwoCell = [DrawbackPostTwoCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:DrawbackPostTwoCellIdentifier];
            
            return postTwoCell;
        }
            break;
        case 4:
        {
            DrawbackSuccessCell *successCell = [DrawbackSuccessCell returnReuseCellFormTableView:tableView indexPath:indexPath identifier:DrawbackSuccessCellIdentifier];
            
            return successCell;
        }
            break;
            
        default:
            break;
    }
    
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 25*rating)];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    UIView *centerView = [UIView new];
    centerView.backgroundColor = BackCellColor;
    centerView.layer.cornerRadius = 3*rating;
    [sectionView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.centerX.equalTo(sectionView);
        make.height.equalTo(@(13*rating));
        make.width.equalTo(@(100*rating));
    }];
    
    UILabel *timeLb = [UILabel new];
    timeLb.text = @"2017-06-17 11:17";
    timeLb.textAlignment = NSTextAlignmentCenter;
    timeLb.textColor = [UIColor colorWithHex:0xb6b6b6];
    timeLb.font = [UIFont systemFontOfSize:10*rating];
    timeLb.layer.cornerRadius = 3*rating;
    [centerView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.centerX.equalTo(centerView);
        make.height.equalTo(@(13*rating));
        make.width.equalTo(@(100*rating));
    }];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:12*rating];
    CGFloat heigth = 0;
    switch (indexPath.section) {
        case 0:
        {
            label.text = @"发起了退货退款申请，货物状态：已发货，原因：未按照约定的物品详情发货，金额168.00元。";
            heigth = (CGFloat)[label.text boundingRectWithSize:(CGSize){(kScreen_Width - 48*rating), MAXFLOAT}
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12*rating]}
                                                       context:nil].size.height;
            
            return 81*rating+heigth;
        }
            break;
        case 1:
            label.text = @"如卖家在05天23时59分内未处理，申请将自动达成，请按照系统给出的地址退货";
            heigth = (CGFloat)[label.text boundingRectWithSize:(CGSize){(kScreen_Width - 48*rating), MAXFLOAT}
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12*rating]}
                                                       context:nil].size.height;
            return 174*rating+heigth;
            break;
        case 2:
            return 83*rating;
            break;
        case 3:
            return 47*rating;
            break;
        case 4:
            return 142*rating;
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25*rating;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - init
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-bottomView_height)
                                                  style:UITableViewStyleGrouped];
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [view handleShadowOffset:CGSizeMake(8, 2) shadowColor:[UIColor colorWithHex:0xb6b6b6] shadowOpacity:0.7];
        [self.view addSubview:view];
        _bottomView = view;
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.bottom.equalTo(@(0));
            make.height.equalTo(@(bottomView_height));
        }];
        
        [self layoutCustomBottomButton];
    }
    return _bottomView;
}

#pragma mark - layout 

- (void)layoutCustomBottomButton
{
    UIButton *editBtn = [UIButton new];
    [editBtn setTitleColor:[UIColor colorWithHex:0xb6b6b6] forState:UIControlStateNormal];
    [editBtn setTitle:@"修改申请" forState:UIControlStateNormal];
    editBtn.layer.cornerRadius = 3;
    editBtn.titleLabel.font = [UIFont systemFontOfSize:12*rating];
    [editBtn handleBoardWidth:1 andBorderColor:[UIColor colorWithHex:0xb6b6b6]];
    [editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:editBtn];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(24*rating));
        make.width.equalTo(@(75*rating));
        make.height.equalTo(@(30*rating));
        make.centerY.equalTo(_bottomView);
    }];
    
    UIButton *removeBtn = [UIButton new];
    [removeBtn setTitleColor:[UIColor colorWithHex:0xb6b6b6] forState:UIControlStateNormal];
    [removeBtn setTitle:@"撤销申请" forState:UIControlStateNormal];
    removeBtn.layer.cornerRadius = 3;
    removeBtn.titleLabel.font = [UIFont systemFontOfSize:12*rating];
    [removeBtn handleBoardWidth:1 andBorderColor:[UIColor colorWithHex:0xb6b6b6]];
    [removeBtn addTarget:self action:@selector(removeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:removeBtn];
    
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(75*rating));
        make.height.equalTo(@(30*rating));
        make.centerY.equalTo(_bottomView);
        make.centerX.equalTo(_bottomView);
    }];
    
    UIButton *getBtn = [UIButton new];
    [getBtn setTitleColor:[UIColor colorWithHex:0xb6b6b6] forState:UIControlStateNormal];
    [getBtn setTitle:@"申请介入" forState:UIControlStateNormal];
    getBtn.layer.cornerRadius = 3;
    getBtn.titleLabel.font = [UIFont systemFontOfSize:12*rating];
    [getBtn handleBoardWidth:1 andBorderColor:[UIColor colorWithHex:0xb6b6b6]];
    [getBtn addTarget:self action:@selector(getBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:getBtn];
    
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-24*rating));
        make.width.equalTo(@(75*rating));
        make.height.equalTo(@(30*rating));
        make.centerY.equalTo(_bottomView);
    }];
}

#pragma mark - action

- (void)editBtnAction
{
    NSLog(@"修改申请");
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[SalesReturnViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        } else {
            [self.navigationController pushViewController:[SalesReturnViewController new] animated:YES];
        }
    }
}

- (void)removeBtnAction
{
    NSLog(@"撤销申请");
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否取消申请" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)getBtnAction
{
    NSLog(@"申请介入");
}

@end
