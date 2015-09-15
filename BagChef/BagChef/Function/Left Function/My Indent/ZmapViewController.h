//
//  ZmapViewController.h
//  BagChef
//
//  Created by zhangzhi on 15/9/13.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "RootViewController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface ZmapViewController : RootViewController<BMKGeoCodeSearchDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate> {
    
    BMKMapView *_mapView;
    BMKRouteSearch *_routesearch;
    NSString *_express_id;
    UITextField* _startCityText;
    UITextField* _startAddrText;
    UITextField* _endCityText;
    UITextField* _endAddrText;

    
    bool isGeoSearch;
    BMKGeoCodeSearch* _geocodesearch;
    
       
    UITextField* _coordinateXText;
    UITextField* _coordinateYText;
}

- (instancetype)initWithExpress_id:(NSString *)expressId;

@end
