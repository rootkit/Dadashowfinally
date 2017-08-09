//
//  DetaildoorTableViewCell.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/8.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DetaildoorTableViewCell.h"
#import "Lookstarview.h"
#define doorbtnwidth  (kScreen_Width- 187*(kScreen_Width/375))/3
@interface DetaildoorTableViewCell()
@property (nonatomic, strong) Lookstarview *lookstar;
@end
@implementation DetaildoorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (Lookstarview *)lookstar{
    
    if (!_lookstar) {
        Lookstarview *lookstar = [[Lookstarview alloc] initWithFrame:CGRectMake(50*(kScreen_Width/375), 200*(kScreen_Width/375), 150*(kScreen_Width/375), 30*(kScreen_Width/375))];
        lookstar.returnB = ^(CGFloat score){
             NSLog(@"星星");
        };
        _lookstar = lookstar;
        
    }
    return _lookstar;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lookstar.currentValue = 2.3;   //赋初始值
        self.lookstar.userInteractionEnabled = NO; //关闭用户交互 （只允许看不允许操作）
        [self setdoorcell];
       
        
        
    }
    return  self;
}

-(void)setdoorcell{
   
    UIView* doorview=[[UIView alloc]init];
    doorview.backgroundColor=[UIColor whiteColor];
    doorview.layer.masksToBounds = YES;
    doorview.layer.cornerRadius = 2; //圆角（圆形）
    doorview.layer.borderColor  =[UIColor colorWithHex:0xa8a8a8].CGColor; //要设置的颜色
    doorview.layer.borderWidth = 0.3; //要设置的描边宽
    [self addSubview:doorview];
    [doorview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16*(kScreen_Width/375)));
        make.left.equalTo(@(14*(kScreen_Width/375)));
        make.bottom.equalTo(@(-14*(kScreen_Width/375)));
        make.width.equalTo(@(111*(kScreen_Width/375)));
        
    }];
    //店铺门店
    UIImageView *doorimage = [[UIImageView alloc] init];
    doorimage.image=[UIImage imageNamed:@"collect_goods"];
    [doorview addSubview:doorimage];
    [doorimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5*(kScreen_Width/375)));
        make.left.equalTo(@(5*(kScreen_Width/375)));
        make.right.equalTo(@(-5*(kScreen_Width/375)));
        make.bottom.equalTo(@(-5*(kScreen_Width/375)));
    }];
    // 店铺名字
    UILabel *doorname= [[UILabel alloc] init];
    doorname.font = [UIFont systemFontOfSize:13*(kScreen_Width/375)];
    doorname.text=@"ONLY(黄岗店)";
    doorname.textColor=[UIColor colorWithHex:0x585858];
    [self.contentView addSubview:doorname];
    [doorname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(21*(kScreen_Width/375)));
        make.left.equalTo(doorview.mas_right).equalTo(@(15*(kScreen_Width/375)));
    }];
    //按钮
    for (int i=0; i<3; i++) {
        UIButton * doorbtn=[[UIButton alloc]init];
        [doorbtn setTitle:@"欧美" forState:UIControlStateNormal];
        [doorbtn setTitleColor:[UIColor colorWithHex:0xfc5c98] forState:UIControlStateNormal];
        doorbtn.titleLabel.font=[UIFont systemFontOfSize:12*(kScreen_Width/375)];
        [doorbtn setTag:i];
        //      [doorbtn addTarget:self action:@selector(doorbtn:) forControlEvents:UIControlEventTouchUpInside];
        [doorbtn setBackgroundImage:[UIImage imageNamed:@"ic_store_Label"] forState:UIControlStateNormal];
        [self.contentView addSubview:doorbtn];
        [doorbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(doorname.mas_bottom).equalTo(@(10*(kScreen_Width/375)));
            make.left.equalTo(doorview.mas_right).equalTo((@(18*(kScreen_Width/375)+(doorbtnwidth+13*(kScreen_Width/375))*i)));
            make.width.equalTo(@(doorbtnwidth));
            make.height.equalTo(@(25*(kScreen_Width/375)));

        }];
    }
    //评价星星view
    [self addSubview:self.lookstar];
    [self.lookstar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(doorname.mas_bottom).equalTo(@(45*(kScreen_Width/375)));
                make.left.equalTo(doorview.mas_right).equalTo(@(16*(kScreen_Width/375)));
                make.width.equalTo(@(90*(kScreen_Width/375)));
                make.height.equalTo(@(15*(kScreen_Width/375)));
                
        }];
    //定位图片
    UIImageView *navigationimage = [[UIImageView alloc] init];
    navigationimage.image=[UIImage imageNamed:@"ic_store_location"];
    [self addSubview:navigationimage];
    [navigationimage  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lookstar.mas_bottom).equalTo(@(12*(kScreen_Width/375)));
        make.left.equalTo(doorview.mas_right).equalTo(@(15*(kScreen_Width/375)));
        make.width.equalTo(@(10*(kScreen_Width/375)));
        make.height.equalTo(@(10*(kScreen_Width/375)));
    }];
    //距离标签
    UILabel *distance= [[UILabel alloc] init];
    distance.font = [UIFont systemFontOfSize:10*(kScreen_Width/375)];
    distance.text=@"距您0.8KM";
    distance.textColor=[UIColor colorWithHex:0x585858];
    [self.contentView addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationimage.mas_top);
        make.left.equalTo(navigationimage.mas_right).equalTo(@1);
    }];
    //地图导航定位按钮
    UIButton * mapbtn=[[UIButton alloc]init];
    [mapbtn setTitle:@"导航" forState:UIControlStateNormal];
    [mapbtn setTitleColor:[UIColor colorWithHex:0x67a7e3] forState:UIControlStateNormal];
    mapbtn.titleLabel.font=[UIFont systemFontOfSize:13*(kScreen_Width/375)];;
//    [mapbtn addTarget:self action:@selector(mapbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:mapbtn];
    [mapbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-16*(kScreen_Width/375)));
        make.right.equalTo(@(-8*(kScreen_Width/375)));
        
    }];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
