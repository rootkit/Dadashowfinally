//
//  FiveCommentViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/5.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "FiveCommentViewController.h"
#import "UIColor+CustomColor.h"
#import "StarView.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
@interface FiveCommentViewController ()<UITextViewDelegate,HXPhotoViewDelegate>
@property (nonatomic, strong) StarView *starView;
@property(nonatomic,strong)UILabel* scorelabel;
@property (nonatomic,weak) UITextView *textView;
@property (nonatomic ,weak) UILabel *placeholderLabel;
@property (strong, nonatomic) HXPhotoManager *manager;
@end

@implementation FiveCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"发表评论";
    [self setcommentview];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithHex:0xf30867];
}
-(void)publish{
    
    NSLog(@"发表");
}

  
  
  
  - (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        //        _manager.openCamera = NO;
        _manager.outerCamera = YES;
    }
    return _manager;
}
-(void)setcommentview{
    UIView* backview=[[UIView alloc]initWithFrame:CGRectMake(0,64, kScreen_Width, kScreen_Height)];
//   backview.backgroundColor=[UIColor greenColor];
    [self.view addSubview:backview];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image=[UIImage imageNamed:@"首页"];
    iconView.layer.cornerRadius = 4;
    iconView.layer.masksToBounds = YES;
    [backview  addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(35*(kScreen_Height/667)));
        make.height.equalTo(@(45*(kScreen_Height/667)));
    }];
    UILabel *starLabel = [[UILabel alloc] init];
    starLabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    starLabel.textColor=[UIColor colorWithHex:0x585858];
    starLabel.text=@"描述相符";
    [backview addSubview:starLabel];
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(iconView.mas_right).equalTo(@(24*(kScreen_Height/667)));
        make.height.equalTo(@(45*(kScreen_Height/667)));
    }];
    UILabel* scorelabel=[[UILabel alloc]init];
    scorelabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    scorelabel.textColor=[UIColor colorWithHex:0xb3b3b3];
//    scorelabel.text=@"非常好";
    [backview addSubview:scorelabel];
    [scorelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.right.equalTo(@(-12*(kScreen_Height/667)));
        make.height.equalTo(@(45*(kScreen_Height/667)));
    }];
    _scorelabel=scorelabel;
    StarView* star=[[StarView alloc]init];
    [backview addSubview:star];
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.top.equalTo(@(12*(kScreen_Height/667)));
        make.left.equalTo(starLabel.mas_right).equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(150*(kScreen_Height/667)));
        make.height.equalTo(@(25*(kScreen_Height/667)));
        
    }];
    UILabel* lineone=[[UILabel alloc]init];
    lineone.backgroundColor=[UIColor colorWithHex:0xececec];
    [backview addSubview:lineone];
    [lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@0.5);
    }];
      __weak typeof(self) weakSelf = self;
    star.returnB = ^(CGFloat score) {

        if (score<=1.0) {
            weakSelf.scorelabel.text=@"很差";
        }else if (score<=2&&score>1){
            weakSelf.scorelabel.text=@"差";
        }
        else if (score<=3&&score>2){
            weakSelf.scorelabel.text=@"一般";
        }
        else if (score<=4&&score>3){
            weakSelf.scorelabel.text=@"很好";
        }
        else if (score<=5&&score>4){
            weakSelf.scorelabel.text=@"非常好";
        }
    };
    
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont boldSystemFontOfSize:15*(kScreen_Height/667)];
    textView.delegate = self;
    [backview addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineone.mas_bottom).equalTo(@1);
        make.left.equalTo(@0);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(110*(kScreen_Height/667)));
    }];
    _textView=textView;
    
      //自定义placeholder
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16*(kScreen_Height/667),20*(kScreen_Height/667), kScreen_Width-16*(kScreen_Height/667), 112*(kScreen_Height/667))];
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:14*(kScreen_Height/667)];
    label.text = @"宝贝满足你的期待吗?说说他的优点和不足的方面吧";
    label.textColor =[UIColor grayColor];
    [textView addSubview:label];
    [label sizeToFit];
    _placeholderLabel=label;
    HXPhotoView *hphotoView = [HXPhotoView photoManager:self.manager];
    hphotoView.frame = CGRectMake(12, 175*(kScreen_Height/667), kScreen_Width - 24, 0);
    hphotoView.delegate = self;
    _manager.maxNum=5;
    _manager.photoMaxNum=6;
    _manager.type=HXPhotoManagerSelectedTypePhoto;//这个对象是个单利
    _manager.selectTogether=NO;
    [backview addSubview:hphotoView];
    
    UILabel*  linetwo=[[UILabel alloc]init];
     linetwo.backgroundColor=[UIColor colorWithHex:0xececec];
    [backview addSubview: linetwo];
    [ linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hphotoView.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@0.5);
    }];
    UIButton * hidenamebtn= [UIButton buttonWithType:UIButtonTypeCustom];
    hidenamebtn.backgroundColor=[UIColor clearColor];
    [hidenamebtn setImage:[UIImage imageNamed:@"gouxuan"] forState:UIControlStateNormal];
    [hidenamebtn setTitle:@"匿名" forState:UIControlStateNormal];
    hidenamebtn.titleLabel.font=[UIFont systemFontOfSize:16*(kScreen_Height/667)];
    hidenamebtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [hidenamebtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 12*(kScreen_Height/667), 0, 0)];
    [hidenamebtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0,35*(kScreen_Height/667))];
    [hidenamebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hidenamebtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:hidenamebtn];
    [hidenamebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hphotoView.mas_bottom).equalTo(@(10*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(80*(kScreen_Height/667)));
        make.height.equalTo(@(35*(kScreen_Height/667)));
    }];
    
    UILabel* linethree=[[UILabel alloc]init];
    linethree.backgroundColor=[UIColor colorWithHex:0xececec];
    [backview addSubview:linethree];
    [linethree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hidenamebtn.mas_bottom).equalTo(@1);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@(14*(kScreen_Height/667)));
    }];

    
    UIView* otherview=[[UIView alloc]init];
    [self.view addSubview:otherview];
    [otherview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hidenamebtn.mas_bottom).equalTo(@(15*(kScreen_Height/667)));
        make.left.equalTo(@0);
        make.width.equalTo(@(kScreen_Width));
        make.height.equalTo(@(120*(kScreen_Height/667)));

    }];
    UIImageView* imageviewshop=[UIImageView new];
    imageviewshop.image=[UIImage imageNamed:@"首页"];
    [otherview addSubview:imageviewshop];
    [imageviewshop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(30*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));

    }];
    UILabel *shoplabel = [[UILabel alloc] init];
    shoplabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    shoplabel.textColor=[UIColor colorWithHex:0x585858];
    shoplabel.text=@"店铺评分";
    [otherview addSubview:shoplabel];
    [shoplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Height/667)));
        make.left.equalTo(imageviewshop.mas_right).equalTo(@(12*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));
    }];
    
    UILabel *logistics = [[UILabel alloc] init];
    logistics.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    logistics.textColor=[UIColor colorWithHex:0x585858];
    logistics.text=@"物流服务";
    [otherview addSubview:logistics];
    [logistics mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(45*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));
    }];
    StarView* logisticsstar=[[StarView alloc]init];
    [otherview addSubview:logisticsstar];
    
    [logisticsstar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@(45*(kScreen_Height/667)));
        make.left.equalTo(logistics.mas_right).equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(150*(kScreen_Height/667)));
        make.height.equalTo(@(25*(kScreen_Height/667)));
        
    }];
    logisticsstar.returnB = ^(CGFloat score) {
        
        if (score<=1.0) {
            weakSelf.scorelabel.text=@"很差";
        }else if (score<=2&&score>1){
            weakSelf.scorelabel.text=@"差";
        }
        else if (score<=3&&score>2){
            weakSelf.scorelabel.text=@"一般";
        }
        else if (score<=4&&score>3){
            weakSelf.scorelabel.text=@"很好";
        }
        else if (score<=5&&score>4){
            weakSelf.scorelabel.text=@"非常好";
        }
    };
    UILabel *servelabel = [[UILabel alloc] init];
    servelabel.font = [UIFont systemFontOfSize:15*(kScreen_Height/667)];
    servelabel.textColor=[UIColor colorWithHex:0x585858];
    servelabel.text=@"服务态度";
    [otherview addSubview:servelabel];
    [servelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(90*(kScreen_Height/667)));
        make.left.equalTo(@(12*(kScreen_Height/667)));
        make.height.equalTo(@(30*(kScreen_Height/667)));
    }];
    StarView* servestar=[[StarView alloc]init];
    [otherview addSubview:servestar];
    
    [servestar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@(90*(kScreen_Height/667)));
        make.left.equalTo(servelabel.mas_right).equalTo(@(12*(kScreen_Height/667)));
        make.width.equalTo(@(150*(kScreen_Height/667)));
        make.height.equalTo(@(25*(kScreen_Height/667)));
        
    }];
    servestar.returnB = ^(CGFloat score) {
        
        if (score<=1.0) {
            weakSelf.scorelabel.text=@"很差";
        }else if (score<=2&&score>1){
            weakSelf.scorelabel.text=@"差";
        }
        else if (score<=3&&score>2){
            weakSelf.scorelabel.text=@"一般";
        }
        else if (score<=4&&score>3){
            weakSelf.scorelabel.text=@"很好";
        }
        else if (score<=5&&score>4){
            weakSelf.scorelabel.text=@"非常好";
        }
    };
    
    
    
    
    
    
    
    
    
    
//

    
    
    
    
}





-(void)hide{
    NSLog(@"匿名");;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_placeholderLabel) {
        _placeholderLabel.hidden = YES;
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
    }
    
}

-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"输出的内容%@",textView.text);
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        NSLog(@"%@",textView.text);
        [_textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    NSLog(@"%@",textView.text);
    return YES;
    
}

- (void)photoViewUpdateFrame:(CGRect)frame WithView:(UIView *)view
{
    NSLog(@"%@",NSStringFromCGRect(frame));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
