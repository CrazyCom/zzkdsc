//
//  ZmapViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/13.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ZmapViewController.h"
#import "UIImage+Rotate.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

//@interface RouteAnnotation : BMKPointAnnotation
//{
//    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
//    int _degree;
//}
//
//@property (nonatomic) int type;
//@property (nonatomic) int degree;
//
//@end
//
//@implementation RouteAnnotation
//
//@synthesize type = _type;
//@synthesize degree = _degree;
//@end

@implementation ZmapViewController

- (instancetype)initWithExpress_id:(NSString *)expressId {
    
    if (self = [super init]) {
        
        _express_id = expressId;
        
    }
    return self;
}

//- (NSString*)getMyBundlePath1:(NSString *)filename
//{
//    
//    NSBundle * libBundle = MYBUNDLE ;
//    if ( libBundle && filename ){
//        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
//        return s;
//    }
//    return nil ;
//}


-(void)initializeDataSource {

    NSDictionary *dict = @{@"express_id":_express_id};
    [NetWorkHandler getExpressCoordinate:dict completionHandler:^(id content) {
        NSLog(@"getExpressCoordinate:%@",content);
        NSLog(@"lat:%lf,lon:%lf",[[AppDelegate app].lat doubleValue],[[AppDelegate app].lon doubleValue]);
        [self onClickReverseGeocode];
        
//        if (VALID_DICT(content)) {
//            
//            BMKUserLocation *userLocation = [[BMKUserLocation alloc]init];
//           
//            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([content[@"lat"] doubleValue], [content[@"lon"] doubleValue]);
////             userLocation.location.coordinate = ;
//            
//            BMKCoordinateSpan span = BMKCoordinateSpanMake(0.001, 0.001);
//            BMKCoordinateRegion region =  BMKCoordinateRegionMake(coord, span);
//            [mapView setRegion:region animated:YES];
////            [mapView updateLocationData:coord];
//
//        }
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeInterface];
    [self initializeDataSource];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [_mapView viewWillAppear];
    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
   

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [_mapView viewWillDisappear];
//    _mapView.delegate = nil; // 不用时，置nil
//    _routesearch.delegate = nil; // 不用时，置nil
//    _geocodesearch.delegate = nil; // 不用时，置nil
}

//- (void)dealloc {
//    if (_routesearch != nil) {
//        _routesearch = nil;
//    }
//    if (_mapView) {
//        _mapView = nil;
//    }
//}


- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"";
    
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    //
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _mapView.delegate = self;
    _mapView.backgroundColor = [UIColor grayColor];
//    _mapView.mapType = BMKMapTypeStandard;
//    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
     _geocodesearch = [[BMKGeoCodeSearch alloc]init];
//    [self onClickWalkSearch];
    
    _startAddrText = [[UITextField alloc]init];
    _startCityText = [[UITextField alloc]init];
    _endAddrText = [[UITextField alloc]init];
    _endCityText = [[UITextField alloc]init];
}

//- (void)onClickWalkSearch {
//    
//    BMKPlanNode* start = [[BMKPlanNode alloc]init];
//    start.name = _startAddrText.text;
//    start.cityName = @"北京市";
//    BMKPlanNode* end = [[BMKPlanNode alloc]init];
//    end.name = _endAddrText.text;
//    end.cityName = @"北京市";
//    
//    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
//    walkingRouteSearchOption.from = start;
//    walkingRouteSearchOption.to = end;
//    BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
//    if(flag)
//    {
//        NSLog(@"walk检索发送成功");
//    }
//    else
//    {
//        NSLog(@"walk检索发送失败");
//    }
//    
//
//}
//
- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
//    
//    
//}
//- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
//{
//    BMKAnnotationView* view = nil;
//    switch (routeAnnotation.type) {
//        case 0:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
//                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 1:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
//                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 2:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 3:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
//                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
//                view.canShowCallout = TRUE;
//            }
//            view.annotation = routeAnnotation;
//        }
//            break;
//        case 4:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
//                view.canShowCallout = TRUE;
//            } else {
//                [view setNeedsDisplay];
//            }
//            
//            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
//            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//            view.annotation = routeAnnotation;
//            
//        }
//            break;
//        case 5:
//        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
//            if (view == nil) {
//                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"];
//                view.canShowCallout = TRUE;
//            } else {
//                [view setNeedsDisplay];
//            }
//            
//            UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
//            view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//            view.annotation = routeAnnotation;
//        }
//            break;
//        default:
//            break;
//    }
//    
//    return view;
//}
//
//- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
//        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
//    }
//    return nil;
//}
//
//- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[BMKPolyline class]]) {
//        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
//        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
//        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
//        polylineView.lineWidth = 3.0;
//        return polylineView;
//    }
//    return nil;
//}
//
//
//- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
//{
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
//    array = [NSArray arrayWithArray:_mapView.overlays];
//    [_mapView removeOverlays:array];
//    if (error == BMK_SEARCH_NO_ERROR) {
//        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
//        int size = [plan.steps count];
//        int planPointCounts = 0;
//        for (int i = 0; i < size; i++) {
//            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
//            if(i==0){
//                RouteAnnotation* item = [[RouteAnnotation alloc]init];
//                item.coordinate = plan.starting.location;
//                item.title = @"起点";
//                item.type = 0;
//                [_mapView addAnnotation:item]; // 添加起点标注
//                
//            }else if(i==size-1){
//                RouteAnnotation* item = [[RouteAnnotation alloc]init];
//                item.coordinate = plan.terminal.location;
//                item.title = @"终点";
//                item.type = 1;
//                [_mapView addAnnotation:item]; // 添加起点标注
//            }
//            //添加annotation节点
//            RouteAnnotation* item = [[RouteAnnotation alloc]init];
//            item.coordinate = transitStep.entrace.location;
//            item.title = transitStep.entraceInstruction;
//            item.degree = transitStep.direction * 30;
//            item.type = 4;
//            [_mapView addAnnotation:item];
//            
//            //轨迹点总数累计
//            planPointCounts += transitStep.pointsCount;
//        }
//        
//        //轨迹点
//        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
//        int i = 0;
//        for (int j = 0; j < size; j++) {
//            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
//            int k=0;
//            for(k=0;k<transitStep.pointsCount;k++) {
//                temppoints[i].x = transitStep.points[k].x;
//                temppoints[i].y = transitStep.points[k].y;
//                i++;
//            }
//            
//        }
//        // 通过points构建BMKPolyline
//        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
//        [_mapView addOverlay:polyLine]; // 添加路线overlay
//        delete []temppoints;
//        [self mapViewFitPolyLine:polyLine];
//    }
//}
//
////根据polyline设置地图范围
//- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
//    CGFloat ltX, ltY, rbX, rbY;
//    if (polyLine.pointCount < 1) {
//        return;
//    }
//    BMKMapPoint pt = polyLine.points[0];
//    ltX = pt.x, ltY = pt.y;
//    rbX = pt.x, rbY = pt.y;
//    for (int i = 1; i < polyLine.pointCount; i++) {
//        BMKMapPoint pt = polyLine.points[i];
//        if (pt.x < ltX) {
//            ltX = pt.x;
//        }
//        if (pt.x > rbX) {
//            rbX = pt.x;
//        }
//        if (pt.y > ltY) {
//            ltY = pt.y;
//        }
//        if (pt.y < rbY) {
//            rbY = pt.y;
//        }
//    }
//    BMKMapRect rect;
//    rect.origin = BMKMapPointMake(ltX , ltY);
//    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
//    [_mapView setVisibleMapRect:rect];
//    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - baidumap 反向地理编码

-(void)onClickReverseGeocode
{
//    isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if ([AppDelegate app].lat != nil  && [AppDelegate app].lon != nil) {
        pt = (CLLocationCoordinate2D){[[AppDelegate app].lat floatValue], [[AppDelegate app].lon floatValue]};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}


-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        _startCityText.text = [showmeg substringFromIndex:6];
        _startAddrText.text = [showmeg substringToIndex:6];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}


#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
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
