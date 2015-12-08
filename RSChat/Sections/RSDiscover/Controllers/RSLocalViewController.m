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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的人";

    [self.mgr requestWhenInUseAuthorization];
    
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    self.mapView.mapType = MKMapTypeStandard; // 地图样式（标准、卫星、混合）
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

#pragma mark - 
/**
 * 定位（定位成功时调用此方法）
 1.设置大头针的title和subtitle（使用反地理编码）
 2.设置地图显示的区域（中心、跨度）
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks lastObject];
        userLocation.title = placemark.name;
        userLocation.subtitle = placemark.locality;
    }];
    
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - 添加大头针
/**
 * 添加大头针
 1.创建大头针对象
 2.设置属性：coordinate/title/subtitle/image
 3.添加到mapView上
 4.设置地图显示的区域（中心、跨度）（以一个大头针的位置为中心）
 */
- (IBAction)addAnnotation:(UIButton *)sender {
    RSAnnotation *firstAnnotation = [[RSAnnotation alloc] init];
    firstAnnotation.coordinate = CLLocationCoordinate2DMake(39.875, 116.456);
    firstAnnotation.title = @"测试点1";
    firstAnnotation.subtitle = @"人生无非是笑笑人家，再被人家笑笑而已。";
    firstAnnotation.image = [UIImage imageNamed:@"icon_mark1"];
    [self.mapView addAnnotation:firstAnnotation];
    
    RSAnnotation *secondAnnotation = [[RSAnnotation alloc] init];
    secondAnnotation.coordinate = CLLocationCoordinate2DMake(39.879, 116.451);
    secondAnnotation.title = @"测试点2";
    secondAnnotation.subtitle = @"为梦想的起航，永远都不算太晚。";
    secondAnnotation.image = [UIImage imageNamed:@"icon_mark2"];
    [self.mapView addAnnotation:secondAnnotation];
    
    CLLocationCoordinate2D center = secondAnnotation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}

/**
 * 自定义大头针
 1.实现自定义大头针的功能，必须实现下面的代理方法
 2.地图上有多少个大头针，就会调用多少次
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    // 重用机制
    static NSString *identifier = @"annotationView";
    MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
    }
    
    RSAnnotation *anno = (RSAnnotation *)annotation;
    annotationView.annotation = anno;
    annotationView.image = anno.image;
    
    return annotationView;
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
