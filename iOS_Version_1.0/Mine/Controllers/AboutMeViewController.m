//
//  AboutMeViewController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/29.
//  Copyright © 2017年 李萍. All rights reserved.
//

/***** 关于我们 ****/
#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSArray *descArray;
@property (nonatomic, assign) NSInteger descIndex;

@end

@implementation AboutMeViewController

- (instancetype)initWithTitle:(NSString *)title descText:(NSInteger)descIndex
{
    self = [super init];
    if (self) {
        self.title = title;
        self.descIndex = descIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.descArray = @[@"       搭搭秀APP，是深圳市前海新体验科技有限公司研发的一款女性购物APP，是一个集时尚品牌、潮流穿搭、游戏养宠、衣橱管理、设计定制等功能于一体的购物、社交、娱乐三合一电商平台，主要面向年轻时尚的都市潮流人群。汇聚最多最优质的时尚品牌；每天为你推荐最in的潮流搭配指南；满足年轻时尚爱美女性的购物需求；以未来的生活方式主导购物模式，让消费者在网上购物的过程中享受超越以往的超级体验；真正实现线上线下结合，打造“电商”与“店商”完美融合的新零售模式。搭搭秀APP，为服装行业插上飞翔的翅膀。",
                       @""];
    NSString *string = self.descArray[self.descIndex];
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *parag = [NSMutableParagraphStyle new];
    [parag setLineSpacing:5.f];
    [mutableAttr addAttribute:NSParagraphStyleAttributeName value:parag range:NSMakeRange(0, string.length)];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:15];
    textView.textColor = FirstTextColor;
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.attributedText = mutableAttr;

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
