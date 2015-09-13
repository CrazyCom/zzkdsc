//
//  MyCuponViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/11.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyCuponViewController.h"

@interface MyCuponViewController () <UITableViewDelegate,UITableViewDataSource>  {
    
    UITableView *_tableView;
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation MyCuponViewController

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
    self.titleLabel.text = @"我的优惠券";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];

    }
    if (indexPath.section == 0) {
        UIView *view1 = [[UIView alloc]init];
        view1.frame = CGRectMake(10, 0, ScreenWidth - 20, 80);
        view1.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view1];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(view1.frame), 12);
        [imageView setImage:[UIImage imageNamed:@"youhuiquan-top"]];
        [view1 addSubview:imageView];
        
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.frame = CGRectMake(12, 32, 75, 22);
        priceLabel.text = @"￥ 10.00";
        priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.129f blue:0.000f alpha:1.00f];
        [view1 addSubview:priceLabel];
        
        UIImageView *verticalImageView = [[UIImageView alloc]init];
        verticalImageView.frame = CGRectMake(CGRectGetMaxX(priceLabel.frame) + 10, 21, 1, 44);
        [verticalImageView setImage:[UIImage imageNamed:@"line"]];
        [view1 addSubview:verticalImageView];
        
        UILabel *scaleLabel = [[UILabel alloc]init];
        scaleLabel.frame = CGRectMake(CGRectGetMaxX(verticalImageView.frame) + 25, CGRectGetMinY(verticalImageView.frame), 100, 18);
        scaleLabel.text = @"全场通用";
        [view1 addSubview:scaleLabel];
        
        
        UILabel *validityTimeOfLabel = [[UILabel alloc]init];
        validityTimeOfLabel.frame = CGRectMake(CGRectGetMaxX(verticalImageView.frame) + 25, CGRectGetMaxY(scaleLabel.frame) + 12, 70, 13);
        validityTimeOfLabel.text = @"有效期至：";
        validityTimeOfLabel.font = [UIFont systemFontOfSize:13];
        validityTimeOfLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
        [view1 addSubview:validityTimeOfLabel];
        
        UILabel *validityOfTime = [[UILabel alloc]init];
        validityOfTime.frame = CGRectMake(CGRectGetMaxX(validityTimeOfLabel.frame) + 8, CGRectGetMaxY(scaleLabel.frame) + 12, ScreenWidth - 20 - CGRectGetMaxX(validityTimeOfLabel.frame) - 8, 13);
        validityOfTime.text = @"2016-12-32";
        validityOfTime.font = [UIFont systemFontOfSize:13];
        validityOfTime.textAlignment = NSTextAlignmentLeft;
        validityOfTime.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
        [view1 addSubview:validityOfTime];
        
    }
    if (indexPath.section == 1) {
        UIView *view2 = [[UIView alloc]init];
        view2.frame = CGRectMake(10, 0, ScreenWidth - 20, 80);
        view2.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view2];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(view2.frame), 12);
        [imageView setImage:[UIImage imageNamed:@"youhuiquan-top1"]];
        [view2 addSubview:imageView];
        
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.frame = CGRectMake(12, 32, 75, 22);
        priceLabel.text = @"￥ 10.00";
        priceLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
        [view2 addSubview:priceLabel];
        
        UIImageView *verticalImageView = [[UIImageView alloc]init];
        verticalImageView.frame = CGRectMake(CGRectGetMaxX(priceLabel.frame) + 10, 21, 1, 44);
        [verticalImageView setImage:[UIImage imageNamed:@"line"]];
        [view2 addSubview:verticalImageView];
        
        UILabel *scaleLabel = [[UILabel alloc]init];
        scaleLabel.frame = CGRectMake(CGRectGetMaxX(verticalImageView.frame) + 25, CGRectGetMinY(verticalImageView.frame), 100, 18);
        scaleLabel.text = @"全场通用";
        scaleLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
        [view2 addSubview:scaleLabel];
        
        
        UILabel *validityTimeOfLabel = [[UILabel alloc]init];
        validityTimeOfLabel.frame = CGRectMake(CGRectGetMaxX(verticalImageView.frame) + 25, CGRectGetMaxY(scaleLabel.frame) + 12, 70, 13);
        validityTimeOfLabel.text = @"有效期至：";
        validityTimeOfLabel.font = [UIFont systemFontOfSize:13];
        validityTimeOfLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
        [view2 addSubview:validityTimeOfLabel];
        
        UILabel *validityOfTime = [[UILabel alloc]init];
        validityOfTime.frame = CGRectMake(CGRectGetMaxX(validityTimeOfLabel.frame) + 8, CGRectGetMaxY(scaleLabel.frame) + 12, ScreenWidth - 20 - CGRectGetMaxX(validityTimeOfLabel.frame) - 8, 13);
        validityOfTime.text = @"2016-12-32";
        validityOfTime.font = [UIFont systemFontOfSize:13];
        validityOfTime.textAlignment = NSTextAlignmentLeft;
        validityOfTime.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
        [view2 addSubview:validityOfTime];

        UIImageView *imageView1 = [[UIImageView alloc]init];
        imageView1.frame = CGRectMake(CGRectGetWidth(view2.frame) - 78, 0, 78, 64);
        [imageView1 setImage:[UIImage imageNamed:@"youhuiquan"]];
        [view2 addSubview:imageView1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 15);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
