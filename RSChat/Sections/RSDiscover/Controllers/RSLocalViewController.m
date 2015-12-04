//
//  RSLocalViewController.m
//  RSChat
//
//  Created by hehai on 11/29/15.
//  Copyright © 2015 hehai. All rights reserved.
//

#import "RSLocalViewController.h"
#import <MapKit/MapKit.h>
#import "RSAnnotation.h"

// 这里将附近的人设计成一个给自己定位的功能
@interface RSLocalViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *mgr;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation RSLocalViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的人";
    
    [self.mgr requestWhenInUseAuthorization];
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    NSLog(@"经度:%lf, 纬度:%lf", userLocation.location.coordinate.longitude, userLocation.location.coordinate.latitude);
    
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks lastObject];
        userLocation.title = placemark.name;
        userLocation.subtitle = placemark.locality;
    }];
    
    // 地图显示的区域
    // 1.中心
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 2.跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - 添加大头针
/*
 1.创建
 2.设置经纬度/title/subtitle
 3.添加到mapView上
 */
- (IBAction)addAnnotation:(UIButton *)sender {
    RSAnnotation *firstAnnotation = [[RSAnnotation alloc] init];
    firstAnnotation.coordinate = CLLocationCoordinate2DMake(39.875, 116.456);
    firstAnnotation.title = @"测试点1";
    firstAnnotation.subtitle = @"测试点1的相关信息";
    [self.mapView addAnnotation:firstAnnotation];
    
    RSAnnotation *secondAnnotation = [[RSAnnotation alloc] init];
    secondAnnotation.coordinate = CLLocationCoordinate2DMake(39.879, 116.451);
    secondAnnotation.title = @"测试点2";
    secondAnnotation.subtitle = @"测试点2的相关信息";
    [self.mapView addAnnotation:secondAnnotation];
    
    // 地图显示的区域（以一个大头针的位置为中心）
    // 1.设置地图的中心
    CLLocationCoordinate2D center = secondAnnotation.coordinate;
    // 2.设置跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}

/*
 1.实现自定义大头针的功能，必须实现下面的代理方法
 2.地图上有多少个大头针，就会调用多少次
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSLog(@"添加大头针");
    //5.如果nil: 系统会自动的将用户的位置设定为蓝色; 否则就会按照自定义的大头针视图添加
    //判定是用户位置的大头针(设定成蓝色)
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //3.重用机制
    static NSString *identifier = @"annotation";
    //从缓存池中获取
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pinAnnotationView) {
        //4.第一个参数nil:初始化的时候无法确定使用哪个大头针
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
        //6.手动设置大头针视图的布局属性(点击时显示title和subtitle)
        pinAnnotationView.canShowCallout = YES;
        //7.设置大头针视图左右的图片/控件
        pinAnnotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_classify_cafe"]];
        pinAnnotationView.rightCalloutAccessoryView = [[UISwitch alloc] init];
    }
    
    //设置大头针颜色属性
    pinAnnotationView.pinColor = MKPinAnnotationColorPurple;
    //添加从天而降的动画效果
//    pinAnnotationView.animatesDrop = YES;
    //8.设置大头针视图的图片(不能和动画一起设置)
#warning TODO 给大头针设置的图片无法显示
    pinAnnotationView.canShowCallout = YES;
    pinAnnotationView.image = [UIImage imageNamed:@"icon_classify_cafe"];
    //大头针视图的annotation属性(因为创建的时候给定nil)
    pinAnnotationView.annotation = annotation;
    
    return pinAnnotationView;
}

#pragma mark - setter getter

- (CLLocationManager *)mgr {
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}

- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
