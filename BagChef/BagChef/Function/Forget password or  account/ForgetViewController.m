//
//  ForgetViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/15.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ForgetViewController.h"
#import "ModifyPasswordViewController.h"
@interface ForgetViewController () {
    
    UITextField *telTextField; //手机号
    UITextField *vertificationTextField; //手机验证码
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation ForgetViewController

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
    
    telTextField = [[UITextField alloc]init];
    telTextField.placeholder = @"请输入手机号";
    telTextField.frame = CGRectMake(CGRectGetMaxX(telImageView.frame) + 10 , CGRectGetMaxY(telImageView.frame) - 20, ScreenWidth - CGRectGetMaxX(telImageView.frame) - 10 - 10, 20);
    [loginView addSubview:telTextField];
    
    //分割线
    UILabel *cut_offLabel = [[UILabel alloc]init];
    cut_offLabel.frame = CGRectMake(10, CGRectGetMaxY(telImageView.frame) + 12, ScreenWidth - 20, 1);
    cut_offLabel.backgroundColor = [UIColor colorWithRed:0.902f green:0.902f blue:0.902f alpha:1.00f];
    [loginView addSubview:cut_offLabel];
    
    //验证
    UIImageView *vertificationImageView = [[UIImageView alloc]init];
    vertificationImageView.frame = CGRectMake(12, CGRectGetMaxY(cut_offLabel.frame) + 12, 23, 23);
    [vertificationImageView setImage:[UIImage imageNamed:@"login-2"]];
    [loginView addSubview:vertificationImageView];
    
    vertificationTextField = [[UITextField alloc]init];
    vertificationTextField.placeholder = @"手机验证码";
    vertificationTextField.frame = CGRectMake(CGRectGetMaxX(vertificationImageView.frame) + 10 , CGRectGetMaxY(vertificationImageView.frame) - 20, 100, 20);
    [loginView addSubview:vertificationTextField];
    
    UIButton *vertificationBtn = [[UIButton alloc]init];
    vertificationBtn.frame = CGRectMake(ScreenWidth - 120 - 10 , CGRectGetMaxY(cut_offLabel.frame), 120, 52);
    [vertificationBtn setBackgroundImage:[UIImage imageNamed:@"yanzhengma_bg"] forState:UIControlStateNormal];
    [vertificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [vertificationBtn addTarget:self action:@selector(getVertificationBtn) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:vertificationBtn];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(loginView.frame) + 25, ScreenWidth - 20 - 20, 39);
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
}

- (void)getVertificationBtn {
    
    [NetWorkHandler forgetPasswdSmsCheckTwoParams:@{@"tel":telTextField.text} completionHandler:^(id content) {
        NSLog(@"%@",content);
        NSLog(@"%@",content[@"info"]);
   }];
}

- (void)leftBarButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonPressed {
    
    ModifyPasswordViewController *mvc = [[ModifyPasswordViewController alloc]init];
    [self.navigationController pushViewController:mvc animated:YES];
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
