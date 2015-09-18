//
//  PrivateChefViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "PrivateChefViewController.h"

#import "ApplyToJoinGourmet.h"
#import "UploadInformationOfMenu.h"
#import "HomePageOfPrivateChef.h"
#import "ApplyToJoinPrivateChefViewController.h"

#import "HadUploadMenuViewController.h"
#import "MainViewController.h"

@interface PrivateChefViewController () {
    
    UILabel *numLabel;
    
    ApplyToJoinGourmet *_applyToJoinGourmet;
    UploadInformationOfMenu *_uploadInformationofMenu;
    LoginViewController *_loginViewController;
    
    UIView *addPrivateChefView;
    UIView *hadBeenPrivateChefView;
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation PrivateChefViewController

- (void)initializeDataSource {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"is_chef"] integerValue] == 1 ) {
        
        [self changeToHadBeen];
        return;
    }
   
    
    
    
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    
    if ([tel isEqual:[NSNull class]] && [pwd isEqual:[NSNull class]]) {
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd};
        [NetWorkHandler getUserInfoParams:dict completionHandler:^(id content) {
            NSLog(@"%@",content);
            
            if ([content[@"data"][@"is_chef"] integerValue] == 1) {
                
                [self changeToHadBeen];
            }

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:content[@"data"][@"is_chef"] forKey:@"is_chef"];
            
            //        [userDefaults setObject:content[@"data"][@"is_express"] forKey:@"is_express"];
            [userDefaults synchronize];
        }];
    }
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
//    MainViewController *mvc = [[MainViewController alloc]init];
//    mvc.navigationController.navigationBarHidden = YES;
    
    [self initializeDataSource];
    [self initializeInterface];
    [self changeToAdd];
    
    _applyToJoinGourmet = [[ApplyToJoinGourmet alloc]init];
    _uploadInformationofMenu = [[UploadInformationOfMenu alloc]init];

}

- (void)changeToAdd {

    [hadBeenPrivateChefView removeFromSuperview];
    [self initWithaddPrivateChefView];
}

- (void)changeToHadBeen {

    [addPrivateChefView removeFromSuperview];
    
    [self initWithhadBeenPrivateChefView ];
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:NO];
    //    dvc.mainNavController.navigationBarHidden = YES;
    
    
    if ([Common isHadLogin]) {
        
        [self initializeDataSource];
        
    }
    else {
        
        [self changeToAdd];
        
    }

    [self.view bringSubviewToFront:self.navView];
}

- (void)initWithaddPrivateChefView {
    
    self.rightButton.hidden = YES;
    [addPrivateChefView removeFromSuperview];
    addPrivateChefView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    [self.view addSubview:addPrivateChefView];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    imageView1.frame = CGRectMake((ScreenWidth - (ScreenWidth - 50)*ratioX) / 2, 124, (ScreenWidth - 50) * ratioX, (ScreenWidth - 50) *1.02  *ratioY);
    [imageView1 setImage:[UIImage imageNamed:@"privatechef"]];
    [addPrivateChefView addSubview:imageView1];
    
    NSLog(@"%lf",ScreenWidth - CGRectGetMaxX(imageView1.frame));
    
    numLabel = [[UILabel alloc]init];
    numLabel.text = @"1000000000";
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(CGRectGetMinX(imageView1.frame), CGRectGetMaxY(imageView1.frame) + 15 *ratioY, CGRectGetWidth(imageView1.frame), 20 );
    label.text = [NSString stringWithFormat:@"现有%@人加入私厨",numLabel.text];
    label.textAlignment = NSTextAlignmentCenter;
    [addPrivateChefView addSubview:label];
    
    UIButton *joinBtn = [[UIButton alloc]init];
    joinBtn.frame = CGRectMake(30, CGRectGetMaxY(imageView1.frame) + 50 * ratioY, ScreenWidth - 60, 37);
    joinBtn.tag = 10000;
    [joinBtn setTitle:@"立即加入" forState:UIControlStateNormal];
    [joinBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [addPrivateChefView addSubview:joinBtn];
    
   
    [self.view bringSubviewToFront:joinBtn];
    

}

- (void)initWithhadBeenPrivateChefView {
    
    [hadBeenPrivateChefView removeFromSuperview];
    hadBeenPrivateChefView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight - 64 - 49)];
    [self.view addSubview:hadBeenPrivateChefView];
    
    UIButton *imageViewBtn = [[UIButton alloc]init];
    imageViewBtn.frame = CGRectMake((ScreenWidth - 200) / 2, 90 *ratioY, 200, 200);
    [imageViewBtn setBackgroundImage:[UIImage imageNamed:@"upMenubackground"] forState:UIControlStateNormal];
    imageViewBtn.tag = 10001;
    [imageViewBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [hadBeenPrivateChefView addSubview:imageViewBtn];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake((200 - 90) / 2,  80, 90, 30);
    label.text = @"上传菜品";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [imageViewBtn addSubview:label];
    
    UILabel *noLabel = [[UILabel alloc]init];
    noLabel.frame = CGRectMake(10, CGRectGetMaxY(imageViewBtn.frame) +30, ScreenWidth - 20, 30);
    noLabel.text = @"请点击右上角图标,查看自己已上传菜品!";
    noLabel.textColor = [UIColor colorWithRed:0.557f green:0.557f blue:0.557f alpha:1.00f];
    noLabel.font = [UIFont systemFontOfSize:14];
    noLabel.textAlignment = NSTextAlignmentCenter;
    [hadBeenPrivateChefView addSubview:noLabel];
    
    self.rightButton.hidden = NO;
    self.rightButton.tag = 10002;
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initializeInterface {
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"我是私厨";
    self.titleLabel.hidden = NO;
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    
   
    [self.rightButton setImage:[UIImage imageNamed:@"cai_list"] forState:UIControlStateNormal];
    
    
    
}



- (void)barButtonItem {
    
    [super slidingNavgationMenu];
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSLog(@"我是私厨");
    //    [self.navigationController pushViewController:_applyToJoinGourmet animated:YES];
    //    [self.navigationController pushViewController:_uploadInformationofMenu animated:YES];
    //
//    HomePageOfPrivateChef *hvc = [[HomePageOfPrivateChef alloc]init];
//    [self.navigationController pushViewController:hvc animated:YES];
//    ApplyToJoinPrivateChefViewController *apvc = [[ApplyToJoinPrivateChefViewController alloc]init];
//    [self.navigationController pushViewController:apvc animated:YES];
//    _loginViewController.hidesBottomBarWhenPushed = YES;
    if (sender.tag == 10000) {
        if ([Common isHadLogin]) {
            
            ApplyToJoinPrivateChefViewController *vc = [[ApplyToJoinPrivateChefViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            _loginViewController = [[LoginViewController alloc]init];
            UINavigationController *navLogin = [[UINavigationController alloc]initWithRootViewController:_loginViewController];
            [self.navigationController presentViewController:navLogin animated:YES completion:nil];
            //        [self.navigationController pushViewController:_loginViewController animated:YES];
        }

    }
    else if (sender.tag == 10001) {
        
        _uploadInformationofMenu = [[UploadInformationOfMenu alloc]init];
        [self.navigationController pushViewController:_uploadInformationofMenu animated:YES];
    }
    else if (sender.tag == 10002) {
        
        
        HadUploadMenuViewController *mvc = [[HadUploadMenuViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mvc];
//        [self presentViewController:mvc animated:YES completion:nil];
        [self.navigationController pushViewController:mvc animated:YES];
        NSLog(@"----");
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

