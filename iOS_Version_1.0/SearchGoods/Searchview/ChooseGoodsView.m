//
//  ChooseGoodsView.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "ChooseGoodsView.h"
#import "KindchooseTableViewCell.h"
#define choosewidth (kScreen_Width-90*(kScreen_Height/667))/3
#define chooseheight 40*(kScreen_Height/667)
#define resultwidth  (kScreen_Width-50*(kScreen_Height/667))/2
#define sectionheight 40*(kScreen_Width/375)
#define leftspacing    40*(kScreen_Width/375)
#define tableheight 145*(kScreen_Width/375)
#define headviewheight kScreen_Height-145*(kScreen_Width/375)

@interface ChooseGoodsView()<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate,KindchooseTableViewCellDelegate>
@property(nonatomic,strong) UIView* subview;
@property(nonatomic,strong)UIButton* switchbtn;
@property (strong, nonatomic) UITableView *tableview;
@property(nonatomic,strong)UIView* headview;

/** 选项标题数组 */
@property (strong, nonatomic) NSMutableArray *headerTitArr;
/** 选项数据数组 */
@property (strong, nonatomic) NSMutableArray *dataArr;
/** 是否展开状态数组 */
@property (strong, nonatomic) NSMutableArray *shrinkArr;
/** 是否选中状态字典 */
@property (strong, nonatomic) NSMutableDictionary *selectedDict;
/** 重置按钮 */
@property (strong, nonatomic) UIButton * resetBut;
/** 确定按钮 */
@property (strong, nonatomic) UIButton * determineBut;

@property(nonatomic,strong)UITextField* maxmumfield;

@property(nonatomic,strong) UITextField* minimumfield;

@property(nonatomic,strong)NSNotificationCenter *removenotificationCenter;

@end
@implementation ChooseGoodsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self headerTitArr];
        [self dataArr];
        [self settoolview];
        self.shrinkArr = [NSMutableArray array];
        self.selectedDict = [NSMutableDictionary dictionary];
        for (int i = 0; i < self.headerTitArr.count; i++) {
            [self.shrinkArr addObject:@"NO"];
            NSMutableArray *selectedArr = [NSMutableArray array];
            for (int i = 0; i < self.dataArr.count; i++) {
                [selectedArr addObject:@"NO"];
            }
            [self.selectedDict setObject:selectedArr forKey:[NSString stringWithFormat:@"%d", i]];
        }
     
    }
    return self;
    
}
- (NSMutableArray*)dataArr
{
    if (!_dataArr) {
        _dataArr =[NSMutableArray arrayWithObjects:@"乐町"
                   ,@"可可尼"
                   ,@"森马"
                   ,@"左韵"
                   ,@"梦梦家"
                   ,@"GAP"
                   ,@"索尼"
                   ,@"三星"
                   ,@"酷派"
                   ,@"乐视"
                   ,@"优乐美"
                   ,@"GAP"
                   ,@"苹果", nil];
        
    }
    return _dataArr;
}


- (NSMutableArray *)headerTitArr
{
    if (!_headerTitArr) {
        _headerTitArr=[NSMutableArray arrayWithObjects:@"品牌"
                     , nil];
        
    }
    return _headerTitArr;
}





#pragma mark - 懒加载
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-leftspacing,kScreen_Height-49*(kScreen_Width/375)) style:UITableViewStyleGrouped];
        _tableview.backgroundColor=[UIColor whiteColor];
        _tableview.tableHeaderView=_headview;
        /** 隐藏cell分割线 */
        [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [self.subview addSubview:self.tableview];
    }
    return _tableview;
}

-(void)settoolview{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.subview=[[UIView alloc]initWithFrame:CGRectMake(kScreen_Width, 0, kScreen_Width, kScreen_Height)];
        self.subview.frame=CGRectMake(50*(kScreen_Height/667), 0, kScreen_Width-50*(kScreen_Height/667), kScreen_Height);
        self.subview.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.subview];
      
    
    } completion:^(BOOL finished) {
        
    }];
    
    UIView* headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-50*(kScreen_Height)/667, tableheight)];
    headview.backgroundColor=[UIColor whiteColor];
    [self.subview addSubview:headview];
    _headview=headview;
                                                            
    UILabel *pricesectionLabel = [[UILabel alloc] init];
    pricesectionLabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    pricesectionLabel.textColor=[UIColor colorWithHex:0x3e3e3e];
    pricesectionLabel.text=@"价格区间";
    [_headview addSubview:pricesectionLabel];
    [pricesectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(35*(kScreen_Height/667)));
        make.left.equalTo(@(14*(kScreen_Height/667)));
    }];
    
    UITextField* minimumfield=[self getTheNormalTF];
    minimumfield.placeholder=@"最低价";
    minimumfield.textAlignment=NSTextAlignmentCenter;
    minimumfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [_headview addSubview:minimumfield];
    [minimumfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pricesectionLabel.mas_bottom).equalTo(@(25*(kScreen_Height/667)));
        make.left.equalTo(@(46*(kScreen_Height/667)));
        make.width.equalTo(@(choosewidth));
        make.height.equalTo(@(chooseheight));
        
    }];
    _minimumfield=minimumfield;
    
    
    UITextField* maxmumfield=[self getTheNormalTF];
    maxmumfield.placeholder=@"最高价";
    maxmumfield.textAlignment=NSTextAlignmentCenter;
    maxmumfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [_headview addSubview:maxmumfield];
    [maxmumfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pricesectionLabel.mas_bottom).equalTo(@(25*(kScreen_Height/667)));
        make.left.equalTo(minimumfield.mas_right).equalTo(@(50*(kScreen_Height/667)));
        make.width.equalTo(@(choosewidth));
        make.height.equalTo(@(chooseheight));
        
    }];
    _maxmumfield=maxmumfield;
    
    [self.resetBut addTarget:self action:@selector(resetButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.determineBut addTarget:self action:@selector(determineButClick) forControlEvents:UIControlEventTouchUpInside];
      [self tableview];
}

- (UITextField *)getTheNormalTF
{
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor=[UIColor colorWithHex:0xf7f7f7];
    textField.font = [UIFont systemFontOfSize:12.0*(kScreen_Height/667)];
    textField.layer.cornerRadius =6;
    textField.layer.masksToBounds = YES;
    textField.textColor = [UIColor colorWithHex:0xd5d5d5];
    textField.delegate = self;
    return textField;
}


#pragma mark - tableView UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headerTitArr.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     KindchooseTableViewCell *cell = [ KindchooseTableViewCell cellWithTableView:tableView dataArr:self.dataArr indexPath:indexPath];
    /** 取消cell点击状态 */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.section;
    cell.delegate = self;
    
    NSString *sectionStr = [NSString stringWithFormat:@"%ld", indexPath.section];
    cell.selectedArr = self.selectedDict[sectionStr];
    
    cell.isShrinkage = self.shrinkArr[indexPath.section];
    
    cell.attributeArr = self.dataArr;
    
    return cell;

}

/** 取得选中选项的值，改变选项状态，刷新列表 */
- (void)selectedValueChangeBlock:(NSInteger)section key:(NSInteger)index value:(NSString *)value
{
    
    NSLog(@"区域%ld,下标%ld,值%@",(long)section,(long)index,value)
    ;
    NSString *sectionStr = [NSString stringWithFormat:@"%ld", section];
    NSMutableArray *arr = self.selectedDict[sectionStr];
    [arr replaceObjectAtIndex:index withObject:value];
    [self.selectedDict setObject:arr forKey:sectionStr];
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
//    [self.tableview reloadSections:indexSet withRowAnimation:NO];//刷新列表状态
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        KindchooseTableViewCell *cell = [[KindchooseTableViewCell alloc]init];
        cell.isShrinkage = self.shrinkArr[indexPath.section];
        cell.attributeArr = self.dataArr;
        return cell.height;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-leftspacing, sectionheight)];
    myView.backgroundColor=[UIColor whiteColor];
    UILabel *titLab = [[UILabel alloc]init];
    titLab.text = self.headerTitArr[section];
    titLab.font = [UIFont systemFontOfSize:15.0*(kScreen_Width/375)];
    CGSize titSize = [titLab.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0*(kScreen_Width/375)]}];
    titLab.textColor = [UIColor colorWithHex:0x3e3e3e];
    titLab.frame = CGRectMake(14.0*(kScreen_Width/375), 0, titSize.width, sectionheight);
    [myView addSubview:titLab];
    
    UIButton *shrinkBut = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width-90*(kScreen_Width/375), 0,sectionheight, sectionheight)];
    shrinkBut.tag = section;
    [shrinkBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if ([self.shrinkArr[section] isEqualToString:@"NO"]) {
        [shrinkBut setImage:[UIImage imageNamed:@"ico_xiala"] forState:UIControlStateNormal];
    }else {
     [shrinkBut setImage:[UIImage imageNamed:@"ico_shla"] forState:UIControlStateNormal];
    }
    [shrinkBut addTarget:self action:@selector(shrinkButClick:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:shrinkBut];
    
    return myView;
}



- (UIButton *)resetBut//重置
{
    if (!_resetBut) {
        _resetBut = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreen_Height - 49*(kScreen_Width/375),resultwidth, 49*(kScreen_Width/375))];
        [_resetBut setBackgroundColor:[UIColor colorWithHex:0xafaeae]];
        [_resetBut setTitle:@"重置" forState:UIControlStateNormal];
        _resetBut.titleLabel.font=[UIFont systemFontOfSize:26*(kScreen_Width/375)];
        [_resetBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.subview addSubview:_resetBut];
    }
    return _resetBut;
}
- (UIButton *)determineBut//确定
{
    if (!_determineBut) {
        _determineBut = [[UIButton alloc]initWithFrame:CGRectMake(resultwidth, kScreen_Height - 49*(kScreen_Width/375), resultwidth, 49*(kScreen_Width/375))];
        [_determineBut setBackgroundColor:[UIColor colorWithHex:0xfc5c98]];
        [_determineBut setTitle:@"确定" forState:UIControlStateNormal];
        _determineBut.titleLabel.font=[UIFont systemFontOfSize:26*(kScreen_Width/375)];
        [_determineBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.subview addSubview:_determineBut];
    }
    return _determineBut;
}

#pragma mark - 按钮点击事件
//重置
- (void)resetButClick{
    [self.shrinkArr removeAllObjects];
    [self.selectedDict removeAllObjects];
    for (int i = 0; i < self.headerTitArr.count; i++) {
        [self.shrinkArr addObject:@"NO"];
        NSMutableArray *selectedArr = [NSMutableArray array];
        for (int i = 0; i < self.dataArr.count; i++) {
            [selectedArr addObject:@"NO"];
        }
        [self.selectedDict setObject:selectedArr forKey:[NSString stringWithFormat:@"%d", i]];
    }
    [self.tableview reloadData];
}
//确定
- (void)determineButClick{
    _removenotificationCenter= [NSNotificationCenter defaultCenter];
     [_removenotificationCenter postNotificationName:@"removechooseview"object:nil userInfo:nil];
    
    NSMutableArray *strArr = [NSMutableArray array];//
    
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *priceStr = [NSString stringWithFormat:@"%@-%@", _maxmumfield.text,_minimumfield.text];
     [strArr addObject:priceStr];//
    
    for (int i = 1; i < self.headerTitArr.count; i++) {
        
        NSString *sectionStr = [NSString stringWithFormat:@"%d", i];
        NSMutableArray *sectionArr = self.selectedDict[sectionStr];
        
        NSMutableArray *lineArr = [NSMutableArray array];
        
        for (int i = 0; i < sectionArr.count; i++) {
            if ([sectionArr[i] isEqualToString:@"YES"]) {
                [lineArr addObject:[NSString stringWithFormat:@"%@", self.dataArr[i]]];
                
                [strArr addObject:self.dataArr[i]];
            }
        }
    }
    NSLog(@"筛选条件 : \n%@", [self dictionaryToJson:strArr]);
    //    NSLog(@"筛选条件 : \n%@", strArr);
}
/** 字典转json字符串 */
- (NSString*)dictionaryToJson:(id)data
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



- (void)shrinkButClick:(UIButton *)button
{
    
    if ([self.shrinkArr[button.tag] isEqualToString:@"NO"]) {
        NSLog(@"点击了第%ld块,展开", button.tag);
        [self.shrinkArr replaceObjectAtIndex:button.tag withObject:@"YES"];
    }else {
        NSLog(@"点击了第%ld块,收缩", button.tag);
        [self.shrinkArr replaceObjectAtIndex:button.tag withObject:@"NO"];
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:button.tag];
    [self.tableview reloadSections:indexSet withRowAnimation:NO];
}


-(void)dealloc{
    
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
