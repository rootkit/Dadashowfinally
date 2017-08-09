//
//  DDXMapLocationViewController.m
//  iOS_Version_1.0
//
//  Created by liping on 2017/6/23.
//  Copyright © 2017年 李萍. All rights reserved.
//
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import "YWRoundAnnotationView.h"
#import "DDXMapLocationViewController.h"
#import "DoorchooseViewController.h"
@interface DDXMapLocationViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView                   *_mapView;//地图对象
    BMKLocationService           *_locationService;//定位
}
@property(nonatomic,copy)NSArray* brandnamearray;
@property(nonatomic,copy)NSArray* latitudearray;
@property(nonatomic,copy)NSArray* longitudearray;
@property(nonatomic,copy)NSArray* addressarray;
@end

@implementation DDXMapLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.brandnamearray=@[@"茜诗迪",@"茜诗迪",@"茜诗迪",@"慕托丽",@"慕托丽",@"WONDERFUL",@"WONDERFUL",@"WONDERFUL"];
    self.latitudearray=@[@"22.572297",@"22.584299",@"22.763878",@"22.660503",@"22.554447",@"22.55034",@"22.507919",@"22.726244"];
    self.longitudearray=@[@"113.908302",@"113.901137",@"113.949529",@"114.02735",@"114.124511",@"114.120702",@"113.929851",@"113.836227"];
    self.addressarray=@[@"香缤广场1层",@"前进一路309-3",@"光翠路南10号附近",@"美丽AAA大厦",@"新园路17号F4层",@"和平路3009号",@"南海大道10901",@"中心路32号 "];
    self.navigationItem.title=@"门店";
    self.view.backgroundColor=[UIColor whiteColor];
    [self initMapView];//初始化地图
//   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"普通模式" style:UIBarButtonItemStylePlain target:self action:@selector(pushnonmelshop)];
    [self initlocationService];
    [self SetBasicLocation];
   
}




-(void)pushnonmelshop{
    
    DoorchooseViewController* doorvc=[DoorchooseViewController new];
    [self.navigationController pushViewController:doorvc animated:YES];
    
    
}

#pragma mark --private Method--根据关键字检索
-(void)SetBasicLocation{
    
    NSLog(@"%@",self.brandnamearray);
    for (int i=0; i<self.brandnamearray.count; i++) {
       
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [self.latitudearray[i] doubleValue];
        NSLog(@"%f",[self.latitudearray[i] doubleValue]);
        coor.longitude =[self.longitudearray[i] doubleValue];
        annotation.coordinate = coor;
        annotation.subtitle=self.addressarray[i];
        annotation.title=self.brandnamearray[i];
        [_mapView addAnnotation:annotation];
        [_mapView mapForceRefresh];
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [ super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate=nil;
    _mapView=nil;
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [ super viewWillAppear:animated];
    [_mapView viewWillAppear];
   
    
}
#pragma mark --private Method--初始化地图
-(void)initMapView{
    
    BMKMapView  *mapView=[[ BMKMapView alloc] initWithFrame:self.view.frame];
    mapView.mapType=BMKMapTypeStandard;
    mapView.userTrackingMode=BMKUserTrackingModeFollowWithHeading;
    mapView.zoomLevel=14;
    mapView.buildingsEnabled =YES;
    mapView.rotateEnabled=NO;
    mapView.minZoomLevel=10;
    mapView.delegate=self;
    //mapView.compassPosition=CGPointMake(0, 100);
    //mapView.showMapScaleBar=YES;
    [self.view addSubview:mapView];
    _mapView=mapView;
    //[_mapView setCompassPosition:CGPointMake(180,200)];
    [_mapView setCompassImage:[UIImage imageNamed:@"yuan"]];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    
    // BMKPinAnnotationView *newAnnotationViews = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    
    YWRoundAnnotationView *newAnnotationView =(YWRoundAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"RoundmyAnnotation"];
    if (newAnnotationView==nil)
    {
        newAnnotationView=[[ YWRoundAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"RoundmyAnnotation"];
    }
    BMKPointAnnotation* Newannotation=(BMKPointAnnotation*)annotation;
//    newAnnotationView.image=[UIImage imageNamed:@"adidas-neo"];
    newAnnotationView.titleText=[NSString stringWithFormat:@"%@",Newannotation.title];
    newAnnotationView.addressText=[NSString stringWithFormat:@"%@",Newannotation.subtitle];
    newAnnotationView.canShowCallout = NO;
    newAnnotationView.draggable = NO;
    //newAnnotationViews.paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView: newAnnotationView];
    return newAnnotationView;
    
}


#pragma mark --private Method--定位
-(void)initlocationService{
    
    _locationService=[[BMKLocationService alloc] init];
    _locationService.desiredAccuracy=kCLLocationAccuracyBest;
    _locationService.delegate=self;
    _locationService.distanceFilter=1000;
    [_locationService startUserLocationService];
    
}

//*拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持

- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState
{
    
}

#pragma mark --private Method--当点击大头针时
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
      BMKPointAnnotation* Newannotation=(BMKPointAnnotation*)view.annotation;
    
    NSLog(@"选中大头针%@",Newannotation.title);
    
}

/*当点击annotation view弹出的泡泡时，调用此接口**/
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    
    
    
}

/*用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置**/
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    _mapView.showsUserLocation=YES;
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate];
    [_locationService stopUserLocationService];
    
}

/******************************************定位成功 *****************************************/
#pragma mark --private Method--定位成功
- (void)didFailToLocateUserWithError:(NSError *)error
{
    // [[[ UIAlertView alloc] initWithTitle:@"" message:@"定位失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil]show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
