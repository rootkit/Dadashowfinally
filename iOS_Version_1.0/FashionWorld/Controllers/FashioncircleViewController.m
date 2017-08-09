//
//  FashioncircleViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/28.
//  Copyright © 2017年 李萍. All rights reserved.
//

/*******   发布动态  *****/
#import "FashioncircleViewController.h"
#import "UIColor+CustomColor.h"
#import "UIColorHF.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
#import "Commpresmp4.h"
#import "DaHttpTool.h"
#import "DDXAPI.h"
#import "HXVideoview.h"
#import "Loadingview.h"
@interface FashioncircleViewController ()<UITextViewDelegate,HXPhotoViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentCtl;
@property (nonatomic,weak) UITextView *textView;
@property (nonatomic,weak) UITextView *videotextView;
@property (nonatomic ,weak) UILabel *placeholderLabel;
@property (nonatomic ,weak) UILabel *videoplaceholderLabel;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoManager *videomanager;
@property (nonatomic, weak) UIView* videoview;

@property (nonatomic, weak) UIView* photoview;
@property (nonatomic, weak) UIView* allview;

@property (nonatomic, strong) NSMutableArray *postImages;
@property(nonatomic,strong)AVAsset* videoavasset;
@end

@implementation FashioncircleViewController

- (id)init
{
    self = [super init];
    if (self) {
        _postImages = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =         NO;
    self.view.backgroundColor=[UIColor whiteColor];
    [self sendpostvideoview];
    [self sendvideoview];
    [self sendphotoview];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(postAction)];
}
- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
               _manager.openCamera = YES;
        _manager.outerCamera= NO;
    }
    return _manager;
}

- (HXPhotoManager *)videomanager
{
    if (!_videomanager) {
        _videomanager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
              _manager.openCamera = NO;
        _videomanager.outerCamera = NO;
    }
    return _videomanager;
}

#pragma mark - back action
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//文字
- (void)postAction
{
    MBProgressHUD *HUD = [Util createHUD];
    HUD.labelText = @"正在发表动态";
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", DDXAPI_HTTP_PREFIX_Friend, DDXAPI_SHOPFRIEND_SR];
    NSMutableDictionary *paras = @{//判断图片和文字
                                   @"publishType"  : (_segmentCtl.selectedSegmentIndex == 0) ?
                                   ((_postImages.count) ? @(2) : @(1)) : @(3), //发布动态类型 1、文字 2、图片 3、视频
                                   @"publishTitle" : @"动态",
                                   @"type"         : @(0), //0、用户发布1、商家发布
                                   @"publishId"    : @([DDXUserinfo getUserId]), // 商家ID或用户ID
                                   @"praiseNum"    : @(0),
                                   @"browseNum"    : @(0),
                                   @"forwardNum"   : @(0),
                                   @"content"      :  (_segmentCtl.selectedSegmentIndex == 0) ?_textView.text:_videotextView.text,
                                   @"createUser"   : @([DDXUserinfo getUserId]) //创建人 默认当前人
                                   }.mutableCopy;
    
    if (_segmentCtl.selectedSegmentIndex == 0) {
        
        if (_postImages.count) {//图片
            [DaHttpTool postImageArray:_postImages
                                andUrl:[NSString stringWithFormat:@"%@%@", strUrl, DDXAPI_SHOPFRIEND_SR_CF_UPLOADINFO]
                                params:paras
                               success:^(id json) {
                                    //
                                    NSLog(@"上传图片返回回来的数据json==== %@", json);
                                   
                                   if ([json[@"state"] isEqualToString:@"success"]) {
                                       HUD.mode = MBProgressHUDModeCustomView;
                                       HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_success"]];
                                       HUD.labelText = @"已经完成发布";
                                       [HUD hide:YES afterDelay:5];
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [self.navigationController popViewControllerAnimated:YES];
                                       });
                                   } else {
                                       HUD.mode = MBProgressHUDModeCustomView;
                                       HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_fail"]];
                                       HUD.labelText = @"发布失败";
                                       
                                       [HUD hide:YES afterDelay:5];
                                   }
            } failure:^(NSError *error) {
                //
                NSLog(@"error === %@", error);
                HUD.mode = MBProgressHUDModeCustomView;
                HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                
                [HUD hide:YES afterDelay:5];
            }];
        } else {//文字
            [DaHttpTool post:[NSString stringWithFormat:@"%@%@", strUrl, DDXAPI_SHOPFRIEND_SR_CF_ADD]
                      params:paras
                     success:^(id json) {
                         //
                         NSLog(@"json==== %@", json);
                         if ([json[@"state"] isEqualToString:@"success"]) {
                             HUD.mode = MBProgressHUDModeCustomView;
                             HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_success"]];
                             HUD.labelText = @"已经完成发布";
                             [HUD hide:YES afterDelay:5];
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 [self.navigationController popViewControllerAnimated:YES];
                             });
                         } else {
                             HUD.mode = MBProgressHUDModeCustomView;
                             HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_fail"]];
                             HUD.labelText = @"发布失败";
                             
                             [HUD hide:YES afterDelay:5];
                         }
                     } failure:^(NSError *error) {
                         //
                         NSLog(@"error === %@", error);
                         HUD.mode = MBProgressHUDModeCustomView;
                         HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
                         
                         [HUD hide:YES afterDelay:5];
                     }];
        }
    } else {
        //视频
        NSLog(@"%@",_videoavasset);
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.color=[UIColor clearColor];
        hud.dimBackground=NO;//四周的渐变效果
        hud.mode = MBProgressHUDModeCustomView;
        Loadingview* lovc=[[Loadingview alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        hud.customView=lovc;//发布视频涉及到视频压缩的时候必须提前显示这个loading动画
        [Commpresmp4 compressedVideoOtherMethodWithURL:_videoavasset compressionType:AVAssetExportPresetMediumQuality  compressionResultPath:^(NSString *resultPath) {
           NSLog(@"压缩视频路径%@",[NSHomeDirectory() stringByAppendingFormat:@"/Documents/CompressionVideoField"]);
           NSData* upData=[NSData dataWithContentsOfFile:resultPath];
           NSLog(@"视频nadata=%@",upData);
           NSLog(@"=%lu",(unsigned long)upData.length);
           [DaHttpTool postvideo:upData
                          andUrl:[NSString stringWithFormat:@"%@%@", strUrl, DDXAPI_SHOPFRIEND_SR_CF_UPLOADINFO]
                          params:paras
                         success:^(id json) {
                             NSLog(@"上传视频成功返回回来的数据%@",json);
                             
                             if ([json[@"state"] isEqualToString:@"success"]) {
                                 HUD.mode = MBProgressHUDModeCustomView;
                                 HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_success"]];
                                 HUD.labelText = @"已经完成发布";
                                 [HUD hide:YES afterDelay:5];
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [self.navigationController popViewControllerAnimated:YES];
                                 });
                             } else {
                                 HUD.mode = MBProgressHUDModeCustomView;
                                 HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fashion_post_fail"]];
                                 HUD.labelText = @"发布失败";
                                 
                                 [HUD hide:YES afterDelay:5];
                             }
                             //上传成功后记得删除沙盒里面的视频文件
                             [Commpresmp4 removeCompressedVideoFromDocuments];
    
           } failure:^(NSError *error) {
                NSLog(@"请求失败%@",error);
               
               NSLog(@"error === %@", error);
               HUD.mode = MBProgressHUDModeCustomView;
               HUD.labelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
               
               [HUD hide:YES afterDelay:5];
            }];
        }];
     }
}


-(void)sendpostvideoview{
    
    _segmentCtl = [[UISegmentedControl alloc] initWithItems:@[@"图文", @"视频"]];
    _segmentCtl.frame = CGRectMake(0, 0, 160, 28);
    _segmentCtl.backgroundColor = [UIColor whiteColor];
    _segmentCtl.layer.cornerRadius = 2;
    _segmentCtl.selectedSegmentIndex = 0;
//    [self myAction:0];
    self.navigationItem.titleView = _segmentCtl;
    _segmentCtl.tintColor =[UIColor grayColor];
    
    
    [_segmentCtl addTarget:self
                   action:@selector(myAction:)
                      forControlEvents:UIControlEventValueChanged];
    
    
    
    
}
-(void)myAction:(UISegmentedControl *)Seg {
    
    NSInteger index=Seg.selectedSegmentIndex;
    UIView* chooseview=nil;

    switch (index) {
        case 0:
            NSLog(@"发送图文");
            chooseview=_photoview;
            _manager.maxNum=5;
            _manager.photoMaxNum=6;
            _manager.type=HXPhotoManagerSelectedTypePhoto;//这个对象是个单利
            _manager.selectTogether=NO;
            
        
            break;
        case 1:
            NSLog(@"发送视频");
            chooseview=_videoview;
            _videomanager.maxNum=1;
            _videomanager.photoMaxNum=1;
            _videomanager.type= HXPhotoManagerSelectedTypeVideo;
            _videomanager.openCamera=NO;
            _videomanager.selectTogether=NO;
      
            break;
            
        default:
            break;
    }
    if (chooseview) {
        [self.view bringSubviewToFront:chooseview];
    }
}
-(void)sendphotoview{
    UIView* photoview=[[UIView alloc]init];
    photoview.frame=CGRectMake(0, 64,kScreen_Width, kScreen_Height);
   photoview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:photoview];
    _photoview=photoview;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200-64)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont boldSystemFontOfSize:15.0f];
    textView.delegate = self;
    [_photoview addSubview:textView];
    _textView = textView;
    //自定义placeholder
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16,20, kScreen_Width-16, 112)];
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:14.0];
    label.text = @"说些什么吧...";
    label.textColor =[UIColor grayColor];
    [_textView addSubview:label];
    [label sizeToFit];
    _placeholderLabel = label;
    HXPhotoView *hphotoView = [HXPhotoView photoManager:self.manager];
    hphotoView.frame = CGRectMake(12, 200, kScreen_Width - 24, 0);
    hphotoView.delegate = self;
    _manager.maxNum=5;
    _manager.photoMaxNum=6;
    _manager.type=HXPhotoManagerSelectedTypePhoto;//这个对象是个单利
    _manager.selectTogether=NO;
//    hphotoView.backgroundColor = [UIColor redColor];
    [_photoview addSubview:hphotoView];
  

}

-(void)sendvideoview{
    UIView* videoview=[[UIView alloc]init];
    videoview.frame=CGRectMake(0, 64,kScreen_Width, kScreen_Height);
    videoview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:videoview];
    _videoview=videoview;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200-64)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont boldSystemFontOfSize:15.0f];
    textView.delegate = self;
    [_videoview addSubview:textView];
    _videotextView = textView;
    //自定义placeholder
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16,20, kScreen_Width-16, 112)];
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:14.0];
    label.text = @"说些什么吧...";
    label.textColor =[UIColor grayColor];
    [_videotextView addSubview:label];
    [label sizeToFit];
    _videoplaceholderLabel = label;
    HXVideoview *hphotoView = [HXVideoview photoManager:self.videomanager];
      hphotoView.frame = CGRectMake(12, 200, kScreen_Width - 24, 0);
    hphotoView.delegate = self;
    [_videoview addSubview:hphotoView];

}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_placeholderLabel||_videoplaceholderLabel) {
        _placeholderLabel.hidden = YES;
        _videoplaceholderLabel.hidden = YES;

    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_textView.isFirstResponder||_videotextView.isFirstResponder) {
        [_textView resignFirstResponder];
        [_videotextView resignFirstResponder];
    }
    
}

-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"输出的内容%@",textView.text);
}

- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
   
    
    
    if (photos.count) {
         NSLog(@"%ld - %ld - %ld",allList.count,photos.count,videos.count);
        // 获取数组里面图片原图的 imageData 资源 传入的数组里装的是 HXPhotoModel  -- 这个方法必须写在点击上传的位置
        [HXPhotoTools fetchImageDataForSelectedPhoto:photos completion:^(NSArray<NSData *> *imageDatas) {
            NSLog(@"%ld",imageDatas.count);
        }];
        
        //  获取数组里面图片的原图 传入的数组里装的是 HXPhotoModel  -- 这个方法必须写在点击上传的地方获取 此方法会增大内存. 获取原图图片之后请将选中数组中模型里面的数据全部清空
        [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
            NSLog(@"上传的图片image数组%@",images);
            
            _postImages  = images.mutableCopy;
        }];
       
    }else{
        [_postImages removeAllObjects];
    }
    //上传视频的时候
    [videos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        //        // 视频封面
        //        model.thumbPhoto;
        NSLog(@"视频路径%@",model.avAsset);
        _videoavasset=model.avAsset;
        
        
    }];
}

- (void)photoViewUpdateFrame:(CGRect)frame WithView:(UIView *)view
{
    NSLog(@"%@",NSStringFromCGRect(frame));
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
