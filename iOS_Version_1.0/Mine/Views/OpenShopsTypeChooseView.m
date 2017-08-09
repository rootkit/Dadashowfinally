//
//  OpenShopsTypeChooseView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OpenShopsTypeChooseView.h"
#import "OpenShopsTypeCell.h"

@interface OpenShopsTypeChooseBoard () <OpenShopsTypeChooseViewDelegate>
{
    __weak OpenShopsTypeChooseView *_popView;
}

@end

@implementation OpenShopsTypeChooseBoard

static OpenShopsTypeChooseBoard *_popManager;
+ (instancetype)popViewManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _popManager = [OpenShopsTypeChooseBoard new];
    });
    return _popManager;
}

- (void)showPopView
{
    if (_popView) {
        _popView = nil;
    }
    
    OpenShopsTypeChooseView *popView = [OpenShopsTypeChooseView showCouponPopView];
    _popView = popView;
    popView.delegate = self;
    popView.frame = [UIScreen mainScreen].bounds;
    
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    
    //背景蒙层的动画：alpha值从0.0变化到0.5
    [popView.bgView setAlpha:0.0];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        [popView.bgView setAlpha:0.5];
    } completion:^(BOOL finished) { }];
}
- (void)hiddenPopView
{
    if (_popView.superview) {
        [_popView removeFromSuperview];
    }
}

#pragma mark - OpenShopsTypeChooseViewDelegate
- (void)selectedShopType:(NSString *)typeTitle
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectedShopType:)]) {
        [_delegate selectedShopType:typeTitle];
    }
}

@end

////////

@interface OpenShopsTypeChooseView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *typeTitles;

@end

@implementation OpenShopsTypeChooseView
{
    BOOL _touchTrack;
}

+ (instancetype)showCouponPopView
{
    OpenShopsTypeChooseView *popView = [[[UINib nibWithNibName:@"OpenShopsTypeChooseView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    
    [popView subLayouts];
    
    return popView;
}

- (void)subLayouts
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.layer.cornerRadius = 5;
    [self.tableView registerClass:[OpenShopsTypeCell class] forCellReuseIdentifier:OpenShopsTypeCellIdentifier];
    
    _typeTitles = [NSMutableArray new];
    //获取plist文件内容
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"goodsFirstClassify" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    [data enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [dic valueForKey:@"title"];
        
        [_typeTitles addObject:title];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_typeTitles.count) {
        return _typeTitles.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpenShopsTypeCell *cell = [OpenShopsTypeCell returnReuseCellFormTableView:self.tableView indexPath:indexPath identifier:OpenShopsTypeCellIdentifier];
    
    if (_typeTitles.count) {
        cell.title = _typeTitles[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    OpenShopsTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = _typeTitles[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedShopType:)]) {
        [_delegate selectedShopType:title];
    }
    cell.button.selected=YES;
 
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    OpenShopsTypeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.button.selected=NO;
    
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
        if (self.superview) {
            [self removeFromSuperview];
        }
    }else{
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_touchTrack) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }else{
        [super touchesCancelled:touches withEvent:event];
    }
}

@end
