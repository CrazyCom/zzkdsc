//
//  ModifyPasswordViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/21.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController () {
    
    UITextField *_pwdTextField;
    UITextField *_pwdTextFieldT;
}


- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation ModifyPasswordViewController

- (void)initializeDataSource {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    
    dvc.mainNavController.navigationBarHidden = YES;
    NSLog(@"0000%@",NSStringFromCGRect(self.view.frame));
    
}


- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.titleLabel.text = @"找回密码";
    //    self.rightLabel.text = @"注册";
    
    
    self.leftButton.hidden = NO;
    
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftBarButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *loginView = [[UIView alloc]init];
    loginView.frame = CGRectMake(0, 77, ScreenWidth, 100);
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    
    //手机号
    UIImageView *telImageView = [[UIImageView alloc]init];
    telImageView.frame = CGRectMake(12, 12, 23, 23);
    [telImageView setImage:[UIImage imageNamed:@"login-1"]];
    [loginView addSubview:telImageView];
    
    _pwdTextField = [[UITextField alloc]init];
    _pwdTextField.placeholder = @"新密码至少为6位";
    _pwdTextField.frame = CGRectMake(CGRectGetMaxX(telImageView.frame) + 10 , CGRectGetMaxY(telImageView.frame) - 20, ScreenWidth - CGRectGetMaxX(telImageView.frame) - 10 - 10, 20);
    [loginView addSubview:_pwdTextField];
    
    //分割线
    UILabel *cut_offLabel = [[UILabel alloc]init];
    cut_offLabel.frame = CGRectMake(10, CGRectGetMaxY(telImageView.frame) + 12, ScreenWidth - 20, 1);
    cut_offLabel.backgroundColor = [UIColor colorWithRed:0.902f green:0.902f blue:0.902f alpha:1.00f];
    [loginView addSubview:cut_offLabel];
    
    //验证
    UIImageView *vertificationImageView = [[UIImageView alloc]init];
    vertificationImageView.frame = CGRectMake(12, CGRectGetMaxY(cut_offLabel.frame) + 12, 23, 23);
    [vertificationImageView setImage:[UIImage imageNamed:@"login-1"]];
    [loginView addSubview:vertificationImageView];
    
    _pwdTextFieldT = [[UITextField alloc]init];
    _pwdTextFieldT.placeholder = @"再次输入新密码";
    _pwdTextFieldT.frame = CGRectMake(CGRectGetMaxX(vertificationImageView.frame) + 10 , CGRectGetMaxY(vertificationImageView.frame) - 20, ScreenWidth - CGRectGetMaxX(vertificationImageView.frame) - 10 - 10, 20);
    [loginView addSubview:_pwdTextFieldT];
    
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(loginView.frame) + 25, ScreenWidth - 20 - 20, 39);
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
}

- (void)getVertificationBtn {
    
   
}

- (void)leftBarButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
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
