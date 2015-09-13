//
//  MyIndentViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/7.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyIndentViewController.h"
#import "MYEatView.h"
#import "MyDoView.h"
#import "MySendView.h"

@interface MyIndentViewController () {
    
    UILabel *_animationLabel;
    
    MyEatView *_myEatView;
    MyDoView *_myDoView;
    MySendView *_mySendView;
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation MyIndentViewController

-(void)initializeDataSource {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBar:YES];

}


-(void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    for (int i = 0 ; i < 3; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame) + 20 +( 40 +((ScreenWidth - CGRectGetMaxX(self.leftButton.frame) * 2 - 120) / 3)) * i , CGRectGetMaxY(self.leftButton.frame) - 30, 40, 30);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 50 + i;
        [self.view addSubview:btn];
        if (i == 0) {
            [btn setTitle:@"我吃" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else if (i == 1) {
            [btn setTitle:@"我做" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        else {
            [btn setTitle:@"我送" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
    }
    
    //下划线
    _animationLabel = [[UILabel alloc]init];
    _animationLabel.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame), 61,(ScreenWidth - CGRectGetMaxX(self.leftButton.frame) * 2) / 3, 3);
    _animationLabel.backgroundColor = [UIColor colorWithRed:1.000f green:0.671f blue:0.325f alpha:1.00f];
    [self.view addSubview:_animationLabel];
    
    
    _myEatView = [[MyEatView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    _myEatView.alpha = 1.0;
    [self.view addSubview:_myEatView];
    
    
       
}

- (void)buttonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _animationLabel.frame = CGRectMake(CGRectGetMaxX(self.leftButton.frame) +  (ScreenWidth - CGRectGetMaxX(self.leftButton.frame) * 2) / 3 * (sender.tag - 50), 61,  (ScreenWidth - CGRectGetMaxX(self.leftButton.frame) * 2) / 3, 3);
    }];
    switch ((int)sender.tag - 50) {
        case 0:
            _myEatView.alpha = 1.0;
            _myDoView.alpha = 0.0;
            _mySendView.alpha = 0.0;
            break;
        case 1: {
            if (!_myDoView) {
            
                _myDoView = [[MyDoView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
                _myDoView.alpha = 0.0;
                [self.view addSubview:_myDoView];
                
            }
            _myEatView.alpha = 0.0;
            _myDoView.alpha = 1.0;
            _mySendView.alpha = 0.0;
        }   break;
        case 2:{
            if (!_mySendView) {
                
                _mySendView = [[MySendView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
                _mySendView.alpha = 0.0;
                [self.view addSubview:_mySendView];
                
            }
            _myEatView.alpha = 0.0;
            _myDoView.alpha = 0.0;
            _mySendView.alpha = 1.0;
        }   break;
        default:
            break;
    }

    
}
- (void)barButtonItemMethod {
    
//    [self removeFromParentViewController];
//    [self.view removeFromSuperview];
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
//    [self transitionFromViewController:(UIViewController *) toViewController:nil duration:0.3 options:UIViewAnimationCurveEaseInOut animations:nil completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
