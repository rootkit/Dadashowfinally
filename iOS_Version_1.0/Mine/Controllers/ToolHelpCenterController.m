//
//  ToolHelpCenterController.m
//  iOS_Version_1.0
//
//  Created by ping_L on 2017/5/27.
//  Copyright © 2017年 李萍. All rights reserved.
//

/********  必选工具-客服与帮助页面 *********/
#import "ToolHelpCenterController.h"

@interface ToolHelpCenterController ()

@end

@implementation ToolHelpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客服与帮助";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
