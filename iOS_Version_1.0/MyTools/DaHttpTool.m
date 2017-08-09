//
//  DaHttpTool.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/4/20.
//  Copyright © 2017年 李萍. All rights reserved.
//

#import "DaHttpTool.h"
#import "AFNetworking.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
#import "Loadingview.h"
//#define HttpUrl [http stringByAppendingString:url]
//#define ConnectUrl HttpUrl

@implementation DaHttpTool



+ (void)post:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
  
    [self setloadingview];
    // 1.创建请求管理者
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求数据格式为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//响应数据格式
    manager.requestSerializer.timeoutInterval = 10.0;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json",@"text/javascript", nil]];


    
    // 2.发送请求
    [manager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
            }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];

     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
      }];
}

+ (void)get:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    [self setloadingview];

    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json",@"text/javascript", nil]];

    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if (success) {
            success(responseObject);
        }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
      
            failure(error);
        }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
       
    }];   
}

//Nsdata格式请求体
+ (void)postAfhttp:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    // 1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求数据格式为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//响应数据格式
//         manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json",@"text/javascript", nil]];
    
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if (success) {
            success(responseObject);
        }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
        
    }];
}


+ (void)postImageArray:(NSArray *)imageArray andUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {

     [self setloadingview];
     AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    //发送给服务器的格式(请求格式)
      manager.requestSerializer = [AFJSONRequestSerializer serializer];//json格式
    //响应服务器返回数据回来的格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//json格式
    manager.requestSerializer.timeoutInterval = 30.0;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json",@"text/javascript", nil]];
    
     NSLog(@"url==%@",url);
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"数据格式%@",formData);
      
        if(imageArray.count>0)
        {
            for(NSInteger i=0; i<imageArray.count; i++)
            {
                UIImage *eachImg = [imageArray objectAtIndex:i];
                
//                NSData *eachImgData = UIImageJPEGRepresentation(eachImg, 0.3);
                
                if (i == 0) {
                    [formData appendPartWithFileData:[self compressImage:eachImg] name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
                }
                else {
                    
                    [formData appendPartWithFileData:[self compressImage:eachImg] name:[NSString stringWithFormat:@"file%ld", i] fileName:[NSString stringWithFormat:@"file%ld.jpg", i] mimeType:@"image/jpeg"];
                }
            }
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
            NSLog(@"%@",responseObject);
            }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
    }];
}

+ (NSData *)compressImage:(UIImage *)image
{
    CGSize size = [self scaleSize:image.size];
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSUInteger maxFileSize = 500 * 1024;
    CGFloat compressionRatio = 0.7f;
    CGFloat maxCompressionRatio = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, compressionRatio);
    
    while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio) {
        compressionRatio -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compressionRatio);
    }
    
    return imageData;
}

+ (CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height) {
        return CGSizeMake(800, 800 * height / width);
    } else {
        return CGSizeMake(800 * width / height, 800);
    }
}



+ (void)postvideo:(NSData *)videodata andUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    NSLog(@"连接%@",url);
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json",@"text/javascript", nil]];

    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        [formData appendPartWithFileData:videodata
                                    name:@"videoJF"
                                fileName:@"video1.mp4"
                                mimeType:@"video/quicktime"];
       NSLog(@"=%@",formData);
      

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
         success(responseObject);
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       failure(error);
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
        
    }];
}
+(void)setloadingview{
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//    hud.color=[UIColor whiteColor];
//    hud.dimBackground=NO;//四周的渐变效果
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.minSize = CGSizeMake(kScreen_Width, kScreen_Height);
//    Loadingview* lovc=[[Loadingview alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
//    lovc.backgroundColor=[UIColor whiteColor];
//    hud.customView=lovc;
}

@end
