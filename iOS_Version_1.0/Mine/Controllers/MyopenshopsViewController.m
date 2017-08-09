//
//  MyopenshopsViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/9.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "MyopenshopsViewController.h"
#import "UIColor+CustomColor.h"
#import "IopenshopTableViewCell.h"
#import "OpenShopsTypeChooseView.h"

#define rating kScreen_Width/375

#define topLogovew_height 166*rating
#define headivew_height 242*rating
#define centerView_height 225*rating
#define footView_height 132*rating

#define logoIcon_W_H 109*rating

#define button_W 348*rating
#define button_H 45*rating

@interface MyopenshopsViewController ()<UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, OpenShopsTypeChooseBoardDelegate>
{
    UIView *bottomView;
    CGFloat _curTouchPointHeight;
    BOOL isShowKeyboard;
}

@property(nonatomic,strong) UIButton *  businessbtn;
@property(nonatomic,strong) UIButton * joinbtn;
@property (nonatomic, weak) UITableView *texttabelview;
@property (nonatomic,strong) NSArray *items;
@property(nonatomic,strong) UIView* footview;
@property(nonatomic,strong) UIButton * iconimagebtn;
@property(nonatomic,strong) UIButton *shopTypeBtn;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation MyopenshopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我要开店";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setuivew];
    
    //软键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAction:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _curTouchPointHeight = 0;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)]];
    self.view.userInteractionEnabled = YES;
}

- (NSArray *)items
{
    if (!_items) {
        _items = [NSArray array];
        _items = @[@"你的店铺信息", @"店铺地址", @"法人信息", @"联系方式", @"营业执照编号"];

    }
    return _items;
}
#pragma mark - init
- (UITableView *)texttabelview
{
    if (!_texttabelview) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = [UIColor colorWithHex:0xf4f4f4];
        tableView.scrollEnabled = NO;
        tableView.rowHeight = 45.0*rating;
        [bottomView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(headivew_height));
            make.centerX.equalTo(self.view);
            make.width.equalTo(@(kScreen_Width));
            make.height.equalTo(@(centerView_height));
        }];
        _texttabelview = tableView;
    }
    return _texttabelview;
}
-(void)setuivew{
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-64)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *headivew=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, topLogovew_height)];
    headivew.backgroundColor=[UIColor colorWithHex:0xf4f4f4];
    [bottomView addSubview:headivew];
    
    UIButton *iconimagebtn = [[UIButton alloc]init];
    [iconimagebtn setBackgroundImage:[UIImage imageNamed:@"ico_logo_bg"] forState:UIControlStateNormal];
    [iconimagebtn addTarget:self action:@selector(openiconimage) forControlEvents:UIControlEventTouchUpInside];
    [headivew addSubview:iconimagebtn];
    [iconimagebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10*rating));
        make.centerX.equalTo(headivew);
        make.width.height.equalTo(@(logoIcon_W_H));
    }];
    _iconimagebtn = iconimagebtn;
    
    UILabel *tagLabel = [UILabel new];
    tagLabel.text = @"点击上传logo";
    tagLabel.textColor = ThemeColor;
    tagLabel.font = [UIFont systemFontOfSize:13*rating];
    [headivew addSubview:tagLabel];
    
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconimagebtn.mas_bottom).with.offset(2*rating);
        make.centerX.equalTo(iconimagebtn);
    }];
    
    UIButton * joinbtn=[[UIButton alloc]init];
    [joinbtn setBackgroundImage:[UIImage imageNamed:@"choice_1"] forState:UIControlStateNormal];
    [joinbtn setBackgroundImage:[UIImage imageNamed:@"choice_2"] forState:UIControlStateSelected];
    [joinbtn addTarget:self action:@selector(joinour:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:joinbtn];
    [joinbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headivew.mas_bottom).equalTo(@(15*rating));
        make.left.equalTo(@(50*rating));
        make.width.height.equalTo(@(16*rating));
    }];
    _joinbtn = joinbtn;
    
    UILabel *joinLabel = [[UILabel alloc] init];
    joinLabel.font = [UIFont systemFontOfSize:14*rating];
    joinLabel.textColor = [UIColor colorWithHex:0x4f4f4f];
    joinLabel.text = @"我要加盟";
    [bottomView addSubview:joinLabel];
    [joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(joinbtn.mas_top);
        make.left.equalTo(joinbtn.mas_right).equalTo(@(5*rating));
    }];
    
    UIButton *businessbtn=[[UIButton alloc]init];
    [businessbtn setBackgroundImage:[UIImage imageNamed:@"choice_1"] forState:UIControlStateNormal];
    [businessbtn setBackgroundImage:[UIImage imageNamed:@"choice_2"] forState:UIControlStateSelected];
    [businessbtn addTarget:self action:@selector(business:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:businessbtn];
    [businessbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(joinbtn.mas_top);
        make.left.equalTo(joinLabel.mas_right).equalTo(@(81*rating));
        make.width.height.equalTo(@(16*rating));
    }];
    _businessbtn = businessbtn;
    
    UILabel *businessLabel = [[UILabel alloc] init];
    businessLabel.font = [UIFont systemFontOfSize:14*rating];
    businessLabel.textColor = [UIColor colorWithHex:0x4f4f4f];
    businessLabel.text=@"我要创业";
    [bottomView addSubview:businessLabel];
    [businessLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(joinbtn.mas_top);
        make.left.equalTo(businessbtn.mas_right).equalTo(@(5*rating));
    }];
    
    UILabel *shoptype = [[UILabel alloc] init];
    shoptype.font = [UIFont systemFontOfSize:14*rating];
    shoptype.textColor=[UIColor colorWithHex:0x4f4f4f];
    shoptype.text = @"店铺类型";
    [bottomView addSubview:shoptype];
    [shoptype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(joinbtn.mas_bottom).equalTo(@(20*rating));
        make.left.equalTo(@(16*rating));
        make.width.equalTo(@(65*rating));
    }];
    
    UIButton *shopTypeBtn = [UIButton new];
    [bottomView addSubview:shopTypeBtn];
    [shopTypeBtn setTitle:@"女装" forState:UIControlStateNormal];
    [shopTypeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 50)];
    [shopTypeBtn setTitleColor:[UIColor colorWithHex:0x4f4f4f] forState:UIControlStateNormal];
    shopTypeBtn.titleLabel.font = [UIFont systemFontOfSize:15*rating];
    [shopTypeBtn addTarget:self action:@selector(shopTypesChooseAction:) forControlEvents:UIControlEventTouchUpInside];
    _shopTypeBtn = shopTypeBtn;
    
    [shopTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shoptype.mas_right).equalTo(@(16*rating));
        make.centerY.equalTo(shoptype);
        make.width.equalTo(@(100));
        make.height.equalTo(@(20*rating));
    }];
    
    UILabel *shopTypeLine = [UILabel new];
    [bottomView addSubview:shopTypeLine];
    shopTypeLine.backgroundColor = BackCellColor;
    [shopTypeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopTypeBtn.mas_left).equalTo(@0);
        make.top.equalTo(shopTypeBtn.mas_bottom).equalTo(@4);
        make.right.equalTo(@(-12));
        make.height.equalTo(@(1));
    }];
    
    [self items];
    [self texttabelview];
    
    _footview = [[UIView alloc]initWithFrame:CGRectMake(0, headivew_height+centerView_height, kScreen_Width, footView_height)];
    _footview.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:_footview];

    UIButton * finishbtn=[[UIButton alloc]init];
    [finishbtn setTitle:@"立即开通" forState:UIControlStateNormal];
    [finishbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishbtn.titleLabel.font = [UIFont systemFontOfSize:20*rating];
    finishbtn.backgroundColor = ThemeColor;
    [finishbtn addTarget:self action:@selector(openfinish) forControlEvents:UIControlEventTouchUpInside];
    [_footview addSubview:finishbtn];
    
    finishbtn.layer.shadowColor = ThemeColor.CGColor;
    finishbtn.layer.shadowOffset = CGSizeMake(2, 2);
    finishbtn.layer.shadowOpacity = 0.8;
    finishbtn.layer.cornerRadius = 5;
    
    [finishbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(28*rating));
        make.centerX.equalTo(_footview);
        make.width.equalTo(@(button_W));
        make.height.equalTo(@(button_H));
    }];
    
    UIImageView* logoimage=[UIImageView new];
    logoimage.image=[UIImage imageNamed:@"botton_zt"];
    [_footview addSubview:logoimage];
    [logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(finishbtn.mas_bottom).equalTo(@(16*rating));
        make.centerX.equalTo(_footview);
        make.width.equalTo(@(156*rating));
        make.height.equalTo(@(13*rating));
    }];
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"i");
    
}
    
    
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    IopenshopTableViewCell *cell =[[IopenshopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.inputwardTF.placeholder=self.items[indexPath.row];
    [cell.inputwardTF setTag:indexPath.row];
    cell.inputwardTF.delegate=self;
    return cell;
    
}
-(void)textFieldDidChange :(UITextField *)textField{
    NSLog(@"%@",textField.text);
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
      NSLog(@"%@",textField.text);
}
-(void)openfinish{
    
    NSMutableArray  *infoArr = [NSMutableArray array];
    
    for (int i = 0; i < 5; i ++) {
        IopenshopTableViewCell *cell = [_texttabelview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        cell.inputwardTF.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell) {
            if(cell.inputwardTF.text.length <1){
                switch (i) {
                    case 0:
                        NSLog(@"您输入的店铺名字为空");
                    break;
                    case 1:
                        NSLog(@"您输入的店铺地址为空");
                    break;
                    case 2:
                        NSLog(@"您输入的法人信息空");
                    break;
                    case 3:
                        NSLog(@"您输入的联系方式为空");
                    break;
                    case 4:
                        NSLog(@"您输入的营业执照为空");
                    break;
                        
                    default:
                        break;
                }
                return;
            }
            [infoArr addObject:cell.inputwardTF.text];
        }
    }
    NSLog(@"输入框输入元素数组%@",infoArr);
 
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)openiconimage{
    NSLog(@"上传头像");
//  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *alert =[[UIAlertController alloc]init];
     [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
         imagePicker.allowsEditing=YES;
         imagePicker.delegate=self;
          [self presentViewController:imagePicker animated:YES completion:nil];
     }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.allowsEditing=YES;
        imagePicker.delegate=self;
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
         [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)joinour:(UIButton*)btn{
    btn.selected=!btn.selected;
    _businessbtn.selected=NO;
    NSLog(@"我要加盟");
}
-(void)business:(UIButton*)btn{
    _joinbtn.selected=NO;
    btn.selected=!btn.selected;
    NSLog(@"创业");
}

#pragma mark - 店铺类型选择
- (void)shopTypesChooseAction:(UIButton *)button
{
    NSLog(@"店铺类型选择弹出框");
    OpenShopsTypeChooseBoard *popBoard = [OpenShopsTypeChooseBoard popViewManager];
    popBoard.delegate = self;
    [popBoard showPopView];
}


#pragma mark - pickerController
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* iconImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [_iconimagebtn setBackgroundImage:iconImage forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - OpenShopsTypeChooseBoardDelegate

- (void)selectedShopType:(NSString *)typeTitle
{
    [_shopTypeBtn setTitle:typeTitle forState:UIControlStateNormal];
}

#pragma mark - 软键盘隐藏
- (void)keyBoardHiden:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    
    [self.view removeGestureRecognizer:_tap];
}

- (void)keyboardAction:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *animationDuration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval timeInt;
    [animationDuration getValue:&timeInt];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGFloat keyBoradHeight = keyboardRect.size.height;
    if (keyBoradHeight <= 0) {
        return;
    }
    
    
    CGFloat offestY = kScreen_Height - keyBoradHeight;
    CGFloat paading = 10;
    __block CGFloat moveY;
    if (_curTouchPointHeight > offestY) {
        moveY = _curTouchPointHeight - offestY + paading;
    }else{
        moveY = 0;
    }
    
    if (notification.name == UIKeyboardWillShowNotification) {
        if (isShowKeyboard == NO) {
            [UIView animateWithDuration:timeInt
                                  delay:0.f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 CGRect oldFrame = self.view.frame;
                                 oldFrame.origin.y -= moveY;
                                 self.view.frame = oldFrame;
                             } completion:^(BOOL finished) {
                                 isShowKeyboard = YES;
                             }];
            
            _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHiden:)];
            [self.view addGestureRecognizer:_tap];
        }
        
        
    } else if (notification.name == UIKeyboardWillHideNotification) {
        [UIView animateWithDuration:-timeInt
                              delay:0.f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect oldFrame = self.view.frame;
                             oldFrame.origin.y = 0;
                             self.view.frame = oldFrame;
                         } completion:^(BOOL finished) {
                             isShowKeyboard = NO;
                         }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [textField convertRect: textField.bounds toView:keyWindow];
    CGFloat windowPoint = CGRectGetMaxY(rect);
    
    _curTouchPointHeight = windowPoint;
    
    return YES;
}

@end
