//
//  UISearchBar+JCSearchBarPlaceholder.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/31.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "UISearchBar+JCSearchBarPlaceholder.h"

@implementation UISearchBar (JCSearchBarPlaceholder)
-(void)changeLeftPlaceholder:(NSString *)placeholder {
    self.placeholder = placeholder;
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}
@end
