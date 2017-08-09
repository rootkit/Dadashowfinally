//
//  Listtabelveiw.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/24.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "Listtabelveiw.h"
#import "DDXUserinfo.h"
#import "Searcharray.h"
#import "DDXHomeModel.h"
@interface Listtabelveiw()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation Listtabelveiw



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    }
    return self;
}





#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Searcharray sharedarray].searcharray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"seacrchcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    }
    DDXSearchModel* model= [Searcharray sharedarray].searcharray[indexPath.row];
    NSLog(@"模型%@",model);
    if (model.goodsName.length) {
        cell.textLabel.font = [UIFont systemFontOfSize:12*kScreen_Width/375];
        cell.textLabel.text=model.goodsName;
    }else{
       NSLog(@"关键为空");
        cell.textLabel.text=@"无";
    }
   return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击每一行");
      DDXSearchModel* model= [Searcharray sharedarray].searcharray[indexPath.row];
    if ([_dimissdelegate respondsToSelector:@selector(pushdetailvc:)]) {
        [_dimissdelegate pushdetailvc:model.goodsName];
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_dimissdelegate respondsToSelector:@selector(clickdissmiss)]) {
        [_dimissdelegate clickdissmiss];
    }
}


@end
