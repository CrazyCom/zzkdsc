//
//  DefautViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/7/29.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "DefaultViewController.h"
#import "ZTabBarController.h"
#import "PrivateChefViewController.h"
#import "GourmetViewController.h"
#import "ArmedEscortViewController.h"
#import "LeftMenu.h"

#import "MainViewController.h"
#import "TempViewController.h"

#import "MyIndentViewController.h"
#import "MyEnshrineViewController.h"
#import "MySilverViewController.h"
#import "MyCuponViewController.h"
#import "MyInformationViewController.h"
#import "ComplainAndSuggestionViewController.h"
#import "AboutUsViewController.h"
#import "GourmetViewController.h"

#import "LoginViewController.h"
@interface DefaultViewController ()<leftItemScrollViewDelegate> {
     
    
    LeftMenu *_leftMenu;
    UIView *_rightMenu;
    
    TempViewController *_tempViewController;
    UIViewController *_viewController;
    
    GourmetViewController *_gourmetViewController;
    MainViewController *_mainViewController;
     UIButton *tempView;     //点击覆盖左边按钮
    
    CGPoint _defaultCenter;
    
    UIPanGestureRecognizer *_panGesture;
}
- (void)configureRightView;
- (void)configureLeftView;

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize mainSize = [UIScreen mainScreen].applicationFrame.size;
    _defaultCenter = CGPointMake(mainSize.width/2, mainSize.height/2);
    
    [self configureLeftView];
    [self configureRightView];
//    for (int i = 0; i < _mainNavController.viewControllers.count; i ++) {
//         NSLog(@"%@",_mainNavController.viewControllers);
//    }
    NSLog(@"---%@",_mainNavController.viewControllers);
}

- (void)configureLeftView {
    
    _leftMenu = [[LeftMenu alloc]initWithFrame:CGRectMake(0, 0, move_x, ScreenHeight)];
    _leftMenu.delegate = self;
    [self.view addSubview:_leftMenu];

//    _leftMenu = [[LeftMenu alloc]initWithFrame:CGRectMake(0, 0, move_x, ScreenHeight)];
//    _leftMenu.delegate = self;
//    [self.view addSubview:_leftMenu];

}

- (void)configureRightView {
    
    
    
    GourmetViewController *gvc = [[GourmetViewController alloc]init];
    UINavigationController *nav0 = [[UINavigationController alloc]initWithRootViewController:gvc];
    [gvc.leftButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    PrivateChefViewController *pvc = [[PrivateChefViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:pvc];
    [pvc.leftButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    ArmedEscortViewController *aevc = [[ArmedEscortViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:aevc];
    [aevc.leftButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    _ztabBarController = [[ZTabBarController alloc] init];
    _ztabBarController.viewControllers = @[nav0,nav1,nav2];
    _ztabBarController.tabBar.translucent = NO;
//    _tabBarController.tabBar.alpha = 1.0;
    [_ztabBarController setSelectedIndex:0];
    _rightMenu = _ztabBarController.view;
    //    _rightMenu.layer.shadowColor = [UIColor blackColor].CGColor;
    //    _rightMenu.layer.shadowOpacity = 0.5;
    //    _rightMenu.layer.shadowOffset = CGSizeMake(-5, 5);
    //    _rightMenu.backgroundColor = [UIColor blueColor];
    _rightMenu.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_rightMenu];
    [self addChildViewController:_ztabBarController];
    
    _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                         action:@selector(panGestureAction:)];
    [_rightMenu addGestureRecognizer:_panGesture];
    NSLog(@"%lf",ratioX);
}

- (void)menuButtonClick:(UIButton *)sender {

    [self moveLeftMenu:YES complete:nil];
    
}

- (void)moveLeftMenu:(BOOL)animated complete:(void (^)(void))complete{
    
    // 如果是第一页，左右移动，打开or关闭 目录+
    //
    /// NSLog(@"count = %d",self.navigationController.viewControllers.count)
    
    CGPoint curCenter = _rightMenu.center;
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    
    DefaultViewController *rootViewController = self;
    
    self.navigationController.topViewController.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:animated ? 0.25f : 0.0f
                          delay:0.00f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         if (curCenter.x == winSize.width/2) {
                             _rightMenu.center = CGPointMake(_rightMenu.center.x+move_x,
                                                             _rightMenu.center.y);
                             
                             
                             
                         }else {
                             _rightMenu.center = CGPointMake(winSize.width/2,
                                                             _rightMenu.center.y);
                             
                         }
                     }
                     completion:^(BOOL isFinish) {
                         if (CGPointEqualToPoint(_rightMenu.center, CGPointMake(winSize.width/2,
                                                                                _rightMenu.center.y))) {
                             [rootViewController addOrRemoveTapGesture:NO];
                             //                            [self setLeftMenuButtonWithVertical:NO];
                             
                         }
                         else
                         {
                             [rootViewController addOrRemoveTapGesture:YES];
                             //                            [self setLeftMenuButtonWithVertical:YES];
                         }
                         
                         if (complete) {
                             complete();
                         }
                         
                     }];
    
    // 如果不是第一页，goback
    
}

//- (void)closeLeftMenu {
//
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        CGPoint center = _rightMenu.center;
//        center.x = ScreenWidth / 2;
//        _rightMenu.center = center;
//
//    }];
//}


//添加焦点
- (void)addOrRemoveTapGesture:(BOOL)addOrRemove {
    if (addOrRemove) {
        //        _mainNavController.topViewController.view.userInteractionEnabled = NO;
        
        if (!tempView) {
            tempView = [[UIButton alloc] initWithFrame:_rightMenu.bounds];
            tempView.backgroundColor = [UIColor colorWithRed:1. green:1. blue:1. alpha:0.01];
            [tempView setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [tempView addTarget:self action:@selector(tempViewPressed) forControlEvents:UIControlEventTouchUpInside];
            [_rightMenu addSubview:tempView];
            
            
        }else{
            tempView.hidden = NO;
            
            [tempView removeFromSuperview];
            [_rightMenu addSubview:tempView];
        }
        
        
        
        //        BaseViewController *v = (BaseViewController *)_mainNavController.topViewController;
        //        [v setLeftMenuButtonWithVertical:YES];
    }else {
        //        _mainNavController.topViewController.view.userInteractionEnabled = YES;
        //        BaseViewController *v = (BaseViewController *)_mainNavController.topViewController;
        //        [v setLeftMenuButtonWithVertical:NO];
        
        if (tempView) {
            tempView.hidden = YES;
        }
        
    }
}

-(void)tempViewPressed
{
    
    if (tempView) {
        tempView.hidden = YES;
    }
    [self moveLeftMenu:YES complete:nil];
}

- (void)closeLeftView
{
    UIView *view = _mainNavController.view;
    //
    [UIView animateWithDuration:0.25f
                          delay:0.00f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         view.center = CGPointMake(_defaultCenter.x, view.center.y);
         
     }
                     completion:^(BOOL isFinish)
     {
         _mainNavController.topViewController.view.userInteractionEnabled = YES;
     }];
}

//
- (void)panGestureAction:(UIPanGestureRecognizer*)gesture
{
    
    // NSLog(@"xxxxxx = %d",_mainNavController.viewControllers.count);
    
    if(_mainNavController.viewControllers.count > 2){
        return;
    }
    
    UIView  *view    = _rightMenu;
    CGPoint  point   = [gesture translationInView:view];
    float    xOffset = view.center.x + point.x;
    //
    if (xOffset < _defaultCenter.x)
    {
        xOffset = _defaultCenter.x;
    }
    
    
    else if (xOffset >= _defaultCenter.x +  move_x) {
        xOffset = _defaultCenter.x +  move_x;
    }
    
    //  NSLog(@"xoffset = %f",xOffset);
    
    view.center = CGPointMake(xOffset, view.center.y);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //添加点击手势
        [self addOrRemoveTapGesture:YES];
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.25f
                              delay:0.00f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void)
         {
             NSLog(@"%@",NSStringFromCGPoint(view.center));
             if (view.center.x < _defaultCenter.x+ move_x)
             {
                 view.center = CGPointMake(_defaultCenter.x, view.center.y);
             }
             else
             {
                 view.center = CGPointMake(_defaultCenter.x+move_x, view.center.y);
             }
         }
                         completion:^(BOOL isFinish) {
                             if (CGPointEqualToPoint(view.center, CGPointMake(_defaultCenter.x, view.center.y))) {
                                 //移除tap手势
                                 [self addOrRemoveTapGesture:NO];
                             }
                         }];
    }
    //
//    [gesture setTranslation:CGPointZero inView:view];
}


#pragma mark - leftItemScrollViewDelegate

- (void)leftItermButtonDidSelected:(int)index repeat:(BOOL)b {
    
    if (index == 0) {
        MyInformationViewController *mivc = [[MyInformationViewController alloc]init];
//        [self presentViewController:mivc animated:YES completion:nil];
//        [_mainNavController pushViewController:mivc animated:YES];
//        [self closeLeftView];
        _viewController = mivc;
    }
    else if (index == 1) {
        
        MyIndentViewController *mvivc = [[MyIndentViewController alloc]init];
//        UINavigationController *nav = (UINavigationController *)_tabBarController.selectedViewController;
//        [nav pushViewController:mvivc animated:YES];
//        [self closeLeftMenu];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mvivc];
        
//        [_mainNavController pushViewController:mvivc animated:YES];
//        [self closeLeftView];
        _viewController = mvivc;
    }
    else if (index == 2) {
        
        MyEnshrineViewController *mevc = [[MyEnshrineViewController alloc]init];
//        [self presentViewController:mevc animated:YES completion:nil];
//        [self.navigationController pushViewController:mevc animated:YES];
//        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:mevc] animated:YES completion:nil];
//        [_mainNavController pushViewController:mevc animated:YES];
//        [self closeLeftView];
        _viewController = mevc;
    }
    else if (index == 3) {
        
        MySilverViewController *msvc = [[MySilverViewController alloc]init];
//        [self presentViewController:msvc animated:YES completion:nil];
//        [_mainNavController pushViewController:msvc animated:YES];
//        [self closeLeftView];
        _viewController = msvc;
    }
    else if (index == 4) {
        
        MyCuponViewController *mcvc = [[MyCuponViewController alloc]init];
//        [self presentViewController:mcvc animated:YES completion:nil];
//        [_mainNavController pushViewController:mcvc animated:YES];
//        [self closeLeftView];
        _viewController = mcvc;
    }
    else if (index == 5) {
        
        AboutUsViewController *auvc = [[AboutUsViewController alloc]init];
//        [self presentViewController:auvc animated:YES completion:nil];
//        [_mainNavController pushViewController:auvc animated:YES];
//        [self closeLeftView];
        _viewController = auvc;
    }
    else if (index == 6) {
        
        ComplainAndSuggestionViewController *casvc = [[ComplainAndSuggestionViewController alloc]init];
//        [self presentViewController:casvc animated:YES completion:nil];
//        [_mainNavController pushViewController:casvc animated:YES];
//        [self closeLeftView];
        _viewController = casvc;

    }
   
    if (_viewController != nil) {
        LoginViewController *loginvc = [[LoginViewController alloc]init];
        UINavigationController *lvc = [[UINavigationController alloc] initWithRootViewController:loginvc];
        UINavigationController *nav = (UINavigationController *)_ztabBarController.selectedViewController;
        if ([Common isHadLogin]) {
            
            [nav pushViewController:_viewController animated:NO];
            [self moveLeftMenu:YES complete:^{
                
            }];

        }
        else {
        
//            [nav pushViewController:lvc animated:NO];
//            [self moveLeftMenu:YES complete:^{
//                
//            }];
            [nav presentViewController:lvc animated:YES completion:nil];
        }
    }

   //        [_mainNavController popToRootViewControllerAnimated:YES];
//        _viewController.view.center = CGPointMake(ScreenWidth, ScreenHeight / 2.0);
//        [self.view addSubview:_viewController.view];
//        [self addChildViewController:_viewController];
//        [self transitionFromViewController:_ztabBarController toViewController:_viewController duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            
//            _viewController.view.center = CGPointMake(ScreenWidth / 2.0, ScreenHeight / 2.0);
//            
//        } completion:nil];
//        [_mainNavController pushViewController:_viewController animated:YES];
//        [self closeLeftView];

    
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
