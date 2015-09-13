//
//  RouteManager.m
//  BagChef
//
//  Created by zhangzhi on 15/8/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "RouteManager.h"
#import <BaiduMapAPI/BMapKit.h>

@interface RouteManager () <BMKRouteSearchDelegate> {

    BMKRouteSearch *_routeSearch;
}

@property (nonatomic, copy) void (^complete)(CGFloat distance);

@end

@implementation RouteManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _routeSearch = [[BMKRouteSearch alloc] init];
        _routeSearch.delegate = self;
        
    }
    return self;
}

- (void)dealloc
{
    _routeSearch.delegate = nil;
}

- (void)distance:(CLLocationCoordinate2D)startPoint EndPoint:(CLLocationCoordinate2D)endPoint Complete:(void (^)(CGFloat))complete {

    [self distance:startPoint EndPoint:endPoint RouteType:RTWalk Complete:complete];
}

- (void)distance:(CLLocationCoordinate2D)startPoint EndPoint:(CLLocationCoordinate2D)endPoint RouteType:(RouteType)routeType Complete:(void (^)(CGFloat))complete {

    if (!complete) {
        return;
    }
    
    self.complete = complete;
    
    BMKBaseRoutePlanOption *planOption = [[BMKBaseRoutePlanOption alloc] init];
    
    switch (routeType) {
        case RTTransit:
            planOption = [[BMKTransitRoutePlanOption alloc] init];
            break;
        case RTDriving:
            planOption = [[BMKDrivingRoutePlanOption alloc] init];
            break;
        case RTWalk:
            planOption = [[BMKWalkingRoutePlanOption alloc] init];
            break;
            
        default:
            // 传入类型错误
            break;
    }
    
    BMKPlanNode *startNode = [[BMKPlanNode alloc] init];
    startNode.pt = startPoint;
    
    BMKPlanNode *endNode = [[BMKPlanNode alloc] init];
    endNode.pt = endPoint;
    
    planOption.from = startNode;
    planOption.to = endNode;
    
    switch (routeType) {
        case RTTransit:
            [_routeSearch transitSearch:(BMKTransitRoutePlanOption *)planOption];
            break;
        case RTDriving:
            [_routeSearch drivingSearch:(BMKDrivingRoutePlanOption *)planOption];
            break;
        case RTWalk:
            [_routeSearch walkingSearch:(BMKWalkingRoutePlanOption *)planOption];
            break;
            
        default:
            // 传入类型错误
            break;
    }
}

- (void)onGetTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error {

    if (error == BMK_SEARCH_NO_ERROR && result.routes.count > 0) {
        BMKRouteLine *routeLine = [result.routes firstObject];
        self.complete(routeLine.distance);
    }
    else {
        self.complete(-1);
    }
    
}
- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR && result.routes.count > 0) {
        BMKRouteLine *routeLine = [result.routes firstObject];
        self.complete(routeLine.distance);
    }
    else {
        self.complete(-1);
    }
    
}
- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == BMK_SEARCH_NO_ERROR && result.routes.count > 0) {
        BMKRouteLine *routeLine = [result.routes firstObject];
        self.complete(routeLine.distance);
    }
    else {
        self.complete(-1);
    }
    
}



@end
