//
//  MyEnshrineViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/7.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyEnshrineViewController.h"
#import "MyEnshrineOfMenuView.h"
#import "MyEnshrineOfPrivateChefView.h"

@interface MyEnshrineViewController () {
    
    UILabel *_animationLabel;
    
    UIView *view;
    UIView *view1;
    MyEnshrineOfMenuView *_myEnshrineOfMenuView;
    MyEnshrineOfPrivateChefView *_myEnshrineOfPrivateChefView;
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation MyEnshrineViewController


- (void)initializeDataSource {
    
    
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
    self.titleLabel.text = @"我的收藏";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.tag = 500;

    
    for ( int i = 0; i < 2 ; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0 + ScreenWidth / 2 * i, 64, ScreenWidth / 2, 54);
        btn.tag = 40 + i;
        if (i == 0) {
            [btn setTitle:@"菜品" forState:UIControlStateNormal];
            [btn setTitle:@"菜品" forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else {
            [btn setTitle:@"私厨" forState:UIControlStateNormal];
            [btn setTitle:@"私厨" forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    _animationLabel = [[UILabel alloc]init];
    _animationLabel.frame = CGRectMake(0, 112, ScreenWidth / 2, 2);
    _animationLabel.backgroundColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    [self.view addSubview:_animationLabel];
    
    
    _myEnshrineOfMenuView = [[MyEnshrineOfMenuView alloc]initWithFrame:CGRectMake(0, 114, ScreenWidth , ScreenHeight - 114)];
    _myEnshrineOfMenuView.alpha = 1.0;
    [self.view addSubview:_myEnshrineOfMenuView];
    
    _myEnshrineOfPrivateChefView = [[MyEnshrineOfPrivateChefView alloc]initWithFrame:CGRectMake(0, 114, ScreenWidth, ScreenHeight - 114)];
    _myEnshrineOfPrivateChefView.alpha = 0.0;
    [self.view addSubview:_myEnshrineOfPrivateChefView];
    
    

}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonPressed:(UIButton *)sender {
    NSLog(@"%d",(int)sender.tag);
    [UIView animateWithDuration:0.3 animations:^{
        _animationLabel.frame = CGRectMake(0 + (ScreenWidth / 2) * (sender.tag - 40), 112, ScreenWidth / 2, 2);
    }];
    switch (sender.tag - 40) {
        case 0:
            _myEnshrineOfMenuView.alpha = 1.0;
            _myEnshrineOfPrivateChefView.alpha = 0.0;
            break;
        case 1:
            _myEnshrineOfMenuView.alpha = 0.0;
            _myEnshrineOfPrivateChefView.alpha = 1.0;
            break;
        default:
            break;
    }
    
    if (sender.tag == 500) {
        NSLog(@",,,,");
    }
    
    
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
