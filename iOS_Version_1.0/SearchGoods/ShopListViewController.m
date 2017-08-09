//
//  ShopListViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#define  seacrchheight 30
#define hotviewheight 185*(kScreen_Width/375)

#import "ShopListViewController.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"
#import "SearchView.h"
#import "HomeSearchCell.h"
#import "Searcharray.h"
#import "Listtabelveiw.h"
#import "DDXHomeModel.h"
#import "Searcharray.h"
#import "DDXDetailViewController.h"
@interface ShopListViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,ListtabelveiwDelegate>
@property (nonatomic ,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView* listtableview;
@property(nonatomic,strong)NSMutableArray* historyarray;
@property(nonatomic,strong) NSArray* titlearray;
@property (nonatomic, assign) CGFloat viewHeight;
@property(nonatomic,strong)Listtabelveiw* seacrhtableveiw;
@property(nonatomic,strong)NSMutableArray <DDXSearchModel *>* searchmodel;//搜索模型

@end

@implementation ShopListViewController

- (NSMutableArray*)searchmodel
{
    if (!_searchmodel) {
        _searchmodel= [NSMutableArray new];
    }
    return _searchmodel;
}


-(NSMutableArray*)historyarray{
    if (!_historyarray) {
        _historyarray=[NSMutableArray array];
        
    }
    return _historyarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
   
    [self.navigationItem setHidesBackButton:YES];

    self.view.backgroundColor=[UIColor whiteColor];
    [self searchmodel];
    [Searcharray sharedarray].searcharray=[NSMutableArray array];
    [self searchBar];
    [self holdview];
    [self historyarray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickremoveview)];
   [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12] , NSFontAttributeName, nil] forState:UIControlStateNormal];
}


-(void)searchhistorylist{
    
    NSString* usernameid=nil;
    if ([DDXUserinfo getUserId]) {
        
        usernameid=[NSString stringWithFormat:@"%ld",[DDXUserinfo getUserId]];
    }
    else{
        
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"%@",identifierForVendor);
        NSString* udidstring=[identifierForVendor stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@",udidstring);
        usernameid=udidstring;
    }
    
    NSLog(@"用户ID==%@",usernameid);
    NSString* historylisturlstr = [NSString stringWithFormat:@"%@%@/%@", DDXAPI_HTTP_PREIX_Search, DDXAPI_SHOPMMS_History,usernameid];
    [DaHttpTool get:historylisturlstr params:nil success:^(id json) {
       
         if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
      
                NSArray *contents = json[@"content"];
                self.historyarray = [contents mutableCopy];
                NSLog(@"请求历史列表%@",contents);
                [self.listtableview reloadData];
            }else{
                MBProgressHUD *HUD = [Util createHUD];
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = @"网络错误";
                
                [HUD hide:YES afterDelay:5];
            }
        }

    } failure:^(NSError *error) {
        NSLog(@"网络错误");
        
        
    }];
    
   
}


- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        UIView* searchview=[[UIView alloc]init];
        searchview.frame=CGRectMake(0, 10,kScreenWidth ,44);
        _searchBar = [[UISearchBar alloc]init];
        [_searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xeaeaea]]];//背景图片
        [_searchBar sizeToFit];
        _searchBar.layer.cornerRadius =15*(kScreen_Width/375);
        _searchBar.layer.masksToBounds = YES;
        [_searchBar changeLeftPlaceholder:@"连衣裙"];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
        [_searchBar setTranslucent:YES];//设置是否透明
        [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
        [_searchBar setShowsCancelButton:NO];
        UITextField *txfSearchField = [_searchBar valueForKey:@"_searchField"];
        if (txfSearchField) {
            txfSearchField.leftViewMode = UITextFieldViewModeNever;
            txfSearchField.backgroundColor=[UIColor colorWithHex:0xeaeaea];
        }
        [searchview addSubview:_searchBar];
        self.navigationItem.titleView=searchview;
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(5*(kScreen_Width/375)));
            make.left.equalTo(@(10*(kScreen_Width/375)));
            make.height.equalTo(@(seacrchheight));
            make.right.equalTo(@(-5*(kScreen_Width/375)));
        }];
        
    }
    return _searchBar;
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"seacrchcell";
    HomeSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeSearchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    if (self.historyarray.count>0) {
        cell.kindlabel.text = self.historyarray[indexPath.row];
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.searchBar resignFirstResponder];
    DDXDetailViewController* detailvc=[DDXDetailViewController new];
    detailvc.keywordstring=self.historyarray[indexPath.row];
    [self.navigationController pushViewController:detailvc animated:YES];

}





-(void)holdview{
    
    
    UIView* headview=[[UIView alloc]init];
    headview.backgroundColor=[UIColor whiteColor];
    
    
    UIView* holdview=[[UIView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width, hotviewheight)];
    [headview addSubview:holdview];
    _viewHeight=_viewHeight+hotviewheight;
    
    UILabel* labelineview=[[UILabel alloc]initWithFrame:CGRectMake(0, hotviewheight, kScreen_Width, 6*(kScreen_Width/375))];
    labelineview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [headview addSubview:labelineview];
    _viewHeight=_viewHeight+ 6*(kScreen_Width/375);
    
    UIView* sectviewview=[[UIView alloc]init];
    [headview addSubview:sectviewview];
    [sectviewview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelineview.mas_bottom).equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@-0);
        make.height.equalTo(@(40*(kScreen_Width/375)));
    }];
    _viewHeight=_viewHeight+40*(kScreen_Width/375);
    
    UILabel* recordlabel=[UILabel new];
    recordlabel.textColor=[UIColor colorWithHex:0x3f3f3f];
    recordlabel.backgroundColor=[UIColor whiteColor];
    recordlabel.text=@"历史记录";
    recordlabel.font=[UIFont systemFontOfSize:13.0*(kScreen_Width/375)];
    [sectviewview addSubview:recordlabel];
    [recordlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*(kScreen_Width/375)));
        make.top.equalTo(@0);
        make.height.equalTo(@(40*(kScreen_Width/375)));
    }];
    
    UIButton * delegatebtn=[[UIButton alloc]init];
    [delegatebtn setTitle:@"清除" forState:UIControlStateNormal];
    delegatebtn.titleLabel.textAlignment=NSTextAlignmentRight;
    [delegatebtn setTitleColor:[UIColor colorWithHex:0x3f3f3f] forState:0];
    delegatebtn.titleLabel.font=[UIFont systemFontOfSize:12.0*(kScreen_Width/375)];
    [delegatebtn addTarget:self action:@selector(delegatereload) forControlEvents:UIControlEventTouchUpInside];
    [sectviewview addSubview:delegatebtn];
    [delegatebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.right.equalTo(@(-12*(kScreen_Width/375)));
        make.width.equalTo(@(80*(kScreen_Width/375)));
        make.height.equalTo(@(40*(kScreen_Width/375)));
        
    }];
    
    UILabel* holdsearchlabel=[UILabel new];
    holdsearchlabel.textColor=[UIColor colorWithHex:0x3f3f3f];
    holdsearchlabel.backgroundColor=[UIColor clearColor];
    holdsearchlabel.text=@"热门搜索";
    holdsearchlabel.font=[UIFont systemFontOfSize:13.0*(kScreen_Width/375)];
    [holdview addSubview:holdsearchlabel];
    [holdsearchlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12*(kScreen_Width/375)));
        make.top.equalTo(@(10*(kScreen_Width/375)));
        make.width.equalTo(@(80*(kScreen_Width/375)));
        make.height.equalTo(@(35*(kScreen_Width/375)));
    }];
    
    
    UIButton * changebtn=[[UIButton alloc]init];
    [changebtn setTitle:@"换一换" forState:UIControlStateNormal];
    changebtn.titleLabel.textAlignment=NSTextAlignmentRight;
    changebtn.hidden=YES;
    [changebtn setTitleColor:[UIColor colorWithHex:0x3f3f3f] forState:0];
    changebtn.titleLabel.font=[UIFont systemFontOfSize:12.0*(kScreen_Width/375)];
    [changebtn addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    [holdview addSubview:changebtn];
    [changebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10*(kScreen_Width/375)));
        make.right.equalTo(@(-12*(kScreen_Width/375)));
        make.width.equalTo(@(80*(kScreen_Width/375)));
        make.height.equalTo(@(35*(kScreen_Width/375)));
        
    }];
    
    _titlearray=@[@"茜诗迪",@"慕之淇",@"wonderful",@"hurst",@"景欣荟",@"戈莱薇",@"POZO"];
    for (int i=0; i<7; i++) {
        
        UIButton * changebtn=[[UIButton alloc]init];
        [changebtn setTitle:_titlearray[i] forState:UIControlStateNormal];
        [changebtn setTitleColor:[UIColor colorWithHex:0x3f3f3f] forState:0];
        changebtn.layer.cornerRadius =3*(kScreen_Width/375);
        changebtn.layer.masksToBounds = YES;
        changebtn.titleLabel.font=[UIFont systemFontOfSize:12.0*(kScreen_Width/375)];
        [changebtn setTag:i];
        [changebtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        if (i<4) {
            changebtn.frame=CGRectMake(12*(kScreen_Width/375)+(77*i)*(kScreen_Width/375), 50*(kScreen_Width/375), 70*(kScreen_Width/375), 25*(kScreen_Width/375));
        }else{
            changebtn.frame=CGRectMake(12*(kScreen_Width/375)+77*(kScreen_Width/375)*(i-4),95*(kScreen_Width/375), 70*(kScreen_Width/375), 25*(kScreen_Width/375));
        }
        [changebtn setBackgroundColor:[UIColor colorWithHex:0xefefef]];
        
        
        [holdview addSubview:changebtn];
    }
    
    headview.frame=CGRectMake(0, 0,kScreen_Width, _viewHeight);
    [self.view addSubview:headview];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView=headview;
    tableView.rowHeight=45*(kScreen_Width/375);
    [self.view addSubview:tableView];
    _listtableview = tableView;
}

-(void)choose{
    NSLog(@"换一换");
}

-(void)delegatereload{
    NSLog(@"删除历史记录 ");
    NSString* usernameid=nil;
    if ([DDXUserinfo getUserId]) {
        
        usernameid=[NSString stringWithFormat:@"%ld",[DDXUserinfo getUserId]];
    }
    else{
        
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"%@",identifierForVendor);
        NSString* udidstring=[identifierForVendor stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@",udidstring);
        usernameid=udidstring;
    }
    
    NSLog(@"用户ID==%@",usernameid);
    
    NSString* delegateurlstr = [NSString stringWithFormat:@"%@%@/%@", DDXAPI_HTTP_PREIX_Search, DDXAPI_SHOPMMS_DeleteHistory,usernameid];
    [DaHttpTool get: delegateurlstr params:nil success:^(id json) {
     
        if ( [json isKindOfClass:[NSDictionary class]]) {
            if ([json[@"state"] isEqualToString:@"success"]) {
                
               NSLog(@"删除历史记录成功%@",json);
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                hud.mode = MBProgressHUDModeText;
                hud.margin=10;
                hud.labelFont=[UIFont boldSystemFontOfSize:13];
                hud.detailsLabelText = @"成功删除历史记录";
                [hud hide:YES afterDelay:1.5];
            
          }else{
              NSLog(@"请求错误");
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"网络错误");
        
    }];
    [self.historyarray removeAllObjects];
    [self.listtableview reloadData];
}

-(void)change:(UIButton*) btn{
    
    NSLog(@"%ld",(long)btn.tag);
    [self.searchBar resignFirstResponder];
    DDXDetailViewController* detailvc=[DDXDetailViewController new];
    detailvc.keywordstring=_titlearray[btn.tag];
    [self.navigationController pushViewController:detailvc animated:YES];
}

-(void)clickremoveview{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.searchBar resignFirstResponder];
    if (searchBar.text.length) {
        NSLog(@"搜索内容%@",searchBar.text);
        [self finder:searchBar.text];
        DDXDetailViewController* detailvc=[DDXDetailViewController new];
        detailvc.keywordstring=searchBar.text;
        [self.navigationController pushViewController:detailvc animated:YES];

        
        
    }else{
        [[Searcharray sharedarray].searcharray removeAllObjects];
        [self.seacrhtableveiw removeFromSuperview];
        self.seacrhtableveiw=nil;
        [self.searchBar resignFirstResponder];
    }
}



- (Listtabelveiw *)seacrhtableveiw
{
    if (!_seacrhtableveiw) {
        self.seacrhtableveiw = [[Listtabelveiw alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, kScreen_Height-64)];
        self.seacrhtableveiw = [[Listtabelveiw alloc] init];
        [self.view addSubview:self.seacrhtableveiw];
        self.seacrhtableveiw.dimissdelegate=self;
        [self.seacrhtableveiw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@64);
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@0);;
        }];
        self.seacrhtableveiw.dimissdelegate=self;
        [self.seacrhtableveiw layoutIfNeeded];
    }
    return _seacrhtableveiw;
}

-(void)finder:(NSString*)keystr{
    
    [self updateTabelFrame];
    NSString* usernameid=nil;
    if ([DDXUserinfo getUserId]) {
        
        usernameid=[NSString stringWithFormat:@"%ld",[DDXUserinfo getUserId]];
    }
    else{
        
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"%@",identifierForVendor);
        NSString* udidstring=[identifierForVendor stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@",udidstring);
        usernameid=udidstring;
    }
    
    NSLog(@"用户ID==%@",usernameid);
    
    NSString* searchurlstr = [NSString stringWithFormat:@"%@%@", DDXAPI_HTTP_PREIX_Search, DDXAPI_SHOPMMS_Keywords];
    [DaHttpTool post:searchurlstr params:@{@"userId":usernameid,
                                           @"keyWord":keystr,
                                           @"page":@(1)}.mutableCopy
             success:^(id json) {
                 if ( [json isKindOfClass:[NSDictionary class]]) {
                     if ([json[@"state"] isEqualToString:@"success"]) {
                         [[Searcharray sharedarray].searcharray removeAllObjects];
                         NSArray *contents = json[@"content"][@"itemList"];
                         self.searchmodel=[[NSArray osc_modelArrayWithClass:[DDXSearchModel class] json:contents] mutableCopy];
                         [[Searcharray sharedarray].searcharray addObjectsFromArray: self.searchmodel];
                         NSLog(@"数组%@",[Searcharray sharedarray].searcharray);
                         [self.seacrhtableveiw reloadData];
                         
                         
                     }else{
                         NSLog(@"请求错误");
                     }
                 }
                 
             } failure:^(NSError *error) {
                 NSLog(@"请求失败%@",error);
                 [self.seacrhtableveiw showEmptyPageViewWithImage:[UIImage imageNamed:@"ico_empty_fail"]
                                                             tip:@"与母星暂时失去联系啦"
                                                     buttonTitle:@"刷新"];
               
                }];
}



- (void)updateTabelFrame
{
    
    if (self.searchBar.text.length>0) {
        [UIView animateWithDuration:0.101 animations:^{
            CGFloat height = kScreen_Height-64;
            [self.seacrhtableveiw mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(@64);
                make.left.right.equalTo(@0);
                make.height.equalTo(@(height));
            }];
        }];
        
    }
    
    
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length) {
        [self finder:searchBar.text];
        NSLog(@"正在搜索内容%@",searchBar.text);
    }else{
        [[Searcharray sharedarray].searcharray removeAllObjects];
        [self.seacrhtableveiw removeFromSuperview];
        self.seacrhtableveiw=nil;
        [self.searchBar resignFirstResponder];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

-(void)clickdissmiss{
    [self.searchBar resignFirstResponder];
}

-(void)pushdetailvc:(NSString *)goodkeystring{
    
    NSLog(@"推出商品列表控制器");
    [self.searchBar resignFirstResponder];
    DDXDetailViewController* detailvc=[DDXDetailViewController new];
    detailvc.keywordstring=goodkeystring;
    [self.navigationController pushViewController:detailvc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self searchhistorylist];
}


@end
