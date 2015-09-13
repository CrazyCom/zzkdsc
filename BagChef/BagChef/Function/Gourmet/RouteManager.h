//
//  RouteManager.h
//  BagChef
//
//  Created by zhangzhi on 15/8/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, RouteType){

    RTWalk              =0,
    RTDriving,
    RTTransit,
};

@interface RouteManager : NSObject

- (void)distance:(CLLocationCoordinate2D)startPoint
        EndPoint:(CLLocationCoordinate2D)endPoint
       RouteType:(RouteType)routeType
        Complete:(void (^)(CGFloat distance))complete;

- (void)distance:(CLLocationCoordinate2D)startPoint
        EndPoint:(CLLocationCoordinate2D)endPoint
        Complete:(void (^)(CGFloat distance))complete;

@end
