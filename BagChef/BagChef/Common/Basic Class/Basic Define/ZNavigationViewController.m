//
//  ZNavigationViewController.m
//  Bazaar
//
//  Created by zz on 15/7/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ZNavigationViewController.h"

#define Button_width 52
#define Button_height 29

@interface ZNavigationViewController ()

@end

@implementation ZNavigationViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarBackground];
    [self laodSelfView];
    
}

#pragma mark 设置导航栏背景

- (void)setNavigationBarBackground {
    
    CGRect rect = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    UIGraphicsBeginImageContext(self.navigationController.navigationBar.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.0/255 green:134.0/255 blue:211.0/255 alpha:1.0].CGColor);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.961f green:0.392f blue:0.184f alpha:1.00f].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f].CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 43, 10)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)laodSelfView {
    
    [self setLeftButton:[UIImage imageNamed:@"list"] btnText:nil];
    [self setTitleLabel:nil];
    self.navigationController.navigationBarHidden = YES;
}


//titleLabel
- (void)setTitleLabel:(UILabel *)titleLabel {
    
    //标题
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    _titleLabel = [[UILabel alloc]initWithFrame:titleView.frame];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:19];
//    _titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.backgroundColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    [titleView addSubview:self.titleLabel];
    self.navigationItem.titleView = titleView;
}

//设置左按钮，为nil时隐藏
- (void)setLeftButtonImage:(UIImage *)leftButtonImage{
    
    if (leftButtonImage == nil) {
        self.leftButton.hidden = YES;
    }
    else {
        self.leftButton.hidden = NO;
        [self.leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    }
}
- (void)setLeftButtonView:(UIView *)leftView{
    
    if (_leftButton) {
        _leftButton = nil;
    }
    _leftButton = (UIButton *)leftView;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}
- (void)setLeftButton:(UIImage *)backgroundImage btnText:(NSString *)btnText{
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setFrame:CGRectMake(0, 0, Button_width, Button_height)];
    [_leftButton setImage:backgroundImage forState:UIControlStateNormal];
    
    if (btnText != nil) {
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        _leftButton.titleLabel.textColor = [UIColor blackColor];
        _leftButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
        _leftButton.titleLabel.shadowColor = [UIColor darkGrayColor];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [_leftButton addTarget:self action:@selector(leftMenuBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

//设置右按钮，为nil时隐藏
- (void)setRightButtonImage:(UIImage *)rightButtonImage{
    
    if (rightButtonImage == nil) {
        self.rightButton.hidden = YES;
    }
    else {
        self.rightButton.hidden = YES;
        [self.rightButton setImage:rightButtonImage forState:UIControlStateNormal];
    }
}
- (void)setRightButtonView:(UIView *)rightView{
    
    if (_rightButton) {
        _rightButton = nil;
    }
    _rightButton = (UIButton *)rightView;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    [self.navigationItem setLeftBarButtonItem:rightItem];
}
- (void)setRightButton:(UIImage *)backgroundImage btnText:(NSString *)btnText{
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(0, 0, Button_width, Button_height)];
    [_rightButton setImage:backgroundImage forState:UIControlStateNormal];
    
    if (btnText != nil) {
        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        _rightButton.titleLabel.textColor = [UIColor blackColor];
        _rightButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
        _rightButton.titleLabel.shadowColor = [UIColor darkGrayColor];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [_rightButton addTarget:self action:@selector(leftMenuBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    [self.navigationItem setLeftBarButtonItem:rightItem];

}

//设置是否可以左右滑动
#pragma mark -
- (void)setLeftMenuButtonCanVertical:(BOOL)b {
    
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftMenuBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRightMenuButtonCanVertical:(BOOL)b{}

- (void)leftMenuBtn {
    
//    if (self.navigationController.viewControllers.count == 2) {
//        CGPoint currentCenter = self.navigationController.view.center;
//        CGSize winSize = [UIScreen mainScreen].bounds.size;
//        
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        DefaultViewController *defaultViewController = (DefaultViewController *)appDelegate.rootViewController;
//        self.navigationController.topViewController.view.userInteractionEnabled = YES;
//        [UIView animateWithDuration:0.25f
//                              delay:0.00f
//                            options:UIViewAnimationOptionCurveEaseInOut
//                         animations:^{
//                             if(currentCenter.x == winSize.width/2.0) {
//                                 
//                                 self.navigationController.view.center = CGPointMake(self.navigationController.view.center.x + move_x * ScreenWidth / 320, self.navigationController.view.center.y);
//                             }
//                             else {
//                                 self.navigationController.view.center = CGPointMake(winSize.width / 2.0, self.navigationController.view.center.y);
//                             }
//                         } completion:^(BOOL finished) {
//                             
//                             if (CGPointEqualToPoint(self.navigationController.view.center, CGPointMake(winSize.width / 2.0, self.navigationController.view.center.y))) {
//                                 [defaultViewController addOrRemoveTapGesture:NO];
//                                 [self setLeftMenuButtonCanVertical:YES];
//                             }
//                             else {
//                                 [defaultViewController addOrRemoveTapGesture:YES];
//                                 [self setLeftMenuButtonCanVertical:NO];
//                             }
//                         }];
//    }
//    
//    //如果不是第一页，goback
//    else {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (void)rightMenuBtn{}

//通过override方法，修改right/left按钮的点击行为
- (void)leftButtonClick:(id)sender{}
- (void)rightButtonClick:(id)sender{}


//添加Activity加载效果
- (void)showLoadingActivityViewWithString:(NSString *)textString{}

//取消Activity效果
- (void)hideLoadingActivityView{}
- (void)hideLoadingActivityViewWithString:(NSString *)textString{}







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
