//
//  AppDelegate.h
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong ,nonatomic) UIViewController *viewController;

+ (AppDelegate *)app;

@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;

@end

