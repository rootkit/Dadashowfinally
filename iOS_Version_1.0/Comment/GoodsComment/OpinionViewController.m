//
//  OpinionViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/10.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "OpinionViewController.h"
#import "OpinionTableViewCell.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
@interface OpinionViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,HXPhotoViewDelegate>
@property (nonatomic, strong) UITableView *Opiniontabelview;
@property (nonatomic,strong) NSArray *problems;
@property(nonatomic,strong)NSArray*  typearray;
@property (nonatomic,strong) NSMutableArray* finallyarray;
@property (nonatomic,weak) UITextView *textView;
@property(nonatomic,strong)UIView* footview;
@property (nonatomic ,weak) UILabel *placeholderLabel;
@property (strong, nonatomic) HXPhotoManager *manager;
@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationItem.title=@"意见反馈";
    self.view.backgroundColor=[UIColor whiteColor];
    [self Opiniontabelview];
    [self problems];
    [self typearray];
    [self finallyarray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
    
                                                                            action:@selector(submit)];
    [self dListionKeyBoard];
    [self setwriteview];

}

#pragma mark - init
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        //        _manager.openCamera = NO;
        _manager.outerCamera = YES;
    }
    return _manager;
}

-(void)setwriteview{
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont boldSystemFontOfSize:15];
    textView.delegate = self;
    [_footview addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_footview.mas_top);
        make.left.equalTo(_footview.mas_left);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(95*(kScreen_Width/375)));
    }];
    _textView=textView;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16*(kScreen_Height/667),20*(kScreen_Height/667), kScreen_Width-16*(kScreen_Height/667), 112*(kScreen_Height/667))];
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:14*(kScreen_Height/667)];
    label.text = @"如果您对我们有什么建议,期待和想法,请告诉我们";
    label.textColor =[UIColor grayColor];
    [textView addSubview:label];
    [label sizeToFit];
    _placeholderLabel=label;
    HXPhotoView *hphotoView = [HXPhotoView photoManager:self.manager];
    hphotoView.frame = CGRectMake(12, 96*(kScreen_Height/667), kScreen_Width - 24, 0);
    hphotoView.delegate = self;
    _manager.maxNum=5;
    _manager.photoMaxNum=5;
    _manager.type=HXPhotoManagerSelectedTypePhoto;//这个对象是个单利
    _manager.selectTogether=NO;
    [_footview addSubview:hphotoView];
    
    UILabel* line=[[UILabel alloc]init];
    line.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [_footview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hphotoView.mas_bottom).equalTo(@(8*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@1);
    }];
    
    UILabel *phonelabel = [[UILabel alloc] init];
    phonelabel.backgroundColor=[UIColor whiteColor];
    phonelabel.font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    phonelabel.textColor=[UIColor blackColor];
    phonelabel.textAlignment=NSTextAlignmentCenter;
    phonelabel.text=@"手机号";
    [_footview addSubview:phonelabel];
    [phonelabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(line.mas_bottom).equalTo(@0);
        make.width.equalTo(@(75*(kScreen_Height/677)));
        make.height.equalTo(@(47*(kScreen_Height/677)));
        
    }];
    
    UILabel* linesecond=[[UILabel alloc]init];
    linesecond.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [_footview addSubview:linesecond];
    [linesecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phonelabel.mas_top);
        make.width.equalTo(@1);
        make.height.equalTo(@(47*(kScreen_Height/677)));
        make.left.equalTo(@(75*(kScreen_Height/677)));
    }];
    
    UITextField* phonetestfield = [UITextField new];
    phonetestfield.placeholder = @"  方便我们更快向你反馈哦";
    phonetestfield.font = [UIFont systemFontOfSize:14*(kScreen_Height/677)];
    phonetestfield.tintColor = [UIColor themeColor];
    phonetestfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_footview addSubview:phonetestfield];
    phonetestfield.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    
    [phonetestfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phonelabel.mas_top);
        make.left.equalTo(@(76*(kScreen_Height/677)));
        make.right.equalTo(@(-0));
        make.height.equalTo(@(47*(kScreen_Height/677)));
    }];
    
    UIView* lastview=[[UIView alloc]init];
    lastview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [_footview addSubview:lastview];
    [lastview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phonetestfield.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.bottom.equalTo(@-0);
        
    }];
    
    

    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_placeholderLabel) {
        _placeholderLabel.hidden = YES;
        
    }
//    CGPoint position = CGPointMake(0, 100);
//    [_Opiniontabelview setContentOffset:position animated:YES];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }
    
}

-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"输出的内容%@",textView.text);
}



- (NSMutableArray *)finallyarray
{
    if (!_finallyarray) {
        _finallyarray = [NSMutableArray array];
    }
    return _finallyarray;
}
- (NSArray *)typearray
{
    if (!_typearray) {
        _typearray = [NSArray array];
        _typearray=@[@"功能异常",@"使用建议",@"功能需求",@"系统闪退"];
        
    }
    return _typearray;
}
- (NSArray *)problems
{
    if (!_problems) {
        _problems = [NSArray array];
        _problems=@[@"不能正常使用现在功能",@"用的不满意的地方都踢过来吧",@"现有功能不能满足的",@"app意外退出闪退"];
        
    }
    return _problems;
}
#pragma mark - init
- (UITableView *)Opiniontabelview
{
    if (!_Opiniontabelview) {
      UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight=50.0*(kScreen_Width/375);
        UIView* footview=[[UIView alloc]init];
        footview.frame=CGRectMake(0, 0, kScreen_Width, 500*(kScreen_Width/375));
        tableView.tableFooterView=footview;
        _footview=footview;
        [self.view addSubview:tableView];
        _Opiniontabelview = tableView;
    }
    return _Opiniontabelview;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
       return self.typearray.count;
    }else{
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    if (indexPath.section==0) {
        OpinionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[OpinionTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.typelabel.text=self.typearray[indexPath.row];
        cell.detailproblem.text=self.problems[indexPath.row];
        return cell;
    }
    
        else{
        UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        return cell;
       
    }
}

//表示他各个分区的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45*(kScreen_Width/375))];
    sectionview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    UILabel *label = [[UILabel alloc] init];
    label.textColor =[UIColor blackColor];
     label.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    switch (section) {
        case 0:
            label.text=@"问题类型";
            break;
        case 1:
            label.text=@"详细描述";
            break;
            
        default:
            break;
    }
    label.frame=CGRectMake(10*(kScreen_Width/375), 0, kScreen_Width, 45*(kScreen_Width/375));
    label.font = [UIFont boldSystemFontOfSize:13*(kScreen_Width/375)];
    label.textAlignment = NSTextAlignmentLeft;
//    label.backgroundColor=[UIColor whiteColor];
    [sectionview addSubview:label];
    return  sectionview;
    
}


//表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45*(kScreen_Width/375);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    OpinionTableViewCell* cell=[_Opiniontabelview cellForRowAtIndexPath:indexPath];
    if (cell) {
        switch (indexPath.row) {
            case 0:
                cell.selectedbtn.selected= !cell.selectedbtn.selected;
            break;
            case 1:
                cell.selectedbtn.selected= !cell.selectedbtn.selected;
            break;
            case 2:
                cell.selectedbtn.selected= !cell.selectedbtn.selected;
                break;
            case 3:
                cell.selectedbtn.selected= !cell.selectedbtn.selected;
                break;
            case 4:
                cell.selectedbtn.selected= !cell.selectedbtn.selected;
            break;
                
            default:
                break;
        }
    }
    
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if(velocity.y>0)
        
    {
        NSLog(@"上滑");
        [self.view  endEditing:YES];
    }
    else
        
    {
        NSLog(@"下滑");
        [self.view  endEditing:YES];    }
}

-(void)submit{
    [self.finallyarray removeAllObjects];// 每次提交清空数组
    
    
    for (int i = 0; i < 5; i ++) {
        OpinionTableViewCell *cell = [_Opiniontabelview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell) {
            if (cell.selectedbtn.selected) {
                [self.finallyarray addObject:self.problems[i]];
            }
            
       }
    }
      NSLog(@"最后提交问题的内容数组%@",self.finallyarray);
    if (self.finallyarray.count==0&&_textView.text.length==0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        hud.mode = MBProgressHUDModeText;
        hud.margin=10;
        hud.labelFont=[UIFont boldSystemFontOfSize:13];
        hud.detailsLabelText = @"意见不能为空";
        [hud hide:YES afterDelay:1.5];
        return;
    }
    else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
        hud.mode = MBProgressHUDModeText;
        hud.margin=10;
        hud.labelFont=[UIFont boldSystemFontOfSize:13];
        hud.detailsLabelText = @"提交成功";
        [hud hide:YES afterDelay:1.5];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    NSLog(@"提交反馈");
}

- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
    if (photos.count) {
        NSLog(@"%ld - %ld - %ld",allList.count,photos.count,videos.count);
        // 获取数组里面图片原图的 imageData 资源 传入的数组里装的是 HXPhotoModel  -- 这个方法必须写在点击上传的位置
        [HXPhotoTools fetchImageDataForSelectedPhoto:photos completion:^(NSArray<NSData *> *imageDatas) {
            NSLog(@"%ld",imageDatas.count);
        }];
        
        //  获取数组里面图片的原图 传入的数组里装的是 HXPhotoModel  -- 这个方法必须写在点击上传的地方获取 此方法会增大内存. 获取原图图片之后请将选中数组中模型里面的数据全部清空
        [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
            NSLog(@"上传的图片image数组%@",images);
        }];
    }else{
        NSLog(@"删除数组图片");
    }
}
- (void)photoViewUpdateFrame:(CGRect)frame WithView:(UIView *)view
{
    NSLog(@"%@",NSStringFromCGRect(frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dListionKeyBoard {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dkeyBoardPresent:) name:UIKeyboardWillChangeFrameNotification object:nil];
}



- (void)dkeyBoardPresent:(NSNotification *)notification{
    id duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue: &animationDuration];
    NSValue *animationCurveObject = [notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSUInteger animationCurve;
    [animationCurveObject getValue:&animationCurve];
    NSTimeInterval t = [duration floatValue];
    CGRect endFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = endFrame.origin.y;
    CGFloat margin = [UIScreen mainScreen].bounds.size.height - y;
    NSLog(@"%f----------%f",y,margin);
    //    self.toolBarBottomConstraint.constant = margin;
    self.view.frame = CGRectMake(0, y-kScreenHeight,kScreen_Width, kScreenHeight);
    
    [UIView animateWithDuration:t animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [self.navigationController.navigationBar setTintColor:UIBarStyleDefault];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
}


@end
