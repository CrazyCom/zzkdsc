//
//  BaseViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "BaseViewController.h"

#define BUTTON_WIDTH      52
#define BUTTON_HEIGHT     29


@interface BaseViewController () {
    
    UIView *_navView;
}

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.navigationController.delegate = self;
    [self setNavBackGround];
    [self loadSelfView];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadSelfView
{
    //
    [self setLeftButton:[UIImage imageNamed:@"list"] btnText:nil];
    [self setTitleLabel:nil];
    self.navigationController.navigationBarHidden = NO;
    
    
}


//设置背影
-(void)setNavBackGround
{
    CGRect rect = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    UIGraphicsBeginImageContext(self.navigationController.navigationBar.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f] CGColor]);
//    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 43, 10)];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
//    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
//    _navView.backgroundColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//    [self.view addSubview:_navView];
}

-(void)rightBtnClick1:(id)sender
{
    NSLog(@"right click 1");
    
}

- (void)LeftMenuBt
{
    NSLog(@"LeftMenuBt");
    // 如果是第一页，左右移动，打开or关闭 目录+
    //
    /// NSLog(@"count = %d",self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count == 2) {
        
        CGPoint curCenter = self.navigationController.view.center;
        CGSize winSize = [UIScreen mainScreen].bounds.size;
        
        AppDelegate* appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        DefaultViewController *rootViewController = (DefaultViewController *)appDelegate.viewController;
        
        //self.navigationController.topViewController.view.userInteractionEnabled
        self.navigationController.topViewController.view.userInteractionEnabled = YES;
        //  self.view.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.25f
                              delay:0.00f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^(void) {
                             if (curCenter.x == winSize.width/2) {
                                 self.navigationController.view.center = CGPointMake(self.navigationController.view.center.x+move_x,
                                                                                     self.navigationController.view.center.y);
                                 
                                 
                             }else {
                                 self.navigationController.view.center = CGPointMake(winSize.width/2,
                                                                                     self.navigationController.view.center.y);
                                 
                             }
                         }
                         completion:^(BOOL isFinish) {
                             if (CGPointEqualToPoint(self.navigationController.view.center, CGPointMake(winSize.width/2,
                                                                                                        self.navigationController.view.center.y))) {
                                 [rootViewController addOrRemoveTapGesture:NO];
                                 [self setLeftMenuButtonWithVertical:NO];
                                 
                             }
                             else
                             {
                                 [rootViewController addOrRemoveTapGesture:YES];
                                 [self setLeftMenuButtonWithVertical:YES];
                             }
                         }];
    }
    // 如果不是第一页，goback
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)leftButtonClick:(id)sender
{
    NSLog(@"left");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark- 初始化各个公用控件

// leftButtonImage 赋值为 nil 时，隐藏left按钮
// leftButtonImage 赋值非 nil 时，设置left按钮
- (void)setLeftButtonImage:(UIImage *)leftButtonImage
{
    if (leftButtonImage == nil)
    {
        self.leftButton.hidden = YES;
    }
    else
    {
        self.leftButton.hidden = NO;
        [self.leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    }
}

// rightButtonImage 赋值为 nil 时，隐藏right按钮
// rightButtonImage 赋值非 nil 时，设置right按钮
- (void)setRightButtonImage:(UIImage *)rightButtonImage
{
    if (rightButtonImage == nil)
    {
        self.rightButton.hidden = YES;
    }
    else
    {
        self.rightButton.hidden = NO;
        [self.rightButton setImage:rightButtonImage forState:UIControlStateNormal];
    }
}

//设置左按钮
-(void)setLeftButton:(UIImage*)backgroundImage btnText:(NSString*)btnText
{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [_leftButton setImage:backgroundImage forState:UIControlStateNormal];
    
    if (btnText != nil)
    {
        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        _leftButton.titleLabel.textColor    = [UIColor blackColor];
        _leftButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
        _leftButton.titleLabel.shadowColor  = [UIColor darkGrayColor];
        [_leftButton setTitle:btnText forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [_leftButton addTarget:self action:@selector(LeftMenuBt) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    [self.navigationItem setLeftBarButtonItem:leftitem];
}

//设置左按钮
-(void)setLeftButtonCancel:(UIButton *)bt
{
    //    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_leftButton setFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
    //    [_leftButton setImage:backgroundImage forState:UIControlStateNormal];
    //    //
    //    if (btnText != nil)
    //    {
    //        _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    //        _leftButton.titleLabel.textColor    = [UIColor blackColor];
    //        _leftButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
    //        _leftButton.titleLabel.shadowColor  = [UIColor darkGrayColor];
    //        [_leftButton setTitle:btnText forState:UIControlStateNormal];
    //        [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    }else{
    //        [_leftButton addTarget:self action:@selector(LeftMenuBt) forControlEvents:UIControlEventTouchUpInside];
    //    }
    
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    [self.navigationItem setLeftBarButtonItem:leftitem];
}

#pragma mark - 左边按钮旋转
-(void)setLeftMenuButtonWithVertical:(BOOL)b
{
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(LeftMenuBt) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setRightButton1:(UIImage *)backgroundImage1 withRightButton2:(UIImage *)backgroundImage2
{
    //    right_menu_se.png
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    
    _rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton1 setFrame:CGRectMake(0, (44-BUTTON_HEIGHT)/2, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [_rightButton1 setBackgroundImage:backgroundImage1 forState:UIControlStateNormal];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(40, (44-BUTTON_HEIGHT)/2, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [_rightButton setBackgroundImage:backgroundImage2 forState:UIControlStateNormal];
    //
    //    if (btnText != nil)
    //    {
    //        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    //        _rightButton.titleLabel.textColor    = [UIColor whiteColor];
    //        _rightButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
    //        _rightButton.titleLabel.shadowColor  = [UIColor darkGrayColor];
    //        [_rightButton setTitle:btnText forState:UIControlStateNormal];
    //    }
    //
    
    
    [_rightButton1 addTarget:self action:@selector(rightBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    //    [_rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightView addSubview:_rightButton1];
    
    [rightView addSubview:_rightButton];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
}

//设置右按钮
-(void)setRightButton:(UIImage*)backgroundImage btnText:(NSString*)btnText
{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(0, 0, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [_rightButton setImage:backgroundImage forState:UIControlStateNormal];
    //
    if (btnText != nil)
    {
        [_rightButton setFrame:CGRectMake(0, 0, BUTTON_WIDTH*2, BUTTON_HEIGHT)];
        //        _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        
        _rightButton.titleLabel.textColor    = [UIColor whiteColor];
        [_rightButton setTitle:btnText forState:UIControlStateNormal];
    }
    //
    //    [_rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
}

//设置左按钮
-(void)setLeftButtonView:(UIView*)lv
{
    if (_leftButton) {
        _leftButton = nil;
    }
    _leftButton = (UIButton *)lv;
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:_leftButton];
    [self.navigationItem setLeftBarButtonItem:leftitem];
    
}

//设置右按钮
-(void)setRightButtonView:(UIView*)rv
{
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:rv];
    [self.navigationItem setRightBarButtonItem:rightitem];
}

- (void)setTitleLabel:(UILabel *)titleLabel
{
    // 标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:titleView.frame];
    //    _titleLabel.textColor       = [UIColor blackColor];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    _titleLabel.font            = [UIFont boldSystemFontOfSize:19];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:self.titleLabel];
    self.navigationItem.titleView = titleView;
}

#pragma mark - UINavigationDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (navigationController.viewControllers.count > 2)
    {
        [self setLeftButtonImage:[UIImage imageNamed:@"return"]];
    }
    else
    {
        [self setLeftButtonImage:[UIImage imageNamed:@"list"]];
    }

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
