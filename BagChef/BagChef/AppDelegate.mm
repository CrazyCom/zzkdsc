//
//  AppDelegate.m
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "AppDelegate.h"
#import "DefaultViewController.h"
#import "MyInformationViewController.h"
#import "IQKeyboardManager.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import <BaiduMapAPI/BMKMapView.h>//只引入所需的单个头文件
#import "RouteManager.h"
#import "APService.h"

@interface AppDelegate ()<BMKGeneralDelegate,BMKLocationServiceDelegate> {
    
    BMKMapManager *_manager;
    BMKLocationService *_localService;
}

@property (nonatomic,retain) CLLocationManager  *locationManager;

@end

@implementation AppDelegate

+(AppDelegate *)app {
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
    //
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置status
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _manager = [[BMKMapManager alloc]init]; // CF41zd5ZgASrTTIF44bLFbjy
    BOOL ret = [_manager start:@"1yoWgXQeI6TKjGhQB4Ov9fg3" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    if  ([[UIDevice  currentDevice ] .systemVersion  floatValue ] >=  8 ) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        self.locationManager = [[CLLocationManager  alloc ]  init ];
        //获取授权认证
        [self.locationManager  requestAlwaysAuthorization ];
        [self.locationManager  requestWhenInUseAuthorization];
    }

    //定位
    _localService = [[BMKLocationService alloc]init];
    _localService.delegate = self;

    
    DefaultViewController *dvc = [[DefaultViewController alloc]init];
    _viewController = dvc;
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:dvc];
    self.window.rootViewController = _viewController;
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MyInformationViewController alloc] init]];
    
    //管理键盘弹出情况
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    

    //设置推送类型
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    }
    else
    {
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
         categories:nil];
    }
    [APService setupWithOption:launchOptions];
    
    //若图标上的数字为1 ，打开APP后置0
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] != 0)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    

    
    return YES;
}

// 获得设备号
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 上传设备号
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //若图标上的数字为1 ，打开APP后置0
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] != 0)
    {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
    [_localService startUserLocationService];
}

#pragma mark -  定位

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //[_mapView updateLocationData:userLocation];
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    
//    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    NSDictionary *dict = @{@"mcode":@"crazy.BagChef",@"ak":@"1yoWgXQeI6TKjGhQB4Ov9fg3",@"callback":@"renderReverse",@"location":[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude ],@"output":@"json",@"pois":@"1"};
//    __weak typeof(self) myself = self;
//     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [NetWorkHandler getAdressWithParams:dict completionHandler:^(id content) {
//       
//        NSLog(@"content:%@",content);
//        NSLog(@"%@",content[@"message"]);
//        NSLog(@"c%@",content[@"result"][@"addressComponent"][@"city"]);
//       
//        [defaults setObject:[NSString stringWithFormat:@"%@",content[@"result"][@"addressComponent"][@"city"]] forKey:@"city"];
//        [defaults synchronize];
////
////        if (<#condition#>) {
////            <#statements#>
////        }
////        NSLog(@"string%@",[NSString stringWithFormat:@"%@",content[@"result"][@"addressComponent"][@"city"]]);
//        if ([NSString stringWithFormat:@"%@",content[@"result"][@"addressComponent"][@"city"]].length != 0 ) {
//             NSLog(@"%@",content[@"result"][@"addressComponent"][@"city"]);
//             [_localService stopUserLocationService];
//            return ;
//        }
//
//    }];
//    
//   
//    
//}


- (void)didFailToLocateUserWithError:(NSError *)error {
   
    NSLog(@"didFailToLocateUserWithError %@",error);
}



@end
