//
//  WxandalipayViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/15.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "WxandalipayViewController.h"
#import "WxandAlipaycell.h"
@interface WxandalipayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *paychoosetableview;
@property(nonatomic,strong)UIButton* switchbtn;
@end

@implementation WxandalipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"支付设置";
    self.view.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    [self paychoosetableview];
 
}

#pragma mark - init
- (UITableView *)paychoosetableview
{
    if (!_paychoosetableview) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight=50.0;
        [self.view addSubview:tableView];
        tableView.scrollEnabled=NO;
        tableView.tableFooterView=[[UIView alloc]init];//去掉多余cell
        _paychoosetableview = tableView;
    }
    return _paychoosetableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    WxandAlipaycell *cell =[[WxandAlipaycell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    switch (indexPath.row) {
        case 0:
            cell.wxandailpayimage.image=[UIImage imageNamed:@"payment_wechat"];
            cell.titleLabel.text=@"微信支付";
            break;
        case 1:
            cell.wxandailpayimage.image=[UIImage imageNamed:@"payment_alipay"];
            cell.titleLabel.text=@"支付宝支付";
            break;
        default:
            break;
    }
    
    return cell;

}






//表示他各个分区的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* sectionview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
    sectionview.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    UILabel *label = [[UILabel alloc] init];
    label.textColor =[UIColor colorWithHex:0x747474];
    label.backgroundColor=[UIColor colorWithHex:0xeeeeee];
    label.text=@"请选择默认的付款方式";
    label.frame=CGRectMake(10, 0, kScreen_Width, 45);
    label.font = [UIFont boldSystemFontOfSize:13.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [sectionview addSubview:label];
    return  sectionview;
    
}


//表示图各个分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     WxandAlipaycell* cell=[self.paychoosetableview cellForRowAtIndexPath:indexPath];
    if (cell) {
        self.switchbtn.selected = NO;
         cell.selectedbtn.selected=YES;
        self.switchbtn =cell.selectedbtn;
        switch (indexPath.row) {
            case 0:
                NSLog(@"微信支付");
                break;
            case 1:
                NSLog(@"支付宝支付");
                break;
                
            default:
                break;
        }
    }
    
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
