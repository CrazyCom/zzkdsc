//
//  MySilverViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/11.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MySilverViewController.h"
#import "ExtractDepositViewController.h"
#import "GourmetExpenditureViewController.h"

@interface MySilverViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    NSMutableDictionary *_dataSource;
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation MySilverViewController

-(void)initializeDataSource {
    
    _dataSource = [[NSMutableDictionary alloc]init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [userDefaults objectForKey:@"pwd"];
    NSString *tel = [userDefaults objectForKey:@"tel"];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd};
    DisplayView *displayView = [[DisplayView alloc] init];
    [displayView displayShowLoading:self.view];
    [NetWorkHandler checkCash:dict completionHandler:^(id content) {
        NSLog(@"checkCash:%@",content);
        [displayView displayHideLoading];
        if ([content[@"data"] isKindOfClass:[NSDictionary class]]) {
       
            _dataSource = content[@"data"];
            [_tableView reloadData];
       
        }
    }];
    
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


- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"我的银子";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"提现" forState:UIControlStateNormal];
    self.rightButton.tag = 500;
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.bounces = NO;
    
    [self.view addSubview:_tableView];
}

- (void)barButtonItemMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"吃货支出";
//        if (!_dataSource[@"used"]) {
//             cell.detailTextLabel.text = _dataSource[@"used"];
//        }
         cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"used"]];
       
        cell.detailTextLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"私厨收入";
        
//        if (!_dataSource[@"chef_total"]) {
//             cell.detailTextLabel.text = _dataSource[@"chef_total"];
//        }
         cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"chef_total"]];
       
        cell.detailTextLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"镖师收入";
        
//        if (!_dataSource[@"express_total"]) {
//            cell.detailTextLabel.text = _dataSource[@"express_total"];
//        }

         cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"express_total"]];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 240;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 240);
    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(ScreenWidth / 2 - 87.5, 30, 175, 175);
    [imageView setImage:[UIImage imageNamed:@"yinzi"]];
    [headerView addSubview:imageView];
    
    UILabel *allLabel = [[UILabel alloc]init];
    allLabel.frame = CGRectMake(36, 60, 110, 20);
//    if (!_dataSource[@"total"]) {
//        allLabel.text = _dataSource[@"total"];
//    }
    allLabel.text = [NSString stringWithFormat:@"%@",_dataSource[@"total"]];

    allLabel.textAlignment = NSTextAlignmentCenter;
    allLabel.textColor = [UIColor whiteColor];
    [imageView addSubview:allLabel];
    
    UILabel *allPrice = [[UILabel alloc]init];
    allPrice.frame = CGRectMake(41, CGRectGetMaxY(allLabel.frame) + 12, 100, 20);
    allPrice.textColor = [UIColor whiteColor];
    allPrice.text = @"总计";
    allPrice.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:allPrice];
    
    return headerView;
}

- (void)buttonPressed:(UIButton *)sender {
    
    ExtractDepositViewController *vc = [[ExtractDepositViewController alloc]init];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    //    [dvc.ztabBarController.viewControllers[0] pushViewController:vc animated:YES];
    [(UINavigationController *)dvc.ztabBarController.selectedViewController pushViewController:vc animated:YES];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"dataSource:%@",_dataSource);
    if (indexPath.row == 0) {
        
        GourmetExpenditureViewController *vc = [[GourmetExpenditureViewController alloc]init];
        
        DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
        //    [dvc.ztabBarController.viewControllers[0] pushViewController:vc animated:YES];
        [(UINavigationController *)dvc.ztabBarController.selectedViewController pushViewController:vc animated:YES];

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
