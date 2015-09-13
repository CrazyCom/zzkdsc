//
//  OrderDetailViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/1.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"

@interface OrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_productList;
    NSMutableDictionary *_dataSource;
    UILabel  *freightOfLabel;                      //运费
    UILabel *totalPriceOfLabel;                    //总价
    
    UILabel *orderStatus;                          //订单状态
    UILabel *timeOfMake;                           //下单时间
    UILabel *numOfLabel;                           //购买份数
    UILabel *timeOfEat;                            //时间
    
    //UILabel
    UILabel *totalPriceLabel;
    UILabel *numOfBuyLabel;
    UILabel *timeOfEatLabel;
    UILabel *armedPriceOfLabel;
    
    UILabel *orderStatusLabel;
    UILabel *orderTimeLabel;
    
    NSString *_order_num;
    
    NSDateFormatter *fomatter;
    OrderDetailTableViewCell *orderCell;
}

- (void)initializeInterface;
- (void)initializeDataSource;
@end

@implementation OrderDetailViewController


- (id)initWithOrder_num:(NSString *)order_num {
    
    if (self = [super init]) {
        _order_num = order_num;
        _productList = [[NSMutableArray alloc]init];
        _dataSource = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}

-(void)initializeDataSource {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *order_num = _order_num;
    NSString *type = @"guest";
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num,@"type":type};
    [NetWorkHandler detailsOfOrder:dict completionHandler:^(id content) {
        
        NSLog(@"detailsOfOrder%@",content);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",content);
        if ([content[@"status"] integerValue] == 1) {
            if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                
                [DisplayView displayShowWithTitle:@"没有多余数据"];
                return ;
            }
            _dataSource = content[@"data"];
            NSLog(@"_dictionarySource:%@",_dataSource);
            
        }
        
        
        if (!fomatter) {
            
            fomatter = [[NSDateFormatter alloc] init];
            fomatter.dateFormat = @"yyyy-MM-dd HH:mm";
            
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_dataSource[@"place_time"]doubleValue]];
        [timeOfMake setText:[fomatter stringFromDate:date]];
        
        
        [numOfLabel setText:[NSString stringWithFormat:@"%@份",_dataSource[@"dish_total"]]];
        NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[_dataSource[@"order_time"]doubleValue]];
        [timeOfEat setText:[fomatter stringFromDate:date1]];
        
        
        [orderStatus setText:_dataSource[@"status"]];

        [_tableView reloadData];
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
}

-(void)initializeInterface {
    
    self.titleLabel.text = @"订单详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        
        _productList = [[NSMutableArray alloc]initWithArray:_dataSource[@"dish_list"]];
        return _productList.count + 2;
    }
    else if (section == 2) {
        
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:_dataSource[@"dish_list"]];
    
    NSString *cellID = [NSString stringWithFormat:@"%li,%li",indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        UILabel *armedPriceOfLabel1 = [[UILabel alloc]init];
        armedPriceOfLabel1.tag = 1000;
        [cell.contentView addSubview:armedPriceOfLabel1];
        
        
        UILabel *freightOfLabel1 = [[UILabel alloc]init];
        freightOfLabel1.tag = 1001;
        [cell.contentView addSubview:freightOfLabel1];
        
        
        UILabel *totalPriceLabel1 = [[UILabel alloc]init];
        totalPriceLabel1.tag = 1002;
        totalPriceLabel1.hidden = YES;
        [cell.contentView addSubview:totalPriceLabel1];
        
        UILabel *totalPriceOfLabel1 = [[UILabel alloc]init];
        totalPriceOfLabel1.tag = 1003;
        totalPriceOfLabel1.hidden = YES;
        [cell.contentView addSubview:totalPriceOfLabel1];
        
        
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            if (!orderStatusLabel) {
                
                orderStatusLabel = [[UILabel alloc]init];
                orderStatusLabel.frame = CGRectMake(10, 10, 80, 21);
                orderStatusLabel.text = @"订单状态";
                orderStatusLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:orderStatusLabel];
                
            }
            
            if (!orderStatus) {
                
                orderStatus = [[UILabel alloc]init];
                orderStatus.frame = CGRectMake(CGRectGetMaxX(orderStatusLabel.frame), 10, 120, 21);
                orderStatus.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
                orderStatus.text = @"等待私厨接单";
                orderStatus.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:orderStatus];
                
            }
            
        }
        else if (indexPath.row == 1) {
            
            if (!orderTimeLabel) {
                
                orderTimeLabel = [[UILabel alloc]init];
                orderTimeLabel.frame = CGRectMake(10, 10, 80, 21);
                orderTimeLabel.text = @"下单时间";
                orderTimeLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:orderTimeLabel];
                
            }
            
            if (!timeOfMake) {
                
                timeOfMake = [[UILabel alloc]init];
                timeOfMake.frame = CGRectMake(CGRectGetMaxX(orderTimeLabel.frame), 10, 150, 21);
                timeOfMake.text = @"";
                timeOfMake.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:timeOfMake];
                
            }
        }
    }
    else if (indexPath.section == 1) {
    
        NSLog(@"indexPath.row == %ld",indexPath.row);
        NSLog(@"array.count == %ld",array.count);
        
        NSString *orderCellID = @"orderCellID";
        orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellID];
        if (!orderCell) {
            
            orderCell = [[OrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellID];
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    
        if (indexPath.row < array.count ) {
            
            NSLog(@"dish_name:%@",array[indexPath.row][@"dish_name"]);
            NSLog(@"dish_price:%@",array[indexPath.row][@"dish_price"]);
            NSLog(@"dish_num:%@",array[indexPath.row][@"dish_num"]);
            
            orderCell.dishOfName.text = array[indexPath.row][@"dish_name"];
            orderCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", array[indexPath.row][@"dish_price"]];
            orderCell.numOfLabel.text = [NSString stringWithFormat:@"%@份",array[indexPath.row][@"dish_num"]];
        }
        
 
        else  if (indexPath.row == array.count) {
            
            NSLog(@"%lu",(unsigned long)array.count);
          
            UILabel *armedPriceOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1000];
            armedPriceOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1000];
            armedPriceOfLabel1.frame = CGRectMake(10, 10, 80, 20);
            armedPriceOfLabel1.font = [UIFont systemFontOfSize:14];
            armedPriceOfLabel1.textColor = [UIColor grayColor];
            armedPriceOfLabel1.text = @"镖费";
          
           
            UILabel *freightOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1001];
            freightOfLabel1.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
            freightOfLabel1.textAlignment = NSTextAlignmentRight;
            freightOfLabel1.textColor = [UIColor grayColor];
            freightOfLabel1.font = [UIFont systemFontOfSize:14];
            freightOfLabel1.text = _dataSource[@"express_price"];
            ((UILabel *)[cell.contentView viewWithTag:1002]).hidden = YES;
            ((UILabel *)[cell.contentView viewWithTag:1003]).hidden = YES;
          
            
        }
        
        else if (indexPath.row == array.count +1 ) {
            
            
            
            UILabel *totalPriceLabel1 = (UILabel *)[cell.contentView viewWithTag:1002];
            totalPriceLabel1.frame = CGRectMake(10, 10, 80, 20);
            totalPriceLabel1.font = [UIFont systemFontOfSize:15];
            totalPriceLabel1.text = @"合计";
            totalPriceLabel1.hidden = NO;
            
            
            UILabel *totalPriceOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1003];
            totalPriceOfLabel1.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
            totalPriceOfLabel1.textAlignment = NSTextAlignmentRight;
            totalPriceOfLabel1.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
            totalPriceOfLabel1.font = [UIFont systemFontOfSize:14];
            totalPriceOfLabel1.text = _dataSource[@"total_price"];
            totalPriceOfLabel1.hidden = NO;
           
        }
        
    }
    
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            
            if (!numOfBuyLabel) {
                
                numOfBuyLabel = [[UILabel alloc]init];
                numOfBuyLabel.frame = CGRectMake(10, 10, 80, 21);
                numOfBuyLabel.text = @"购买份数";
                numOfBuyLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:numOfBuyLabel];
                
            }
            
            if (!numOfLabel) {
                
                numOfLabel = [[UILabel alloc]init];
                numOfLabel.frame = CGRectMake(CGRectGetMaxX(numOfBuyLabel.frame), 10, 120, 21);
                numOfLabel.text = @"1份";
                numOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:numOfLabel];
                
            }
            
        }
        else if (indexPath.row == 1) {
            
            if (!timeOfEatLabel) {
                
                timeOfEatLabel = [[UILabel alloc]init];
                timeOfEatLabel.frame = CGRectMake(10, 10, 80, 21);
                timeOfEatLabel.text = @"吃饭时间";
                timeOfEatLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:timeOfEatLabel];
                
            }
            
            if (!timeOfEat) {
                
                timeOfEat = [[UILabel alloc]init];
                timeOfEat.frame = CGRectMake(CGRectGetMaxX(timeOfEatLabel.frame), 10, 150, 21);
                timeOfEat.text = @"";
                timeOfEat.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:timeOfEat];
                
                
            }
        }
    }
    if (indexPath.section == 1 && (indexPath.row < array.count)) {
        return orderCell;
    }
    
    return cell;
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
