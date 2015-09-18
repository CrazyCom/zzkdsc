//
//  GourmetExpenditureViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/15.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "GourmetExpenditureViewController.h"
#import "GourmetExpenditureTableViewCell.h"
@interface GourmetExpenditureViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    NSMutableArray *_dataSource;
    int _page;
    
    UILabel *dishOfName;
    UILabel *timeOfPay;
    UILabel *routeOfPay;
    UILabel *priceOfLabel;

}


- (void)initializeInterface;
- (void)initializeDataSource;

@end

@implementation GourmetExpenditureViewController

- (void)initializeDataSource {
    _page = 1;
    _dataSource = [[NSMutableArray alloc]init];
    [self footRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
}

-(void)initializeInterface {
    
    
    self.titleLabel.text = @"吃货支出明细";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = _dataSource[section][@"dish_name"];
    return array.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        timeOfPay = [[UILabel alloc]init];
//        timeOfPay.tag = 5000;
//        [cell.contentView addSubview:timeOfPay];
        
        
//        dishOfName = [[UILabel alloc]init];
//        dishOfName.tag = 5002;
//        [cell.contentView addSubview:dishOfName];
        
        routeOfPay = [[UILabel alloc]init];
        routeOfPay.tag = 5001;
        [cell.contentView addSubview:routeOfPay];

//        
        priceOfLabel = [[UILabel alloc]init];
        priceOfLabel.tag = 5002;
        [cell.contentView addSubview:priceOfLabel];
    }
    
    NSArray *array = [[NSArray alloc]initWithArray:_dataSource[indexPath.section][@"dish_name"]];
    for (int i = 0; i < array.count; i++) {
        
        if (indexPath.row == i) {
            
            static NSString *gourmetExpenditureCellID =@"gourmetExpenditureCellID";
            GourmetExpenditureTableViewCell *gourmetExpenditureCell = [tableView dequeueReusableCellWithIdentifier:gourmetExpenditureCellID];
            if (!gourmetExpenditureCell) {
                gourmetExpenditureCell = [[GourmetExpenditureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
                gourmetExpenditureCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
        
            if (indexPath.row < array.count) {
                
                gourmetExpenditureCell.dishOfName.text = array[indexPath.row][@"dish_name"];
                
                gourmetExpenditureCell.timeOfPay.text = [[NSString stringWithFormat:@"%@", [NSDate dateWithTimeInterval:8*60*60 sinceDate:[NSDate dateWithTimeIntervalSince1970:[_dataSource[indexPath.section][@"place_time"] intValue]]]] substringToIndex:16];
                
//                gourmetExpenditureCell.priceOfLabel.text = [NSString stringWithFormat:@"-%@",_dataSource[indexPath.section][@"total_price"]];
//                                                            
                
            }
            return gourmetExpenditureCell;
        }
    }
    if (indexPath.row == array.count) {
        
        UILabel *routePay = (UILabel *)[cell.contentView viewWithTag:5001];
        routePay.frame = CGRectMake(10, 12, 150, 20);
        routePay.text = @"支付宝";
        routePay.font = [UIFont systemFontOfSize:15];
        
        
        UILabel *priceLabel = (UILabel *)[cell.contentView viewWithTag:5002];
        priceLabel.frame = CGRectMake(CGRectGetMaxX(routePay.frame) + 10, CGRectGetMinY(routePay.frame), ScreenWidth - CGRectGetMaxX(routePay.frame) - 10 - 10, 20);
        
        
        if (!_dataSource[indexPath.section][@"total_price"]) {
            
            priceLabel.text = [NSString stringWithFormat:@"-%@",_dataSource[indexPath.section][@"total_price"]];
            
        }
        else {
            
            priceLabel.text = @"-25.00";
            
        }
        priceLabel.font = [UIFont systemFontOfSize:15];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.090f blue:0.000f alpha:1.00f];
       

    }
//    else if (indexPath.row == array.count + 1) {
//        
//        
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *page = [NSString stringWithFormat:@"%i",_page];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"page":page};
    
    [NetWorkHandler payDetailList:dict completionHandler:^(id content) {
        
        NSLog(@"payDetailList%@",content);
        
        if ([content isKindOfClass:[NSError class]]) {
            
            [DisplayView displayShowWithTitle:@"连接超时"];
            [_tableView footerEndRefreshing];
            return ;
            
        }
        else {
            
            NSLog(@"%@",content);
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
                _page += 1;
                [_tableView reloadData];
            }
            
            [DisplayView displayShowWithTitle:content[@"info"]];
            [_tableView footerEndRefreshing];
            
        }
    }];
        
       
        
    
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
