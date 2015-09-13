//
//  LoginViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/13.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"

#import "ApplyToJoinPrivateChefViewController.h"

@interface LoginViewController () {
    
    UITextField *telTextField;
    UITextField *pwdTextField;
    
    ApplyToJoinPrivateChefViewController *_applyToJoinPrivateChefViewController;
    
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation LoginViewController

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
//    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBar:YES];
    
    NSLog(@"0000%@",NSStringFromCGRect(self.view.frame));

}


- (void)initializeInterface {
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    self.view.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
    self.titleLabel.text = @"登录";
//    self.rightLabel.text = @"注册";
    
    
    self.leftButton.hidden = NO;
    
    [self.leftButton setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftBarButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightBarButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *loginView = [[UIView alloc]init];
    loginView.frame = CGRectMake(0, 77, ScreenWidth, 100);
    loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginView];
    
    //手机号
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.frame = CGRectMake(12, 12, 23, 23);
    [imageView1 setImage:[UIImage imageNamed:@"login-1"]];
    [loginView addSubview:imageView1];
    
    telTextField = [[UITextField alloc]init];
    telTextField.placeholder = @"请输入手机号";
    telTextField.frame = CGRectMake(CGRectGetMaxX(imageView1.frame) + 10 , CGRectGetMaxY(imageView1.frame) - 20, ScreenWidth - CGRectGetMaxX(imageView1.frame) - 10 - 10, 20);
    [loginView addSubview:telTextField];
    
    //分割线
    UILabel *cut_offLabel = [[UILabel alloc]init];
    cut_offLabel.frame = CGRectMake(10, CGRectGetMaxY(imageView1.frame) + 12, ScreenWidth - 20, 1);
    cut_offLabel.backgroundColor = [UIColor colorWithRed:0.902f green:0.902f blue:0.902f alpha:1.00f];
    [loginView addSubview:cut_offLabel];
    
    //密码
    UIImageView *imageView2 = [[UIImageView alloc]init];
    imageView2.frame = CGRectMake(12, CGRectGetMaxY(cut_offLabel.frame) + 12, 23, 23);
    [imageView2 setImage:[UIImage imageNamed:@"key"]];
    [loginView addSubview:imageView2];

    pwdTextField = [[UITextField alloc]init];
    pwdTextField.placeholder = @"密码至少为6位";
    pwdTextField.frame = CGRectMake(CGRectGetMaxX(imageView2.frame) + 10 , CGRectGetMaxY(imageView2.frame) - 20, ScreenWidth - CGRectGetMaxX(imageView2.frame) - 10 - 10, 20);
    [loginView addSubview:pwdTextField];
  
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(18, CGRectGetMaxY(loginView.frame) + 25, 13.5, 13.5);
    [btn setBackgroundImage:[UIImage imageNamed:@"choose_reg_nor"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"choose_reg"] forState:UIControlStateSelected];
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
    
    UIButton *forgetBtn = [[UIButton alloc]init];
    forgetBtn.frame = CGRectMake(CGRectGetMaxX(delegateLabel.frame) + 10, CGRectGetMinY(delegateLabel.frame), ScreenWidth - CGRectGetMaxX(delegateLabel.frame) - 20, 15);
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetBtn setTitleColor:[UIColor colorWithRed:0.522f green:0.522f blue:0.522f alpha:1.00f] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.frame = CGRectMake(20, CGRectGetMaxY(btn.frame) + 25, ScreenWidth - 20 - 20, 39);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    NSLog(@"10%@",NSStringFromCGRect(self.view.frame));
    
    _applyToJoinPrivateChefViewController = [[ApplyToJoinPrivateChefViewController alloc]init];
    
    telTextField.text = @"13800138001";
    pwdTextField.text = @"111111";
    
}

- (void)leftBarButtonItemMethod {
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [super navBackController];
    
}

- (void)rightBarButtonMethod {
    
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
    NSLog(@"---");
}

- (void)forgetBtn:(UIButton *)btn {
    
    ForgetViewController *fvc=  [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)loginBtn {
    
   
    [self.view endEditing:YES];
    
    if (telTextField.text.length == 0 || pwdTextField.text.length == 0) {
        [DisplayView displayShowWithTitle:@"手机号或密码不能为空"];
        
        return;
    }
    if (telTextField.text.length != 11) {
        [DisplayView displayShowWithTitle:@"请输入正确的手机号码"];
        return;
    }
    else {
        self.view.userInteractionEnabled = NO;
        
        [DisplayView displayShowWithTitle:@"正在登录中"];
        
        
        __weak typeof (self)myself = self;
        
        
        NSDictionary *dict = @{@"tel":telTextField.text,@"pwd":pwdTextField.text};
        
        [NetWorkHandler loginParams:dict completionHandler:^(id content) {
            
            //记录登录状态
            [Common loginRecord];
            
            [DisplayView hideTitle];
            
            myself.view.userInteractionEnabled = YES;
            
            [DisplayView displayShowWithTitle:content[@"info"]];
            NSLog(@"%@",content);
            NSLog(@"data:%@",content[@"data"]);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //        [userDefaults setObject:content[@"data"] forKey:@"userData"];
            [userDefaults setObject:content[@"data"][@"pwd"] forKey:@"pwd"];
            [userDefaults setObject:content[@"data"][@"tel"] forKey:@"tel"];
            [userDefaults setObject:content[@"data"][@"is_chef"] forKey:@"is_chef"];
            [userDefaults setObject:content[@"data"][@"is_express"] forKey:@"is_express"];
//            [userDefaults setObject:content[@"data"][@"is_express"] forKey:@"is_express"];
            [userDefaults setObject:content[@"data"][@"uid"] forKey:@"uid"];
            [userDefaults synchronize];
            
            //发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"personalInformation" object:nil userInfo:content[@"data"]];
            
            
//            [myself.navigationController pushViewController:_applyToJoinPrivateChefViewController animated:YES];
            
            [myself dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
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
