//
//  GetCouponPopView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/26.
//  Copyright © 2017年 李萍. All rights reserved.
//

/*  购物车列表领券弹出框 */
#import "GetCouponPopView.h"
#import "CouponPopViewCell.h"

#define BOARD_HEIGHT popView.bounds.size.height
#define BOARD_WIDTH popView.bounds.size.width

/***** GetCouponPopManager *****/

@interface GetCouponPopManager ()
{
    __weak GetCouponPopView *_popView;
}
@end

@implementation GetCouponPopManager

static GetCouponPopManager *_popManager;
+ (instancetype)popViewManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _popManager = [GetCouponPopManager new];
    });
    return _popManager;
}

- (void)showPopViewWithCouponData:(NSArray *)data withShopName:(NSString *)name
{
    if (_popView) {
        _popView = nil;
    }
    
    GetCouponPopView *popView = [GetCouponPopView showCouponPopViewWithData:data withShopName:name];
    _popView = popView;
    popView.frame = [UIScreen mainScreen].bounds;
    
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    
    //背景蒙层的动画：alpha值从0.0变化到0.5
    [popView.bgView setAlpha:0.0];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [popView.bgView setAlpha:0.5];
    } completion:^(BOOL finished) { }];
    
    //分享面板的动画：从底部向上滚动弹出来
    [popView.popContentView setFrame:CGRectMake(0, kScreen_Height , BOARD_WIDTH, BOARD_HEIGHT )];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [popView.popContentView setFrame:CGRectMake(0,kScreen_Height - BOARD_HEIGHT,BOARD_WIDTH,BOARD_HEIGHT)];
    } completion:^(BOOL finished) {}];
}

- (void)hiddenPopView
{
    if (_popView.superview) {
        [_popView removeFromSuperview];
    }
}

@end


/***** GetCouponPopView *****/

@interface GetCouponPopView () <UITableViewDelegate, UITableViewDataSource, CouponPopViewCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *shopNameLb;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;

@property (nonatomic, strong) NSMutableArray *couponDatas;

@end

@implementation GetCouponPopView

+ (instancetype)showCouponPopViewWithData:(NSArray *)data withShopName:(NSString *)name
{
    GetCouponPopView *popView = [[[UINib nibWithNibName:@"GetCouponPopView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    
    [popView subLayoutsWithData:data withShopName:name];
    
    return popView;
}

- (void)subLayoutsWithData:(NSArray *)data withShopName:(NSString *)name
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[CouponPopViewCell class] forCellReuseIdentifier:CouponPopViewCellIdentifier];
    
    self.quitBtn.layer.shadowColor = ThemeColor.CGColor;
    self.quitBtn.layer.shadowOffset = CGSizeMake(2, 2);
    self.quitBtn.layer.shadowOpacity = 0.8;
    
    _shopNameLb.text = name;
    _couponDatas = [[NSMutableArray alloc] initWithArray:data];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _couponDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponPopViewCell *cell = [CouponPopViewCell returnResueCellFormTableView:self.tableView indexPath:indexPath identifier:CouponPopViewCellIdentifier];
    
    cell.delegate = self;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - CouponPopViewCellDelegate
- (void)clickGetCouponAction:(CouponPopViewCell *)cell
{
//    [cell changeButtonState:YES];
}

#pragma mark - button action

- (IBAction)quitBtnAction:(UIButton *)sender {
    NSLog(@"关闭弹出框");
    
    if (self.subviews) {
        [self removeFromSuperview];
    }
}


@end
