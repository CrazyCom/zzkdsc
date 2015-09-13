//
//  RegisterViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/15.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController () {
    
    UITextField *telTextField; //手机号
    UITextField *pwdTextField; //密码
    UITextField *confirmPwdTextField; //确认密码
    UITextField *vertificationTextField; //获取验证码
}

- (void)initializeDataSource;

- (void)initializeInterface;

@end

@implementation RegisterViewController

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
    
//    dvc.mainNavController.navigationBarHidden = YES;
    NSLog(@"0000%@",NSStringFromCGRect(self.view.frame));
    
}


- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.titleLabel.text = @"注册";
    //    self.rightLabel.text = @"注册";
    
    
    self.leftButton.hidden = NO;
    
    [self.leftButton setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftBarButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
//    self.rightButton.hidden = NO;
//    [self.rightButton setTitle:@"登录" forState:UIControlStateNormal];
//    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(rightBarButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *loginView = [[UIView alloc]init];
    loginView.frame = CGRectMake(0, 77, ScreenWidth, 193);
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
    
    //密码
    UIImageView *pwdImageView = [[UIImageView alloc]init];
    pwdImageView.frame = CGRectMake(12, CGRectGetMaxY(cut_offLabel.frame) + 12, 23, 23);
    [pwdImageView setImage:[UIImage imageNamed:@"key"]];
    [loginView addSubview:pwdImageView];
    
    pwdTextField = [[UITextField alloc]init];
    pwdTextField.placeholder = @"密码至少为6位";
    pwdTextField.frame = CGRectMake(CGRectGetMaxX(pwdImageView.frame) + 10 , CGRectGetMaxY(pwdImageView.frame) - 20, ScreenWidth - CGRectGetMaxX(pwdImageView.frame) - 10 - 10, 20);
    [loginView addSubview:pwdTextField];
    
    //确认密码
    
    //分割线
    UILabel *cut_offLabel1 = [[UILabel alloc]init];
    cut_offLabel1.frame = CGRectMake(10, CGRectGetMaxY(pwdImageView.frame) + 12, ScreenWidth - 20, 1);
    cut_offLabel1.backgroundColor = [UIColor colorWithRed:0.902f green:0.902f blue:0.902f alpha:1.00f];
    [loginView addSubview:cut_offLabel1];
    
    //密码
    UIImageView *confirmPwdImageView = [[UIImageView alloc]init];
    confirmPwdImageView.frame = CGRectMake(12, CGRectGetMaxY(cut_offLabel1.frame) + 12, 23, 23);
    [confirmPwdImageView setImage:[UIImage imageNamed:@"key"]];
    [loginView addSubview:confirmPwdImageView];
    
    confirmPwdTextField = [[UITextField alloc]init];
    confirmPwdTextField.placeholder = @"请再次输入密码";
    confirmPwdTextField.frame = CGRectMake(CGRectGetMaxX(confirmPwdImageView.frame) + 10 , CGRectGetMaxY(confirmPwdImageView.frame) - 20, ScreenWidth - CGRectGetMaxX(confirmPwdImageView.frame) - 10 - 10, 20);
    [loginView addSubview:confirmPwdTextField];

    //
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(18, CGRectGetMaxY(loginView.frame) + 25, 13.5, 13.5);
    [btn setBackgroundImage:[UIImage imageNamed:@"choose_reg_nor"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"choose_reg"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UILabel *hadReadLabel = [[UILabel alloc]init];
    hadReadLabel.frame = CGRectMake(CGRectGetMaxX(btn.frame) + 5, CGRectGetMinY(btn.frame), 80, 15);
    hadReadLabel.text = @"已阅读并同意";
    //    hadReadLabel.textColor = [UIColor whiteColor];
    hadReadLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:hadReadLabel];
    
    UILabel *delegateLabel = [[UILabel alloc]init];
    delegateLabel.frame = CGRectMake(CGRectGetMaxX(hadReadLabel.frame), CGRectGetMinY(btn.frame), 110, 15);
    delegateLabel.textColor = [UIColor colorWithRed:1.000f green:0.416f blue:0.263f alpha:1.00f];
    delegateLabel.font = [UIFont systemFontOfSize:13];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"《用户使用协议》"]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    delegateLabel.attributedText = content;
    [self.view addSubview:delegateLabel];
    
//    UILabel *forgetLabel = [[UILabel alloc]init];
//    forgetLabel.frame = CGRectMake(CGRectGetMaxX(delegateLabel.frame) + 10, CGRectGetMinY(delegateLabel.frame), ScreenWidth - CGRectGetMaxX(delegateLabel.frame) - 20, 15);
//    forgetLabel.text = @"忘记密码?";
//    forgetLabel.font = [UIFont systemFontOfSize:13];
//    forgetLabel.textAlignment = NSTextAlignmentRight;
//    forgetLabel.textColor = [UIColor colorWithRed:0.522f green:0.522f blue:0.522f alpha:1.00f];
//    [self.view addSubview:forgetLabel];
    
    //分割线
    UILabel *cut_offLabel2 = [[UILabel alloc]init];
    cut_offLabel2.frame = CGRectMake(10, CGRectGetMaxY(confirmPwdImageView.frame) + 12, ScreenWidth - 20, 1);
    cut_offLabel2.backgroundColor = [UIColor colorWithRed:0.902f green:0.902f blue:0.902f alpha:1.00f];
    [loginView addSubview:cut_offLabel2];

    //验证
    UIImageView *vertificationImageView = [[UIImageView alloc]init];
    vertificationImageView.frame = CGRectMake(12, CGRectGetMaxY(cut_offLabel2.frame) + 12, 23, 23);
    [vertificationImageView setImage:[UIImage imageNamed:@"login-2"]];
    [loginView addSubview:vertificationImageView];
    
    vertificationTextField = [[UITextField alloc]init];
    vertificationTextField.placeholder = @"手机验证码";
    vertificationTextField.frame = CGRectMake(CGRectGetMaxX(vertificationImageView.frame) + 10 , CGRectGetMaxY(vertificationImageView.frame) - 20, 100, 20);
    [loginView addSubview:vertificationTextField];
    
    UIButton *vertificationBtn = [[UIButton alloc]init];
    vertificationBtn.frame = CGRectMake(ScreenWidth - 120 - 10 , CGRectGetMaxY(cut_offLabel2.frame), 120, 49);
    [vertificationBtn setBackgroundImage:[UIImage imageNamed:@"yanzhengma_bg"] forState:UIControlStateNormal];
    [vertificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [vertificationBtn addTarget:self action:@selector(getVertificationBtn) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:vertificationBtn];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(btn.frame) + 25, ScreenWidth - 20 - 20, 39);
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)leftBarButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getVertificationBtn {
    
    [NetWorkHandler getSmsCheckParams:@{@"tel":telTextField.text} completionHandler:^(id content) {
        NSLog(@"getVertification:%@",content);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:content[@"data"] forKey:@"sms"];
//        [defaults setObject:content[@"data"] forKey:@"smsVertification"];
        [defaults synchronize];
    }];
}

//注册
- (void)registerBtn {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *registerDict = @{@"sms":[defaults objectForKey:@"sms"],@"tel":telTextField.text,@"pwd":pwdTextField.text,@"pwd1":confirmPwdTextField.text} ;
    
    
    [NetWorkHandler checkSmsCheckParams:registerDict completionHandler:^(id content) {
        NSLog(@"%@",content);
        if (content) {
//            NSDictionary *dict = @{@"tel":telTextField.text,@"pwd":pwdTextField.text};
            [NetWorkHandler registerVipParams:registerDict completionHandler:^(id content) {
                NSLog(@"register:%@",content);
                NSLog(@"registerInfo:%@:",content[@"info"]);
                [self.navigationController popViewControllerAnimated:YES];
            }];

        }
    }];
    
//    if ([vertificationTextField.text isEqualToString:[defaults objectForKey:@"smsVertification"]]) {
    
//        NSDictionary *dict = @{@"tel":telTextField.text,@"pwd":pwdTextField.text};
//        [NetWorkHandler registerVipParams:dict completionHandler:^(id content) {
//            NSLog(@"register:%@",content);
//        }];
//    }
    
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
