//
//  ArmedEscortViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ArmedEscortViewController.h"
#import "ApplyToJoinArmedEscort.h"
#import "LoginViewController.h"
#import "IsArmedEscortTableViewCell.h"
#import <BaiduMapAPI/BMapKit.h>
@interface ArmedEscortViewController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate> {
    
    ApplyToJoinArmedEscort *_applyToJoinArmedEscort;
    LoginViewController *_loginViewController;
    
    BOOL _isArmedEscort;
    BOOL _isUpdateLocation;
    
    UIView *isArmedEscortView;            //已经是镖师
    UIView *isNotArmedEscortView;         //还不是是镖师
    
    UITableView *_tableView;
    
    int page;
    NSMutableArray *_dataSource;
    
    //定位
    BMKLocationService *_locationService;
    
    float _updateTime;
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation ArmedEscortViewController


- (void)initializeDataSource {
    
    _dataSource = [[NSMutableArray alloc]init];
    page = 1;
    _locationService = [[BMKLocationService alloc]init];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if ([[defaults objectForKey:@"is_express"] integerValue] == 1 ) {
        
        [self changeToHadBeen];
        [self footRefreshing];
        return;
        
    }
    
    
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];

    if ([tel isEqual:[NSNull class]] && [pwd isEqual:[NSNull class]]) {
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd};
        [NetWorkHandler getUserInfoParams:dict completionHandler:^(id content) {
            NSLog(@"%@",content);
            
            if ([content[@"data"][@"is_express"] integerValue] == 1) {
                
                [self changeToHadBeen];
            }
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:content[@"data"][@"is_chef"] forKey:@"is_express"];
        
            [userDefaults synchronize];
        }];
    }
 
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([[defaults objectForKey:@"is_chef"] integerValue] == 1 ) {
//        
//        [self changeToHadBeen];
//        return;
//    }
//    NSString *tel = [defaults objectForKey:@"tel"];
//    NSString *pwd = [defaults objectForKey:@"pwd"];
//    
//    if ([tel isEqual:[NSNull class]] && [pwd isEqual:[NSNull class]]) {
//        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd};
//        [NetWorkHandler getUserInfoParams:dict completionHandler:^(id content) {
//            NSLog(@"%@",content);
//            
//            if ([content[@"data"][@"is_chef"] integerValue] == 1) {
//                
//                [self changeToHadBeen];
//            }
//            
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setObject:content[@"data"][@"is_chef"] forKey:@"is_chef"];
//            
//            //        [userDefaults setObject:content[@"data"][@"is_express"] forKey:@"is_express"];
//            [userDefaults synchronize];
//        }];
//    }

}

- (void)updateUserAddress {
    
    //
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"lat":[AppDelegate app].lat,@"lon":[AppDelegate app].lon};
   
    [NetWorkHandler updateExpressCoord:dict completionHandler:^(id content) {
            
            NSLog(@"updateExpressCoord%@",content);
   
            
    }];
    
    [self performSelector:@selector(updateUserAddress) withObject:nil afterDelay:_updateTime];
    
}

- (void)changeToAdd {
    
    [isArmedEscortView removeFromSuperview];
    [self isNotArmedEscortInterface];
}

- (void)changeToHadBeen {
    
    [isNotArmedEscortView removeFromSuperview];
    
    [self isArmedEscortInterface];
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:NO];

    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    if ([[defaults objectForKey:@"is_express"] integerValue] == 1 ) {
//        
//        [self changeToHadBeen];
//        page = 1;
//        _dataSource = [[NSMutableArray alloc]init];
//        _locationService.delegate = self;
//        [_locationService startUserLocationService];
//        [self footRefreshing];
//       
//        
//    }
//    else {
//        
//        [self changeToAdd];
//    }
    
    
    if ([Common isHadLogin]) {
        
        [self initializeDataSource];
        
    }
    else {
        
        [self changeToAdd];
        
    }
    
//    [self.view bringSubviewToFront:self.navView];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    _locationService.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initializeDataSource];
    [self initializeInterface];
    [self changeToAdd];

}

- (void)initializeInterface {
    
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"我是镖师";
    [self.leftButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    

}

- (void)isArmedEscortInterface {
    
    [isNotArmedEscortView removeFromSuperview];
    
    isArmedEscortView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight - 64 - 49)];
    [self.view addSubview:isArmedEscortView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(isArmedEscortView.frame)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [isArmedEscortView addSubview:_tableView];
    
    //下拉刷新
    [_tableView addFooterWithTarget:self action:@selector(footRefreshing)];
    
    //上传镖师坐标
    [NetWorkHandler getCoordUptime:nil completionHandler:^(id content) {
        
        if (VALID_STRING(content[@"data"])) {
            
            _updateTime = [content[@"data"] floatValue];
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateUserAddress) object:nil];
//            [self performSelector:@selector(updateUserAddress) withObject:nil afterDelay:_updateTime];
            [self updateUserAddress];
        }
        NSLog(@"getCoordTimes:%@",content);
    }];

}

- (void)isNotArmedEscortInterface {
    
    [isArmedEscortView removeFromSuperview];
    isNotArmedEscortView = [[UIView alloc]initWithFrame:CGRectMake(0,60, ScreenWidth, ScreenHeight - 60 - 49)];
    [self.view addSubview:isNotArmedEscortView];
    
    UIImageView *imageView1 = [[UIImageView alloc]init];
    //    imageView1.frame = CGRectMake(60 ,  64 + 25 , (ScreenWidth - 140 ) *ratioX , (ScreenWidth - 140) * 1.29 *ratioY);
    imageView1.frame = CGRectMake((ScreenWidth - (ScreenWidth - 60)*ratioX) / 2, 25, (ScreenWidth - 60) * ratioX, (ScreenWidth - 50) *1.17  *ratioY);;
    //    imageView.backgroundColor = [UIColor redColor];
    [imageView1 setImage:[UIImage imageNamed:@"armedescort"]];
    [isNotArmedEscortView addSubview:imageView1];
    
    UIButton *joinBtn = [[UIButton alloc]init];
    joinBtn.frame = CGRectMake(20, CGRectGetMaxY(imageView1.frame) + 40 * ratioY, ScreenWidth - 40, 37);
    [joinBtn setTitle:@"立即加入" forState:UIControlStateNormal];
    [joinBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [isNotArmedEscortView addSubview:joinBtn];
    
    _applyToJoinArmedEscort = [[ApplyToJoinArmedEscort alloc]init];

}

- (void)barButtonItem {
    
    [super slidingNavgationMenu];
}

- (void)buttonPressed {
    
    
    if ([Common isHadLogin]) {
        
        [self.navigationController pushViewController:_applyToJoinArmedEscort animated:YES];
    }
    else {
        _loginViewController = [[LoginViewController alloc]init];
        UINavigationController *navLogin = [[UINavigationController alloc]initWithRootViewController:_loginViewController];
        [self.navigationController presentViewController:navLogin animated:YES completion:nil];
        //        [self.navigationController pushViewController:_loginViewController animated:YES];
    }

    
//    LoginViewController *lvc = [[LoginViewController alloc]init];
//    [self.navigationController pushViewController:lvc animated:YES];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"CELLID";
    IsArmedEscortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[IsArmedEscortTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ArmedEscortModel *model = [[ArmedEscortModel alloc]initWithDicitonary:_dataSource[indexPath.section]];
    [cell setCellModel:model];
    
    cell.ButtonClick = ^(IsArmedEscortTableViewCell *cell) {
        
        NSLog(@"haha");
        NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
        NSString *order_num = _dataSource[indexPath.section][@"order_num"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *tel = [defaults objectForKey:@"tel"];
        NSString *pwd = [defaults objectForKey:@"pwd"];
        
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num};
        [NetWorkHandler pickByExpress:dict completionHandler:^(id content) {
            NSLog(@"pickByExpress:%@",content);
        }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.bounds = CGRectMake(0, 0, ScreenWidth, 10);
    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - <数据加载>
//#pragma mark 下拉刷新
//数据刷新
- (void)footRefreshing {
    
//    if ([AppDelegate app].lat == nil && [AppDelegate app].lon == nil) {
//        
//        _locationService.delegate = self;
//       [_locationService startUserLocationService];
//    }
    
//    else {
    
//        NSDictionary *dict = @{@"lat":[AppDelegate app].lat,@"lon":[AppDelegate app].lon,@"page":[NSString stringWithFormat:@"%i",page]};
    
    
    
    __weak typeof(self)myself = self;
    [myself showLoading];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"page":[NSString stringWithFormat:@"%i",page]};
    [NetWorkHandler expressOrderList:dict completionHandler:^(id content) {
        
        [_dataSource removeAllObjects];
        if ([content isKindOfClass:[NSError class]]) {
            [myself hideLoading];
            [DisplayView displayShowWithTitle:@"连接超时"];
            return ;
        }
        else {
            
            NSLog(@"%@",content);
            [myself hideLoading];
            if (![content isKindOfClass:[NSDictionary class]]) {
                [DisplayView displayShowWithTitle:@"连接超时"];
                [_tableView footerEndRefreshing];
                return ;
            }
            else  if ([content[@"status"] integerValue] == 1) {
                if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    
                    [_tableView footerEndRefreshing];
                    [DisplayView displayShowWithTitle:@"没有多余数据"];
                    return ;
                }
                for (NSMutableArray *dict in content[@"data"]) {
                    [_dataSource addObject:dict];
                }
                NSLog(@"_dataSource:%@",_dataSource);
                page += 1;
                [_tableView reloadData];
            }
            [DisplayView displayShowWithTitle:content[@"info"]];
            [_tableView footerEndRefreshing];
        }

    }];
//    }
}

//#pragma mark - <数据加载>
//#pragma mark 下拉刷新
////数据刷新
//- (void)footRefreshing {
//    
//    if ([AppDelegate app].lat == nil && [AppDelegate app].lon == nil) {
//        
//        _locationService.delegate = self;
//        [_locationService startUserLocationService];
//    }
//    else {
//        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString *tel = [defaults objectForKey:@"tel"];
//        NSString *pwd = [defaults objectForKey:@"pwd"];
//        
//        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"lat":[AppDelegate app].lat,@"lon":[AppDelegate app].lon};
////        NSDictionary *dict = @{@"lat":[AppDelegate app].lat,@"lon":[AppDelegate app].lon,@"page":[NSString stringWithFormat:@"%i",page]};
//        
//        __weak typeof(self)myself = self;
//        [myself showLoading];
//        
//        [NetWorkHandler updateExpressCoord:dict completionHandler:^(id content) {
//           
//            NSLog(@"updateExpressCoord%@",content);
//            if ([content isKindOfClass:[NSError class]]) {
//                
//                [DisplayView displayShowWithTitle:@"连接超时"];
//                return ;
//            }
//            else {
//                
//                NSLog(@"%@",content);
//                [myself hideLoading];
//                if (![content isKindOfClass:[NSDictionary class]]) {
//                    [DisplayView displayShowWithTitle:@"连接超时"];
//                    [_tableView footerEndRefreshing];
//                    return ;
//                }
//                else  if ([content[@"status"] integerValue] == 1) {
//                    if ([content[@"data"] isKindOfClass:[NSNull class]]) {
//                        
//                        [_tableView footerEndRefreshing];
//                        [DisplayView displayShowWithTitle:@"没有多余数据"];
//                        return ;
//                    }
//                    for (NSMutableArray *dict in content[@"data"]) {
//                        [_dataSource addObject:dict];
//                    }
//                    NSLog(@"_dataSource:%@",_dataSource);
//                    page += 1;
//                    [_tableView reloadData];
//                }
//                [DisplayView displayShowWithTitle:content[@"info"]];
//                [_tableView footerEndRefreshing];
//            }
//
//        }];
        
//        [NetWorkHandler getChefList:dict completionHandler:^(id content) {
//            
//            if ([content isKindOfClass:[NSError class]]) {
//                
//                [DisplayView displayShowWithTitle:@"连接超时"];
//                return ;
//            }
//            else {
//                
//                NSLog(@"%@",content);
//                [myself hideLoading];
//                if (![content isKindOfClass:[NSDictionary class]]) {
//                    [DisplayView displayShowWithTitle:@"连接超时"];
//                    [_tableView footerEndRefreshing];
//                    return ;
//                }
//                else  if ([content[@"status"] integerValue] == 1) {
//                    if ([content[@"data"] isKindOfClass:[NSNull class]]) {
//                        
//                        [_tableView footerEndRefreshing];
//                        [DisplayView displayShowWithTitle:@"没有多余数据"];
//                        return ;
//                    }
//                    for (NSMutableArray *dict in content[@"data"]) {
//                        [_dataSource addObject:dict];
//                    }
//                    NSLog(@"_dataSource:%@",_dataSource);
//                    page += 1;
//                    [_tableView reloadData];
//                }
//                [DisplayView displayShowWithTitle:content[@"info"]];
//                [_tableView footerEndRefreshing];
//            }
//        }];
//    }
//}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [AppDelegate app].lat = [NSString stringWithFormat:@"%lf",userLocation.location.coordinate.latitude] ;
    [AppDelegate app].lon = [NSString stringWithFormat:@"%lf",userLocation.location.coordinate.longitude] ;
    
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
