//
//  SQimageMenuShowView.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SQimageMenuShowView.h"
#import "UIColor+CustomColor.h"
#import "SQimageMenuShowCell.h"
#define itemHeigth     45*(kScreen_Height/667)  //每项高度
#define triangleWith   15*(kScreen_Height/667)  //三角形的高度

#define itemSelectColor  [[UIColor blackColor]colorWithAlphaComponent:0.1]

@interface SQimageMenuShowView ()<UITableViewDelegate,UITableViewDataSource>


@property (assign, nonatomic) CGPoint showPoint;
@property (strong, nonatomic) NSArray *items;
@property(nonatomic,strong)NSArray* imagename;
@property (strong, nonatomic) UITableView *myTabelView;
@property (assign, nonatomic) CGRect originalRect;

@property (strong, nonatomic) NSMutableSet *choseSet;


@end


@implementation SQimageMenuShowView
- (id)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items   imagearry:(NSArray<NSString *> *)imagename showPoint:(CGPoint)showPoint{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.showPoint = showPoint;
        self.items = items.copy;
        self.imagename=imagename.copy;
        CGRect newFrame = self.frame;
        newFrame.size.height = items.count *itemHeigth+triangleWith-5;
        self.frame = newFrame;
        self.alpha = 0;
        self.originalRect = newFrame;
        [self setNeedsDisplay];
        [self.myTabelView reloadData];
        self.layer.anchorPoint = CGPointMake(0.9, 0);
        self.layer.position = CGPointMake(self.layer.position.x+self.frame.size.width*0.4, self.layer.position.y-self.frame.size.height*0.5);
        
    }
    
    return self;
}

- (NSMutableSet *)choseSet{
    if (!_choseSet) {
        _choseSet = [[NSMutableSet alloc]init];
    }
    
    return _choseSet;
}

- (void)setSq_selectColor:(UIColor *)sq_selectColor{
    _sq_selectColor = sq_selectColor;
    [self.myTabelView reloadData];
}

- (void)setSq_backGroundColor:(UIColor *)sq_backGroundColor{
    _sq_backGroundColor = sq_backGroundColor;
    self.myTabelView.backgroundColor = _sq_backGroundColor;
}

- (void)setItemTextColor:(UIColor *)itemTextColor{
    _itemTextColor = itemTextColor;
    [self.myTabelView reloadData];
}

- (void)layoutSubviews{
    
}

- (UITableView *)myTabelView{
    if (_myTabelView) {
        
        return _myTabelView;
    }
    
    _myTabelView = [[UITableView alloc]initWithFrame:CGRectZero];
    _myTabelView.delegate = self;
    _myTabelView.dataSource = self;
    _myTabelView.backgroundColor = [UIColor whiteColor];
    _myTabelView.scrollEnabled = NO;
    _myTabelView.layer.cornerRadius = 5;
    _myTabelView.layer.masksToBounds = YES;
    _myTabelView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _myTabelView.frame = (CGRect){0,triangleWith-5,self.frame.size.width,self.frame.size.height-(triangleWith-5)+8};
    [self addSubview:_myTabelView];
    return _myTabelView;
}
////表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0.01;
    }else{
        return 2;
    }
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SQimageMenuShowCell *cell = [[ SQimageMenuShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSLog(@"数组元素%@",self.items);
    cell.textTitle.text = self.items[indexPath.section];
    cell.imageview.image=[UIImage imageNamed:self.imagename[indexPath.section]];
    cell.textTitle.textColor = [UIColor colorWithHex:0x585757];
    
//    if ([self.choseSet containsObject:@(indexPath.row)]) {
//        cell.backgroundColor = itemSelectColor;
//    }else{
//        cell.backgroundColor = [UIColor clearColor];
//    }
//    
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, itemHeigth)];
//    backView.backgroundColor = [UIColor whiteColor];
//    cell.selectedBackgroundView = backView;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return itemHeigth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock (self,indexPath.section);
    }
    if (![self.choseSet containsObject:@(indexPath.row)]) {
        [self.choseSet removeAllObjects];
        [self.choseSet addObject:@(indexPath.row)];
    }
    [self.myTabelView reloadData];
    [self dismissView];
}


#pragma - method


- (void)showView{
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    }];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect

{
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    CGPoint locationPoint = CGPointMake(self.showPoint.x - self.originalRect.origin.x, 0);
    CGPoint leftPoint     = CGPointMake(self.showPoint.x - self.originalRect.origin.x-triangleWith/2, triangleWith-5*(kScreen_Height/667));
    CGPoint rightPoint    = CGPointMake(self.showPoint.x - self.originalRect.origin.x+triangleWith/2, triangleWith-5*(kScreen_Height/667));
    
    
    CGContextMoveToPoint(context,locationPoint.x,locationPoint.y);//设置起点
    
    CGContextAddLineToPoint(context,leftPoint.x ,  leftPoint.y);
    
    CGContextAddLineToPoint(context,rightPoint.x, rightPoint.y);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    UIColor * clor = self.myTabelView.backgroundColor;
    [clor setFill];  //设置填充色
    
    [clor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
    
}

- (void)selectBlock:(void (^)(SQimageMenuShowView *, NSInteger))block{
    self.selectBlock = block;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */




@end
