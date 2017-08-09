//
//  SearchListViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchView.h"
#import "TitleViewController.h"
#import "SearchKindViewController.h"
#import "ChooseGoodsView.h"

@interface SearchListViewController ()
@property(nonatomic,strong)ChooseGoodsView* chooseview;
@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"筛选"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(choosebtn)];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHex:0x585757]];
    [self setsearchlistbar];
    [self setlistview];
   
    
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removechooseview) name:@"removechooseview" object:nil];
    }
    return self;
}
-(void)setsearchlistbar{
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0,kScreen_Width ,44*kScreen_Width/375)];
    searchView.layer.cornerRadius =20*kScreen_Width/375;
    searchView.layer.masksToBounds = YES;
    self.navigationItem.titleView=searchView ;
   
    searchView.searchblock=^(NSString* searchwords){
        NSLog(@"搜索内容%@",searchwords);
    };
    searchView.cancelblock=^(){
        NSLog(@"取消事件");
    };
    
}

-(void)removechooseview{
 
        [self.chooseview removeFromSuperview];
       self.navigationController.navigationBar.hidden=NO;

}


-(void)setlistview{
      self.automaticallyAdjustsScrollViewInsets = NO;
    TitleViewController *titleCtl = [[TitleViewController alloc] initWithFrame:self.view.frame
                                                                        titles:@[@"综合", @"销量",@"价格"]
                                                               viewControllers:@[[[SearchKindViewController alloc] init],
                                                                                 [[SearchKindViewController alloc] init],
                                                                                  [[SearchKindViewController alloc] init]
                                                                            ]
                                                         andIsFixedTitleLength:YES
                                                                   andHasNavig:YES
                                                                  andHasTabbar:NO];
    titleCtl.titleScrollViewHeight = 44;
    titleCtl.titleButtonWidth = kScreen_Width/3;
    titleCtl.buttonBackgroundColor = [UIColor whiteColor];
    titleCtl.buttonSelectedColor = ThemeColor;
    titleCtl.buttonUnSelectedColor = [UIColor blackColor];
    titleCtl.buttonTitleSelectedColor = ThemeColor;
    titleCtl.buttonTitleUnSelectedColor = FirstTextColor;
    titleCtl.footHeight = 0;
    titleCtl.selectedType = TitleSelectedTypeWithFoot;
    titleCtl.font = [UIFont systemFontOfSize:14*kScreen_Width/375];
    titleCtl.footerUnSelectedColor = BackCellColor;
    
    [self addChildViewController:titleCtl];
    [self.view addSubview:titleCtl.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - bar action
-(void)choosebtn{
    NSLog(@"筛选");
    self.navigationController.navigationBar.hidden=YES;
      //点击后弹出背景透明view
    [UIView animateWithDuration:0.5 animations:^{
        if(!self.chooseview){
          self.chooseview=[[ChooseGoodsView alloc]initWithFrame:CGRectMake(kScreen_Width, 0, kScreen_Width, kScreen_Height)];
        }
        self.chooseview.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height);
          [self.view addSubview:self.chooseview];
    } completion:^(BOOL finished) {
        
    }];

}



@end
