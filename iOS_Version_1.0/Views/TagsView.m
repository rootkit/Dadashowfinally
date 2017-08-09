//
//  TagsView.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/2.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "TagsView.h"
#import "UIColorHF.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

#define cell_padding_left 12
#define cell_padding_right cell_padding_left
#define cell_padding_top 10
#define cell_padding_bottom cell_padding_top

#define tagButton_H 22
#define tag_padding 6

@interface TagsView ()

@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation TagsView

- (instancetype)initWithMoreTags:(NSArray *)tags
{
    self = [super init];
    if (self) {
        //
        _btnArray = [NSMutableArray new];
        [self layoutTagButtonMoreTags:tags];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutTagButtonMoreTags:(NSArray *)tags
{
    __block CGFloat viewHeight = 0;
    [tags enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL * _Nonnull stop) {
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton new];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
//        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 10;
//        btn.layer.shouldRasterize = YES;
        btn.tag = idx+1;
        
        CGSize rectSize = (CGSize)[string boundingRectWithSize:CGSizeMake(kScreenW - cell_padding_left - cell_padding_right, tagButton_H)
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil].size;
        if (idx == 0)
        {
            btn.frame =CGRectMake(cell_padding_left, cell_padding_top, rectSize.width+10, tagButton_H);
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = ThemeColor;
        } else {
            [btn setTitleColor:[UIColor colorWithHex:0x343434] forState:UIControlStateNormal];
            btn.backgroundColor =  (idx == 3 ? [UIColor colorWithHex:0xE9E9E9] : [UIColor colorWithHex:0xFFE4E7]);
            
            CGFloat yuWidth = kScreenW - cell_padding_left - cell_padding_right - tag_padding - recordBtn.frame.origin.x -recordBtn.frame.size.width;
            if (yuWidth >= rectSize.width) {
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + tag_padding, recordBtn.frame.origin.y, rectSize.width+10, tagButton_H);
            } else {
                btn.frame =CGRectMake(cell_padding_left, recordBtn.frame.origin.y+recordBtn.frame.size.height + tag_padding, rectSize.width+10, tagButton_H);
            }
        }
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:string forState:UIControlStateNormal];
        [_btnArray addObject:btn];
        [self addSubview:btn];
        
        recordBtn = btn;
        viewHeight = recordBtn.frame.origin.y+recordBtn.frame.size.height + tag_padding;
    }];
    
    _rowHeight = viewHeight;
    
    self.frame = (CGRect){{0, 0}, {kScreenW, _rowHeight}};
}

#pragma mark - clickAction
- (void)clickAction:(UIButton *)btn
{
    [self selectedBtnChangeBGColor:btn.tag-1];
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectBtnClickAction:)]) {
        [_delegate selectBtnClickAction:btn.tag];
    }
}


- (void)selectedBtnChangeBGColor:(NSInteger)index
{
    [_btnArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //
        if (index == idx) {
            [obj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            obj.backgroundColor = ThemeColor;
        } else {
            [obj setTitleColor:[UIColor colorWithHex:0x343434] forState:UIControlStateNormal];
            obj.backgroundColor =  (idx == 3 ? [UIColor colorWithHex:0xE9E9E9] : [UIColor colorWithHex:0xFFE4E7]);
        }
        
    }];
}

@end
