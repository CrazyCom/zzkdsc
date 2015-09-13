//
//  ZTabBarController.h
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

typedef enum {
    
    TabTypeName = 1,
    TabTypeIcon
    
} TabType;



#import <UIKit/UIKit.h>

@interface ZTabBarController : UITabBarController

//@property (nonatomic,strong) NSMutableArray *btnArray;
//@property (nonatomic,strong) UIImageView *bgView;
//@property (nonatomic,assign) NSInteger currentSelectedIndex;
//@property (nonatomic,assign) TabType tabType;
//@property (nonatomic,strong) NSMutableArray *redPoints;
//
//- (void)setHideZTabBar:(BOOL)hide;
//- (void)setHideZTabBarBtn:(BOOL)hide;
//- (void)tabBarSelectBtn:(UIButton *)btn;
//- (void)tabBarSelectIndex:(int)index;
//- (void)setHideRedPoint:(BOOL) hide index:(NSInteger)index;

@property(nonatomic,strong)NSMutableArray *btnArray;
//@property(nonatomic,strong)UIImageView *bgView;
@property (nonatomic,strong) UIView *bgView;
@property(nonatomic,assign)NSInteger currentSelectedIndex;
@property(nonatomic,assign)TabType tabType;
@property (nonatomic, strong) NSMutableArray *redPoints;
//@property(nonatomic,strong)UIView *redPoint;

- (void)setHideEsunTabBar:(BOOL)hide;
- (void)setHideEsunTabBarBtn:(BOOL)hide;
- (void)tabbarSelectBtn:(UIButton *)button;
- (void)tabbarSelectIndex:(int)index;
//- (void)setHideRedPoint:(BOOL)hide;

- (void)setHideRedPoint:(BOOL)hide index:(NSInteger)index;


@end
