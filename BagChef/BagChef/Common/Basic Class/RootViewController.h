//
//  RootViewController.h
//  BagChef
//
//  Created by zhangzhi on 15/8/14.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

@property (nonatomic , strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *rightLabel;

- (void)navBackController;
- (void)slidingNavgationMenu;

//添加Activity加载效果
-(void)showLoadingActivityViewWithString:(NSString *)titleString;

//取消activity效果
-(void)hideLoadingActivityView;
- (void)hideLoadingActivityViewText:(NSString *)text;

- (void)showLoading;
- (void)hideLoading;
@end
