//
//  SalesReturnReasonPopView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/12.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SalesReturnReasonPopView.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BOARD_HEIGHT stateBoard.bounds.size.height
#define BOARD_WIDTH stateBoard.bounds.size.width
@interface SalesReturnReasonManager () <PostageStateBoardDelegate>
{
    __weak SalesReturnReasonPopView *_stateBoartd;
}

@end

@implementation SalesReturnReasonManager

static SalesReturnReasonManager *_stateManager;
+ (instancetype)salesReturnReasonManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _stateManager = [SalesReturnReasonManager new];
    });
    return _stateManager;
}
- (void)showSalesReturnReasonWithStateType:(NSArray *)states
{
    if (_stateBoartd) {
        _stateBoartd = nil;
    }
    
    SalesReturnReasonPopView *stateBoard = [SalesReturnReasonPopView showStateBoardWithStateType:states];
    _stateBoartd = stateBoard;
    stateBoard.frame = [UIScreen mainScreen].bounds;
    stateBoard = stateBoard;
    stateBoard.delegate = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:stateBoard];
    
    //背景蒙层的动画：alpha值从0.0变化到0.5
    [stateBoard.bgView setAlpha:0.0];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [stateBoard.bgView setAlpha:0.5];
    } completion:^(BOOL finished) { }];
    
    //分享面板的动画：从底部向上滚动弹出来
    [stateBoard.contentView setFrame:CGRectMake(0, SCREEN_HEIGHT , BOARD_WIDTH, BOARD_HEIGHT )];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [stateBoard.contentView setFrame:CGRectMake(0,SCREEN_HEIGHT - BOARD_HEIGHT,BOARD_WIDTH,BOARD_HEIGHT)];
    } completion:^(BOOL finished) {}];
}

- (void)hiddenStateBoard
{
    if (_stateBoartd.superview) {
        [_stateBoartd removeFromSuperview];
    }
}

#pragma mark - PostageStateBoardDelegate
- (void)chooseSalesReturnReasonByBoard:(NSInteger)selectedIndex
{
    if (_delegate && [_delegate respondsToSelector:@selector(delegateForSalesReturnReasonManager:)]) {
        [_delegate delegateForSalesReturnReasonManager:selectedIndex];
    }
}

@end


/*****  PostageStateBoard  *****/
@interface SalesReturnReasonPopView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *states;//配送方式数组
@property (nonatomic, strong) NSMutableArray *selectedes; //选择按钮数组

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@end
@implementation SalesReturnReasonPopView
{
    BOOL _touchTrack;
    NSInteger selectedIndex;
    NSInteger historyselectedIndex;
}

+ (instancetype)showStateBoardWithStateType:(NSArray *)states
{
    SalesReturnReasonPopView *stateBoard = [[[UINib nibWithNibName:@"SalesReturnReasonPopView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    [stateBoard layoutTableView:states];
    return stateBoard;
}

- (void)layoutTableView:(NSArray *)states
{
    _states = [NSMutableArray new];
    _selectedes = [NSMutableArray new];
    _states = states.mutableCopy;
    selectedIndex = 0;
    historyselectedIndex = 0;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.closeBtn.layer.shadowColor = ThemeColor.CGColor;
    self.closeBtn.layer.shadowOffset = CGSizeMake(2, 2);
    self.closeBtn.layer.shadowOpacity = 0.8;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _states.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"postageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _states[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (historyselectedIndex == indexPath.row) {
        cell.textLabel.textColor = ThemeColor;
    } else {
        cell.textLabel.textColor = FirstTextColor;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    historyselectedIndex = selectedIndex;
    selectedIndex = indexPath.row;
    
    //旧的
    UITableViewCell *historyCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:historyselectedIndex inSection:0]];
    historyCell.textLabel.textColor = FirstTextColor;
    
    //新的
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    newCell.textLabel.textColor = ThemeColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

#pragma mark - close
- (IBAction)closeAction:(id)sender
{
    [self closeState];
}

- (void)closeState
{
    if (_delegate && [_delegate respondsToSelector:@selector(chooseSalesReturnReasonByBoard:)]) {
        [_delegate chooseSalesReturnReasonByBoard:selectedIndex];
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
}

static UIImage *_unSelectedDefauleAddressImage;
- (UIImage *)unSelectedDefauleAddressImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _unSelectedDefauleAddressImage = [UIImage imageNamed:@"goods_unChoose"];
    });
    return _unSelectedDefauleAddressImage;
}
static UIImage *_selectedDefauleAddressImage;
- (UIImage *)selectedDefauleAddressImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _selectedDefauleAddressImage = [UIImage imageNamed:@"ico_address"];
    });
    return _selectedDefauleAddressImage;
}

#pragma mark --- touch handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touchTrack = NO;
    UITouch* t = [touches anyObject];
    CGPoint p1 = [t locationInView:_contentView];
    if (!CGRectContainsPoint(_contentView.bounds, p1)) {
        _touchTrack = YES;
    }else{
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        [self closeState];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        [self closeState];
    }else{
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
