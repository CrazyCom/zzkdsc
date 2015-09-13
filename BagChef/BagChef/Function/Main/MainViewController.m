//
//  MainViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MainViewController.h"
#import "ZNavigationViewController.h"
#import "ZTabBarController.h"
#import "PrivateChefViewController.h"
#import "GourmetViewController.h"
#import "ArmedEscortViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate> {
    
    ZTabBarController *_ztabBarController;
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation MainViewController

-(void)initializeDataSource {
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBarHidden = YES;
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self LeftMenuBt];
//    });

    [self initializeDataSource];
    [self initializeInterface];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)LeftMenuBt {
    
    [super LeftMenuBt];
}

-(void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];


    GourmetViewController *gvc = [[GourmetViewController alloc]init];
    PrivateChefViewController *pvc = [[PrivateChefViewController alloc]init];
    ArmedEscortViewController *aevc = [[ArmedEscortViewController alloc]init];
    
    
   
    _ztabBarController = [[ZTabBarController alloc]init];
    _ztabBarController.viewControllers = @[gvc,pvc,aevc];
    [_ztabBarController setSelectedIndex:0];

    _ztabBarController.tabBar.hidden = YES;
    _ztabBarController.delegate = self;
    _ztabBarController.view.frame = self.view.frame;
    NSLog(@"111%@",NSStringFromCGRect(_ztabBarController.view.frame));
    [self addChildViewController:_ztabBarController];
    [self.view addSubview:_ztabBarController.view];
    

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
