//
//  FashWordDetailViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/14.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FashWordDetailViewController.h"
#import "FashWordDetailcell.h"
#import "DetailComment.h"
@interface FashWordDetailViewController ()<FashWordDetailcellDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray<DetailComment *> *comments;
@property(nonatomic,weak)UITableView* subdetailtableview;
@property(nonatomic,strong)UITextField* commentfield;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIView* headview;
@end

@implementation FashWordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index=-1;
    [self subdetailtableview];
    self.navigationItem.title = @"动态详情";
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self setdetailheadview];
    [self dListionKeyBoard];
    [self settextview];

 

}
-(void)settextview{
    UIView* textbottomview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height-52*(kScreen_Width/375), kScreen_Width, kScreen_Height)];
    textbottomview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:textbottomview];
    
    UITextField* commentfield=[self getTheNormalTF];
    commentfield.backgroundColor=[UIColor whiteColor];
    commentfield.placeholder=@"    写评论";
    commentfield.returnKeyType= UIReturnKeySend;
    commentfield.layer.cornerRadius=5*(kScreen_Height/677);
    commentfield.layer.masksToBounds=YES;
     [commentfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    commentfield.layer.borderColor=[UIColor colorWithHex:0xa5a7a9].CGColor;
    commentfield.layer.borderWidth=1.0*(kScreen_Height/677);
    [textbottomview addSubview:commentfield];
    [commentfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(11*(kScreen_Height/667)));
        make.left.equalTo(@(24*(kScreen_Height/667)));
        make.right.equalTo(@(-24*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));
        
    }];
    _commentfield=commentfield;
}

-(void)setdetailheadview{
    UIImageView* imageview=[[UIImageView alloc]init];
    imageview.image=[UIImage imageNamed:@"detailview"];
    [_headview addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(15*(kScreen_Width/375)));
        make.left.equalTo(@(12*(kScreen_Width/375)));
        make.right.equalTo(@(-12*(kScreen_Width/375)));
        make.height.equalTo(@(200*(kScreen_Width/375)));
   }];
    
    UILabel* titleabel = [UILabel new];
    titleabel.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
    titleabel.textColor = [UIColor colorWithHex:0x3f3f3f];
    titleabel.text=@"她不用大牌傍身只穿基础款,借鉴度这么高我全学会了";
    [_headview addSubview:titleabel];
    [titleabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).equalTo(@(10*kScreen_Width/375));
        make.left.equalTo(@(15*kScreen_Width/375));
        
    }];
    
    UIImageView* portraitIMG = [UIImageView new];
    portraitIMG.layer.masksToBounds = YES;
    portraitIMG.layer.cornerRadius = 17*(kScreen_Width/375); //圆角（圆形）
    portraitIMG.image = [UIImage imageNamed:@"collect_shop_userPortrait"];
    [_headview addSubview:portraitIMG];
    [portraitIMG mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(titleabel.mas_bottom).equalTo(@(10*kScreen_Width/375));
         make.left.equalTo(@(12*kScreen_Width/375));
         make.width.equalTo(@(35*kScreen_Width/375));
         make.height.equalTo(@(35*kScreen_Width/375));
    }];
    
    
    UILabel* nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithHex:0x9d9d9d];
    nameLabel.text=@"AISA HOME";
    [_headview addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleabel.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.left.equalTo(portraitIMG.mas_right).equalTo(@(12*kScreen_Width/375));
    }];
    
    UILabel* information = [UILabel new];
    information.font = [UIFont systemFontOfSize:14];
    information.textColor = [UIColor colorWithHex:0x9d9d9d];
    information.text=@"25";
    [_headview addSubview:information];
    [information mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top);
        make.right.equalTo(@(-12*kScreen_Width/375));
    }];
    
    UIImageView*transIMG = [UIImageView new];
    transIMG.image=[UIImage imageNamed:@"ico_comment"];
    [_headview addSubview:transIMG];
    [transIMG mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(titleabel.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.right.equalTo(information.mas_left).equalTo(@(-4*kScreen_Width/375));
        make.width.equalTo(@(20*kScreen_Width/375));
        make.height.equalTo(@(17*kScreen_Width/375));
    }];
    
    UILabel* likelabel = [UILabel new];
    likelabel.font = [UIFont systemFontOfSize:14];
    likelabel.textColor = [UIColor colorWithHex:0x9d9d9d];
    likelabel.text=@"345";
    [_headview addSubview:likelabel];
    [likelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top);
        make.right.equalTo(transIMG.mas_left).equalTo(@(-14*kScreen_Width/375));
    }];
    
    UIImageView* likeimage = [UIImageView new];
    likeimage.image=[UIImage imageNamed:@"ico_like"];
    [_headview addSubview:likeimage];
    [likeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleabel.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.right.equalTo(likelabel.mas_left).equalTo(@(-4*kScreen_Width/375));
        make.width.equalTo(@(20*kScreen_Width/375));
        make.height.equalTo(@(17*kScreen_Width/375));
    }];
    
    UILabel* whitchlabel = [UILabel new];
    whitchlabel.font = [UIFont systemFontOfSize:14];
    whitchlabel.textColor = [UIColor colorWithHex:0x9d9d9d];
    whitchlabel.text=@"4.3亿";
    [_headview addSubview:whitchlabel];
    [whitchlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_top);
        make.right.equalTo(likeimage.mas_left).equalTo(@(-14*kScreen_Width/375));
    }];
    
    UIImageView* watchIMG = [UIImageView new];
    watchIMG.image = [UIImage imageNamed:@"ico_watch"];
    [_headview addSubview:watchIMG];
    [watchIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleabel.mas_bottom).equalTo(@(20*kScreen_Width/375));
        make.right.equalTo(whitchlabel.mas_left).equalTo(@(-4*kScreen_Width/375));
        make.width.equalTo(@(20*kScreen_Width/375));
        make.height.equalTo(@(17*kScreen_Width/375));
    }];

    
    UILabel* line=[UILabel new];
    line.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [_headview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@(0.5*(kScreen_Height/667)));
        make.right.equalTo(@-0);
        
    }];
    
    
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _comments = [NSMutableArray array];
    }
    return self;
}

#pragma mark - init
- (UITableView *)subdetailtableview
{
    if (!_subdetailtableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-52*(kScreen_Width/375)) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        UIView* headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 300*(kScreen_Width/375))];
        headview.backgroundColor=[UIColor whiteColor];
        _headview=headview;
        tableView.tableHeaderView =_headview;
        [tableView registerClass:[FashWordDetailcell class] forCellReuseIdentifier:commentCellIdentifier];
        tableView.backgroundColor = BackCellColor;
        tableView.separatorColor = [UIColor colorWithHex:0xEEEEEE];
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        _subdetailtableview = tableView;
         [self testItem];
    }
    return _subdetailtableview;
}

- (void)testItem
{
    
    for (int i=0; i<4; i++) {
        DetailComment *item = [DetailComment new];
        item.portraitUrl = @"http://pic.qiantucdn.com/58pic/18/20/49/27k58PICMDF_1024.jpg";
        item.username = @"初秋记易";
        item.time = @"20-17-04-27";
        item.stringarray=[NSMutableArray arrayWithObjects:@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"一开始也是朋友推荐过来看的，看到朋友穿在身上炒鸡好坑，所以就入手试试，到货试试确实不错",@"看图!看图!看图!一口气买了三件，确实不错了",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"简直是不可思议,没想到这么便宜买到衣服，质量居然也这么好，摸着挺舒服的，最关键是好看啊",@"看图!看图!看图!一口气买了三件，确实不错了",@"看图!看图!看图!一口气买了三件，确实不错了",@"看图!看图!看图!一口气买了三件，确实不错了",@"看图!看图!看图!一口气买了三件，确实不错了,宋国有个农民，他的田地中有一截树桩。一天，一只跑得飞快的野兔撞在了树桩上，扭断了脖子死了。于是，农民便放下他的农具日日夜夜守在树桩子旁边，希望能再得到一只兔子。然而野兔是不可能再次得到了，而他自己也被宋国人耻笑。而今居然想用过去的治国方略来治理当今的百姓，这都是在犯守株待兔一样的错误呀！宋国有个农民，他的田地中有一截树桩。一天，一只跑得飞快的野兔撞在了树桩上，扭断了脖子死了。于是，农民便放下他的农具日日夜夜守在树桩子旁边，希望能再得到一只兔子。然而野兔是不可能再次得到了，而他自己也被宋国人耻笑。而今居然想用过去的治国方略来治理当今的百姓，这都是在犯守株待兔一样的错误呀！宋国有个农民，他的田地中有一截树桩。一天，一只跑得飞快的野兔撞在了树桩上，扭断了脖子死了。于是，农民便放下他的农具日日夜夜守在树桩子旁边，希望能再得到一只兔子。然而野兔是不可能再次得到了，而他自己也被宋国人耻笑。而今居然想用过去的治国方略来治理当今的百姓，这都是在犯守株待兔一样的错误呀！wo",nil];
        NSLog(@"%lu",(unsigned long)item.stringarray.count);
        item.friendnamearray=[NSMutableArray arrayWithObjects:@"贾宝玉",@"林黛玉",@"薛宝钗",@"王熙凤",@"鸳鸯",@"袭人",@"袭人",@"袭人",@"袭人",@"袭人",@"袭人",@"林黛玉",@"林黛玉",@"林黛玉",nil];
         NSLog(@"%lu",(unsigned long)item.friendnamearray.count);
        item.content = @"宋国有个农民，他的田地中有一截树桩。一天，一只跑得飞快的野兔撞在了树桩上，扭断了脖子死了。于是，农民便放下他的农具日日夜夜守在树桩子旁边，希望能再得到一只兔子。然而野兔是不可能再次得到了，而他自己也被宋国人耻笑。而今居然想用过去的治国方略来治理当今的百姓，这都是在犯守株待兔一样的错误呀！";
        [item calculateLayout];
        [_comments addObject:item];
        
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.comments.count) {
        return self.comments.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FashWordDetailcell *cell = [FashWordDetailcell returnResueCellFormTableView:tableView indexPath:indexPath identifier:commentCellIdentifier];
    
    NSLog(@"更新后的数组%@",_comments);
    if (self.comments.count) {
        cell.commentItem = self.comments[indexPath.row];
    } else {
        return [UITableViewCell new];
    }
    cell.delegate=self;
    cell.tag=indexPath.row;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.comments.count) {
        DetailComment *commentItem = self.comments[indexPath.row];
        return commentItem.rowHeight;
    } else {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index=-1;
    self.commentfield.text=@"";
    [self.commentfield becomeFirstResponder];
  

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"%ld",(long)self.index);
    [self.commentfield resignFirstResponder];
    if (self.index==-1) {
        self.commentfield.text=@"";
        [self.commentfield becomeFirstResponder];
        DetailComment *item = [DetailComment new];
        item.portraitUrl = @"http://pic.qiantucdn.com/58pic/18/20/49/27k58PICMDF_1024.jpg";
        item.username = @"我";
        item.time = @"20-17-04-27";
        item.stringarray=nil;
        NSLog(@"%lu",(unsigned long)item.stringarray.count);
        item.friendnamearray=nil;
        NSLog(@"%lu",(unsigned long)item.friendnamearray.count);
        item.content = @"你好";
        [item calculateLayout];
        [_comments addObject:item];
        [self.subdetailtableview reloadData];
    }
    else{
        
    DetailComment *commentItem= self.comments[self.index];
    [commentItem.friendnamearray addObject:@"我"];
    [commentItem.stringarray addObject:self.commentfield.text];
    [self.comments replaceObjectAtIndex:self.index withObject:commentItem];
    [commentItem calculateLayout];
    [self.subdetailtableview reloadData];
    self.index=-1;
    }
       self.commentfield.text=@"";
     [self.commentfield resignFirstResponder];
    return YES;
    
   

}


-(void)clickfirendusername:(FashWordDetailcell *)cell firendid:(NSString *)friendid{
    self.commentfield.text=[NSString stringWithFormat:@"回复@%@:",friendid];
     [self.commentfield becomeFirstResponder];
    self.index=cell.tag;
    

}


//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//     self.commentfield.text=@"    回复楼主";
//    NSLog(@"回复楼主");
//}


- (UITextField *)getTheNormalTF
{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = [UIColor colorWithHex:0xAEAEAE];
    textField.delegate = self;
    return textField;
}

-(void)textFieldDidChange :(UITextField *)textField{
  
    
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.commentfield resignFirstResponder];
}

@end
