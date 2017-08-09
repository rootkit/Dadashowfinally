//
//  DIYWebController.h
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/6/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PetJSExport <JSExport>


- (void)push:(NSString *)str;

@end

@interface DIYWebController : UIViewController

- (instancetype)initWithUrl:(NSString *)url;

@end
