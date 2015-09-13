//
//  WaitForAuditViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/6.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "WaitForAuditViewController.h"

@interface WaitForAuditViewController ()

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation WaitForAuditViewController

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
//    [dvc.tabBarController setHideEsunTabBarBtn:YES];
}

- (void)initializeInterface {
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"等待审核";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake((ScreenWidth - 130) / 2, 64 + 75, 130, 130);
    imageView.image = [UIImage imageNamed:@"tb10"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(40, CGRectGetMaxY(imageView.frame) + 60, ScreenWidth - 80, 50);
    label.text = @"您的资料提交成功!我们会在24小时内处理，请耐心等待审核。";
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:label];
}

- (void)barButtonItemMethod {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
