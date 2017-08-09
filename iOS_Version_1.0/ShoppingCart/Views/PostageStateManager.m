//
//  PostageStateManager.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "PostageStateManager.h"
#import "UIColorHF.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define BOARD_HEIGHT stateBoard.bounds.size.height
#define BOARD_WIDTH stateBoard.bounds.size.width
@interface PostageStateManager () <PostageStateBoardDelegate>
{
    __weak PostageStateBoard *_stateBoartd;
}

@end

@implementation PostageStateManager

static PostageStateManager *_stateManager;
+ (instancetype)postagestateManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _stateManager = [PostageStateManager new];
    });
    return _stateManager;
}
- (void)showPostageStateWithStateType:(NSArray *)states
{
    if (_stateBoartd) {
        _stateBoartd = nil;
    }
    
    PostageStateBoard *stateBoard = [PostageStateBoard showStateBoardWithStateType:states];
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
- (void)choosePostageByBoard:(NSInteger)selectedIndex
{
    if (_delegate && [_delegate respondsToSelector:@selector(delegateForPostageManeger:)]) {
        [_delegate delegateForPostageManeger:selectedIndex];
    }
}

@end


/*****  PostageStateBoard  *****/
@interface PostageStateBoard () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *states;//配送方式数组
@property (nonatomic, strong) NSMutableArray *selectedes; //选择按钮数组

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@end
@implementation PostageStateBoard
{
    BOOL _touchTrack;
    NSInteger selectedIndex;
}

+ (instancetype)showStateBoardWithStateType:(NSArray *)states
{
    PostageStateBoard *stateBoard = [[[UINib nibWithNibName:@"PostageStateBoard" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    [stateBoard layoutTableView:states];
    return stateBoard;
}

- (void)layoutTableView:(NSArray *)states
{
    _states = [NSMutableArray new];
    _selectedes = [NSMutableArray new];
    _states = states.mutableCopy;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.bounces = NO;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _states[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = FirstTextColor;
    
    UIButton *imageView = [UIButton new];
    imageView.frame = CGRectMake(0, 0, 19, 19);
    imageView.tag = indexPath.row;
    [imageView setImage:(indexPath.row == 0 ? [self selectedDefauleAddressImage] : [self unSelectedDefauleAddressImage]) forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = imageView;
    [_selectedes addObject:imageView];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

#pragma mark - choose action
- (void)chooseAction:(UIButton *)btn
{
//    _touchTrack = !_touchTrack;
//    [btn setImage:(_touchTrack ? [self selectedDefauleAddressImage] : [self unSelectedDefauleAddressImage]) forState:UIControlStateNormal];
    
    NSLog(@"配送方式：%ld", (long)btn.tag);
    for (UIButton *button in _selectedes) {
        [button setImage:[self unSelectedDefauleAddressImage] forState:UIControlStateNormal];
    }
    
    [btn setImage:[self selectedDefauleAddressImage] forState:UIControlStateNormal];
    selectedIndex = btn.tag;
}

#pragma mark - close
- (IBAction)closeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(choosePostageByBoard:)]) {
        [_delegate choosePostageByBoard:selectedIndex];
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

//#pragma mark --- touch handle
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _touchTrack = NO;
//    UITouch* t = [touches anyObject];
//    CGPoint p1 = [t locationInView:_contentView];
//    if (!CGRectContainsPoint(_contentView.bounds, p1)) {
//        _touchTrack = YES;
//    }else{
//        [super touchesBegan:touches withEvent:event];
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (_touchTrack) {
//        if (self.superview) {
//            [self removeFromSuperview];
//        }
//    }else{
//        [super touchesEnded:touches withEvent:event];
//    }
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if (_touchTrack) {
//        if (self.superview) {
//            [self removeFromSuperview];
//        }
//    }else{
//        [super touchesCancelled:touches withEvent:event];
//    }
//}

@end
