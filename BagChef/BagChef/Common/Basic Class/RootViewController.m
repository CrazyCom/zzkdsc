//
//  RootViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/14.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

- (void)initializeInterface;
@end

@implementation RootViewController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initNavView];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏
    [self.navigationController setNavigationBarHidden:YES];
    [self.view addSubview:_navView];
    
    [self initializeInterface1];
}

- (void)initializeInterface1 {
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.bounds = CGRectMake(0, 0, 30, 30);
    self.indicatorView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    [self.view addSubview:_indicatorView];
}

- (void)initNavView {
    
   
    
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.center = CGPointMake(ScreenWidth / 2, 20 + 44 / 2);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"System Bold" size:16];
    [_navView addSubview:_titleLabel];
    
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.bounds = CGRectMake(0, 0, 30, 30);
    leftButton.center = CGPointMake(30, 45);
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [leftButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:leftButton];
    leftButton.hidden = YES;
    self.leftButton = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds = CGRectMake(0, 0, 40, 30);
    rightButton.center = CGPointMake(ScreenWidth - 30, 45);
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_navView addSubview:rightButton];
    rightButton.hidden = YES;
    self.rightButton = rightButton;
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.frame = CGRectMake((ScreenWidth - 44 ) - 10, CGRectGetMinY(_titleLabel.frame) ,44,44);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.textColor = [UIColor whiteColor];
    _rightLabel.font = [UIFont fontWithName:@"System Bold" size:16];
    
    [_navView addSubview:_rightLabel];
    
    
}

//- (void)buttonPressed:(UIButton *)sender {
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

//- (void)slidingNavgationMenu {
//    
//    // 如果是第一页，左右移动，打开or关闭 目录+
//    //
//    /// NSLog(@"count = %d",self.navigationController.viewControllers.count)
//    
//    CGPoint curCenter = self.navigationController.view.center;
//    CGSize winSize = [UIScreen mainScreen].bounds.size;
//    
//    DefaultViewController *rootViewController = (DefaultViewController *)[AppDelegate app].window.rootViewController;
//    
//    self.navigationController.topViewController.view.userInteractionEnabled = NO;
//    [UIView animateWithDuration:0.25f
//                          delay:0.00f
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^(void) {
//                         if (curCenter.x == winSize.width/2) {
//                             self.navigationController.view.center = CGPointMake(self.navigationController.view.center.x+move_x,
//                                                                                 self.navigationController.view.center.y);
//                             
//                             
//                         }else {
//                             self.navigationController.view.center = CGPointMake(winSize.width/2,
//                                                                                 self.navigationController.view.center.y);
//                             
//                         }
//                     }
//                     completion:^(BOOL isFinish) {
//                         if (CGPointEqualToPoint(self.navigationController.view.center, CGPointMake(winSize.width/2,
//                                                                                                    self.navigationController.view.center.y))) {
//                            [rootViewController addOrRemoveTapGesture:NO];
////                            [self setLeftMenuButtonWithVertical:NO];
//                             
//                         }
//                         else
//                         {
//                            [rootViewController addOrRemoveTapGesture:YES];
////                            [self setLeftMenuButtonWithVertical:YES];
//                         }
//                     }];
//    
//    // 如果不是第一页，goback
//    
//}

- (void)navBackController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  加载转子

- (void)showLoading {
    
    [self.view bringSubviewToFront:_indicatorView];
    [self.indicatorView startAnimating];
}

- (void)hideLoading {
    
    [self.indicatorView stopAnimating];
}



//加载数据activity
#pragma mark -loading

#define AnnimationTime 0.5
#define KEY_LOAD 201316
-(void)showLoadingActivityViewWithString:(NSString *)titleString
{
    UIView* blockerView1 = [self.view viewWithTag:KEY_LOAD];
    if (blockerView1) {
        return;
    }
    
    [self hideLoadingActivityView];
    UIView* _blockerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 200, 60)];
    _blockerView.backgroundColor = [UIColor colorWithWhite: 0.0 alpha: 0.8];
    _blockerView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    _blockerView.alpha = 0.0;
    _blockerView.clipsToBounds = YES;
    _blockerView.tag=KEY_LOAD;
    //
    if ([_blockerView.layer respondsToSelector: @selector(setCornerRadius:)])
    {
        [(id) _blockerView.layer setCornerRadius: 10];
    }
    
    UILabel	*label = [[UILabel alloc] initWithFrame: CGRectMake(0, 5, _blockerView.bounds.size.width, 15)];
    label.text = NSLocalizedString(titleString, nil);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.font = [UIFont boldSystemFontOfSize: 15];
    [_blockerView addSubview: label];
    
    UIActivityIndicatorView	*spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    spinner.center = CGPointMake(_blockerView.bounds.size.width / 2, _blockerView.bounds.size.height / 2 + 10);
    [_blockerView addSubview: spinner];
    [self.view addSubview: _blockerView];
    _blockerView.alpha = 0.0;
    [UIView animateWithDuration:AnnimationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         _blockerView.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         //
     }];
}

//取消activity效果
-(void)hideLoadingActivityView
{
    UIView* _blockerView = [self.view viewWithTag:KEY_LOAD];
    [UIView animateWithDuration:AnnimationTime
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _blockerView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         if (_blockerView)
         {
             [_blockerView removeFromSuperview];
         }
     }];
}

- (void)hideLoadingActivityViewText:(NSString *)text {
    UIView* _blockerView = [self.view viewWithTag:KEY_LOAD];
    [UIView animateWithDuration:AnnimationTime //
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         _blockerView.alpha = 0;
     }
                     completion:^(BOOL finished)
     {
         if (_blockerView)
         {
             [_blockerView removeFromSuperview];
             [DisplayView displayShowWithTitle:text];
         }
         
     }];
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
