//
//  EvaluateDishViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/12.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EvaluateDishViewController.h"
#import "EvaluateDishTableViewCell.h"

@interface EvaluateDishViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    
    NSMutableArray *_dataSource;
    
    UIButton *sendBtn;
    
}

- (void)initializeInterface;
- (void)initializeDataSource;

@end

@implementation EvaluateDishViewController


-(instancetype)initWithDishArray:(NSArray *)array {
    
    if (self = [super init]) {
        
        _dataSource = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

-(void)initializeDataSource {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"评价菜品";
    
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight  - 64 - 49) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //footView
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, ScreenHeight - 60, ScreenWidth, 60);
    footerView.backgroundColor = [UIColor colorWithRed:0.953f green:0.949f blue:0.953f alpha:1.00f];
    [self.view addSubview:footerView];
    
    UIView *upFooterView = [[UIView alloc]init];
    upFooterView.frame = CGRectMake(0, 14, ScreenWidth, 46);
    upFooterView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:upFooterView];
    
    sendBtn = [[UIButton alloc]init];
    sendBtn.frame = CGRectMake(50, 8, ScreenWidth - 100, 30);
    [sendBtn setTitle:@"发表评价" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [upFooterView addSubview:sendBtn];


}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    EvaluateDishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[EvaluateDishTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    EvaluateDishTableViewCellModel *model = [[EvaluateDishTableViewCellModel alloc]initWithDicitonary:_dataSource[indexPath.section]];
    [cell setCellModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 10);
    headerView.backgroundColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonPressed:(UIButton *)sender {
    
    
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
