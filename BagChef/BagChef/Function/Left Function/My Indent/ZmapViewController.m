//
//  ZmapViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/13.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ZmapViewController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface ZmapViewController ()<BMKMapViewDelegate> {
    
    NSString *_express_id;
    BMKMapView *mapView;
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation ZmapViewController

- (instancetype)initWithExpress_id:(NSString *)expressId {
    
    if (self = [super init]) {
        
        _express_id = expressId;
        
    }
    return self;
}

-(void)initializeDataSource {

    NSDictionary *dict = @{@"express_id":_express_id};
    [NetWorkHandler getExpressCoordinate:dict completionHandler:^(id content) {
        NSLog(@"getExpressCoordinate:%@",content);
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

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"";
    
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    mapView.delegate = self;
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;
//    mapView.
    [self.view addSubview:mapView];
}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    
    
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
