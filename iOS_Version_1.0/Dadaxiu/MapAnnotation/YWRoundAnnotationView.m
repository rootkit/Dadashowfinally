//
//  YWRoundAnnotationView.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/23.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "YWRoundAnnotationView.h"

#define kCalloutWidth   170*(kScreen_Height/667)
#define kCalloutHeight  70*(kScreen_Height/667)
@interface YWRoundAnnotationView(){
    
    UILabel          *_titleLable;
    UILabel          *_addresslabel;
}
@end
@implementation YWRoundAnnotationView

-(instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        [self setBounds:CGRectMake(-kCalloutWidth/3,  -100*(kScreen_Height/667), kCalloutWidth, 100*(kScreen_Height/667))];
        
        self.backgroundColor=[UIColor clearColor];
        [self initWithContentViews];//
    }
    
    return self;
}
-(void)initWithContentViews{
    //    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    //    [view setBackgroundColor:[ UIColor  redColor]];
    //    _contentView=view;
    //    [self addSubview:view];
    
    //        UIImageView* imageview=[UIImageView new];
    //        imageview.image=[UIImage imageNamed:@"datozhen"];
    //        imageview.frame=CGRectMake(0, 0,18, 18);
    //        imageview.center=CGPointMake(kCalloutWidth/6,imageview.bounds.size.height/2);
    //        [self addSubview: imageview];
    //        imageview.userInteractionEnabled=YES;
    UIImageView* backimageview=[UIImageView new];
    backimageview.image=[UIImage imageNamed:@"popup"];
    backimageview.frame=CGRectMake(0, 0,kCalloutWidth, kCalloutHeight);
    backimageview.center = CGPointMake(kCalloutWidth/3,-kCalloutHeight/2);
    [self addSubview: backimageview];
    backimageview.userInteractionEnabled=YES;
    
    UILabel *lable=[[UILabel alloc] init];
    lable.textColor=[UIColor colorWithHex:0x000000];
    lable.font=[ UIFont systemFontOfSize:13*(kScreen_Height/667)];
    _titleLable=lable;
    [backimageview addSubview:lable];
    
    UIImageView* shopimageview=[UIImageView new];
    shopimageview.image=[UIImage imageNamed:@"yuan"];
    shopimageview.frame=CGRectMake(0, 0,80*(kScreen_Height/667), 80*(kScreen_Height/667));
    shopimageview.center = CGPointMake(kCalloutWidth/3,-85*(kScreen_Height/667));
    [self addSubview:shopimageview];
    shopimageview.userInteractionEnabled=YES;
    _shopimageview=shopimageview;
    
    UILabel *addresslable=[[UILabel alloc] init];
    addresslable.textColor=[UIColor colorWithHex:0x000000];;
    addresslable.font=[ UIFont systemFontOfSize:13*(kScreen_Height/667)];
    _addresslabel=addresslable;
  

    [backimageview addSubview:addresslable];
    
    
}

-(void)setTitleText:(NSString *)titleText{
    
    _titleLable.text=titleText;
    //计算高度
    CGFloat Width = [titleText sizeWithFont:[UIFont systemFontOfSize: 13*(kScreen_Height/667)] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21*(kScreen_Height/667)) lineBreakMode:NSLineBreakByWordWrapping].width;
    
    [_titleLable setFrame:CGRectMake(10*(kScreen_Height/667),7*(kScreen_Height/667), Width, 22*(kScreen_Height/667))];
    
    
}

-(void)setAddressText:(NSString *)addressText{
    _addresslabel.text=addressText;
    CGFloat Width = [addressText sizeWithFont:[UIFont systemFontOfSize: 13*(kScreen_Height/667)] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21*(kScreen_Height/667)) lineBreakMode:NSLineBreakByWordWrapping].width;
    
    [_addresslabel setFrame:CGRectMake(10*(kScreen_Height/667),30*(kScreen_Height/667), Width, 22*(kScreen_Height/667))];
}


@end
