//
//  VideoAvplayerViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/5/4.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "VideoAvplayerViewController.h"
#import "HcdCachePlayer.h"
@interface VideoAvplayerViewController ()
@property(nonatomic,strong)HcdCacheVideoPlayer *play;
@end

@implementation VideoAvplayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.title=@"视频播放";
    _play = [[HcdCacheVideoPlayer alloc]init];
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2-([UIScreen mainScreen].bounds.size.width * 0.5625)/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
    [self.view addSubview:videoView];
    
    [_play playWithUrl:[NSURL URLWithString:self.videostr]
              showView:videoView
          andSuperView:self.view
             withCache:YES];
    
    NSLog(@"%f", [HcdCacheVideoPlayer allVideoCacheSize]);
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_play stop];
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
