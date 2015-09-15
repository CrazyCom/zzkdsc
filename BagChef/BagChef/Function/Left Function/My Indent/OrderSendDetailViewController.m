//
//  OrderSendDetailViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/1.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "OrderSendDetailViewController.h"
#import "OrderSendDetailTableViewCell.h"
#import "ZmapViewController.h"
@interface OrderSendDetailViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_productList;
    NSMutableDictionary *_dataSource;
    UILabel  *freightOfLabel;                      //运费
    UILabel *totalPriceOfLabel;                    //总价
    
    UILabel *orderStatus;                          //订单状态
    UILabel *timeOfMake;                           //下单时间
    UILabel *numOfLabel;                           //购买份数
    UILabel *timeOfEat;                            //时间
    UILabel *privateTelOfLabel;
    UILabel *privateAddressOfLabel;
    UILabel *orderStatusOfLabel;
    
    UILabel *armedTelOfLabel;
    UILabel *armedAddressOfLabel;
    UILabel *transportStyleOfLabel;
    
    //UILabel
    UILabel *totalPriceLabel;
    UILabel *numOfBuyLabel;
    UILabel *timeOfEatLabel;
    UILabel *armedPriceOfLabel;
    UILabel *priveteTelLabel;
    UILabel *privateAddressLabel;
    
    UILabel *armedTelLabel;
    UILabel *armedAddressLabel;
    UILabel *transportStyleLabel;
    
    UILabel *orderStatusLabel;
    UILabel *orderTimeLabel;
    
    UIButton *getBtn;
    NSString *_order_num;
    
    NSDateFormatter *fomatter;
    
    OrderSendDetailTableViewCell *orderSendCell;
}

- (void)initializeInterface;
- (void)initializeDataSource;


@end

@implementation OrderSendDetailViewController


- (id)initWithOrder_num:(NSString *)order_num {
    
    if (self = [super init]) {
        _order_num = order_num;
        
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
        
        [privateTelOfLabel setText:_dataSource[@"chef"][@"tel"]];
        [privateAddressOfLabel setText:_dataSource[@"chef"][@"address"]];
        
        [armedTelOfLabel setText:_dataSource[@"express"][@"tel"]];
        
        [transportStyleOfLabel setText:_dataSource[@"express_type"]];
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
    
    
    //footView
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, ScreenWidth, 60);
    footerView.backgroundColor = [UIColor colorWithRed:0.953f green:0.949f blue:0.953f alpha:1.00f];
    _tableView.tableFooterView = footerView;
    
    UIView *upFooterView = [[UIView alloc]init];
    upFooterView.frame = CGRectMake(0, 14, ScreenWidth, 46);
    upFooterView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:upFooterView];
    
    getBtn = [[UIButton alloc]init];
    getBtn.frame = CGRectMake(50, 8, ScreenWidth - 100, 30);
    [getBtn setTitle:@"我已收到餐啦" forState:UIControlStateNormal];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [getBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [getBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [upFooterView addSubview:getBtn];

    
}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        
        return 2;
    }
    else if (section == 2) {
        
        return 2;
    }
    else if (section == 3) {
       
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:_dataSource[@"dish_list"]];
        return array.count + 2;
    }
    else if (section == 4) {
        
        return 3;
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
                timeOfMake.text = @"2015-07-20 11:00";
                timeOfMake.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:timeOfMake];
                
            }
        }
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            if (!priveteTelLabel) {
                
                priveteTelLabel = [[UILabel alloc]init];
                priveteTelLabel.frame = CGRectMake(10, 10, 80, 21);
                priveteTelLabel.text = @"私厨电话";
                priveteTelLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:priveteTelLabel];
                
            }
            
            if (!privateTelOfLabel) {
                
                privateTelOfLabel = [[UILabel alloc]init];
                privateTelOfLabel.frame = CGRectMake(CGRectGetMaxX(orderStatusLabel.frame), 10, 120, 21);
                privateTelOfLabel.textColor = [UIColor grayColor];
                privateTelOfLabel.text = @"";
                privateTelOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:privateTelOfLabel];
            }

        }
        
        else if (indexPath.row == 1) {
            
            if (!privateAddressLabel) {
                
                privateAddressLabel = [[UILabel alloc]init];
                privateAddressLabel.frame = CGRectMake(10, 10, 80, 21);
                privateAddressLabel.text = @"地址";
                privateAddressLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:privateAddressLabel];
                
            }
            
            if (!privateAddressOfLabel) {
                
                privateAddressOfLabel = [[UILabel alloc]init];
                privateAddressOfLabel.frame = CGRectMake(CGRectGetMaxX(orderStatusLabel.frame), 10, 120, 21);
                privateAddressOfLabel.textColor = [UIColor grayColor];
                privateAddressOfLabel.text = @"";
                privateAddressOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:privateAddressOfLabel];
            }

        }
        
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            if (!armedTelLabel) {
                
                armedTelLabel = [[UILabel alloc]init];
                armedTelLabel.frame = CGRectMake(10, 10, 80, 21);
                armedTelLabel.text = @"镖师电话";
                armedTelLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:armedTelLabel];
                
            }
            
            if (!armedTelOfLabel) {
                
                armedTelOfLabel = [[UILabel alloc]init];
                armedTelOfLabel.frame = CGRectMake(CGRectGetMaxX(orderStatusLabel.frame), 10, 120, 21);
                armedTelOfLabel.textColor = [UIColor grayColor];
                armedTelOfLabel.text = @"";
                armedTelOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:armedTelOfLabel];
            }

        }
        
        else if (indexPath.row == 1) {
            
            if (!armedAddressLabel) {
                
                armedAddressLabel = [[UILabel alloc]init];
                armedAddressLabel.frame = CGRectMake(10, 10, 120, 21);
                armedAddressLabel.text = @"镖师到哪了?";
                armedAddressLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:armedAddressLabel];
                
            }
            
//            if (!armedAddressOfLabel) {
//                
//                armedAddressOfLabel = [[UILabel alloc]init];
//                armedAddressOfLabel.frame = CGRectMake(CGRectGetMaxX(orderStatusLabel.frame), 10, 120, 21);
//                armedAddressOfLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//                armedAddressOfLabel.text = @"镖师到哪了?";
//                armedAddressOfLabel.font = [UIFont systemFontOfSize:15];
//                [cell.contentView addSubview:armedAddressOfLabel];
//            }
      
        }
    }
    else if (indexPath.section == 3) {
        
        NSLog(@"indexPath.row == %ld",indexPath.row);
        NSLog(@"array.count == %ld",array.count);
        
        NSString *orderSendCellID = @"orderSendCellID";
        orderSendCell = [tableView dequeueReusableCellWithIdentifier:orderSendCellID];

        
        if (!orderSendCell) {
            
            orderSendCell = [[OrderSendDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderSendCellID];
            orderSendCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (indexPath.row < array.count ) {
            
            NSLog(@"dish_name:%@",array[indexPath.row][@"dish_name"]);
            NSLog(@"dish_price:%@",array[indexPath.row][@"dish_price"]);
            NSLog(@"dish_num:%@",array[indexPath.row][@"dish_num"]);
            
            orderSendCell.dishOfName.text = array[indexPath.row][@"dish_name"];
            orderSendCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", array[indexPath.row][@"dish_price"]];
            orderSendCell.numOfLabel.text = [NSString stringWithFormat:@"%@份",array[indexPath.row][@"dish_num"]];
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
//        if (indexPath.row < array.count ) {
//            
//            NSLog(@"dish_name:%@",array[indexPath.row][@"dish_name"]);
//            NSLog(@"dish_price:%@",array[indexPath.row][@"dish_price"]);
//            NSLog(@"dish_num:%@",array[indexPath.row][@"dish_num"]);
//            
//            orderSendCell.dishOfName.text = array[indexPath.row][@"dish_name"];
//            orderSendCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", array[indexPath.row][@"dish_price"]];
//            orderSendCell.numOfLabel.text = [NSString stringWithFormat:@"%@份",array[indexPath.row][@"dish_num"]];
//        }
//        
//        
//        else  if (indexPath.row == array.count) {
//            
//            NSLog(@"%lu",(unsigned long)array.count);
//            
//            UILabel *armedPriceOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1000];
//            armedPriceOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1000];
//            armedPriceOfLabel1.frame = CGRectMake(10, 10, 80, 20);
//            armedPriceOfLabel1.font = [UIFont systemFontOfSize:14];
//            armedPriceOfLabel1.textColor = [UIColor grayColor];
//            armedPriceOfLabel1.text = @"镖费";
//            
//            
//            UILabel *freightOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1001];
//            freightOfLabel1.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
//            freightOfLabel1.textAlignment = NSTextAlignmentRight;
//            freightOfLabel1.textColor = [UIColor grayColor];
//            freightOfLabel1.font = [UIFont systemFontOfSize:14];
//            freightOfLabel1.text = _dataSource[@"express_price"];
//            ((UILabel *)[cell.contentView viewWithTag:1002]).hidden = YES;
//            ((UILabel *)[cell.contentView viewWithTag:1003]).hidden = YES;
//            
//            
//        }
//        
//        else if (indexPath.row == array.count +1 ) {
//            
//            
//            
//            UILabel *totalPriceLabel1 = (UILabel *)[cell.contentView viewWithTag:1002];
//            totalPriceLabel1.frame = CGRectMake(10, 10, 80, 20);
//            totalPriceLabel1.font = [UIFont systemFontOfSize:15];
//            totalPriceLabel1.text = @"合计";
//            totalPriceLabel1.hidden = NO;
//            
//            
//            UILabel *totalPriceOfLabel1 = (UILabel *)[cell.contentView viewWithTag:1003];
//            totalPriceOfLabel1.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
//            totalPriceOfLabel1.textAlignment = NSTextAlignmentRight;
//            totalPriceOfLabel1.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//            totalPriceOfLabel1.font = [UIFont systemFontOfSize:14];
//            totalPriceOfLabel1.text = _dataSource[@"total_price"];
//            totalPriceOfLabel1.hidden = NO;
//            
//        }
//    }
//        if (indexPath.row == _productList.count) {
//            
//            if (!armedPriceOfLabel) {
//                armedPriceOfLabel = [[UILabel alloc]init];
//                armedPriceOfLabel.frame = CGRectMake(10, 10, 80, 20);
//                armedPriceOfLabel.font = [UIFont systemFontOfSize:14];
//                armedPriceOfLabel.textColor = [UIColor grayColor];
//                armedPriceOfLabel.text = @"镖费";
//                [cell.contentView addSubview:armedPriceOfLabel];
//            }
//            
//            if (!freightOfLabel) {
//                
//                freightOfLabel = [[UILabel alloc]init];
//                freightOfLabel.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
//                freightOfLabel.textAlignment = NSTextAlignmentRight;
//                freightOfLabel.textColor = [UIColor grayColor];
//                freightOfLabel.font = [UIFont systemFontOfSize:14];
//                freightOfLabel.text = @"￥10:00";
//                [cell.contentView addSubview:freightOfLabel];
//                
//            }
//            
//        }
//        
//        else if (indexPath.row == _productList.count + 1) {
//            
//            
//            if (!totalPriceLabel) {
//                totalPriceLabel = [[UILabel alloc]init];
//                totalPriceLabel.frame = CGRectMake(10, 10, 80, 20);
//                totalPriceLabel.font = [UIFont systemFontOfSize:15];
//                totalPriceLabel.text = @"合计";
//                [cell.contentView addSubview:totalPriceLabel];
//            }
//            
//            if (!totalPriceOfLabel) {
//                
//                totalPriceOfLabel = [[UILabel alloc]init];
//                totalPriceOfLabel.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
//                totalPriceOfLabel.textAlignment = NSTextAlignmentRight;
//                totalPriceOfLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//                totalPriceOfLabel.font = [UIFont systemFontOfSize:14];
//                totalPriceOfLabel.text = @"￥100:00";
//                [cell.contentView addSubview:totalPriceOfLabel];
//                
//            }
//        }
    
    else if (indexPath.section == 4) {
        
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
                timeOfEat.text = @"2015-07-20 11:00";
                timeOfEat.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:timeOfEat];
                
            }
        }
        else if (indexPath.row == 2) {
            
            if (!transportStyleLabel) {
                
                transportStyleLabel = [[UILabel alloc]init];
                transportStyleLabel.frame = CGRectMake(10, 10, 80, 21);
                transportStyleLabel.text = @"配送方式";
                transportStyleLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:transportStyleLabel];
                
            }
            
            if (!transportStyleOfLabel) {
                
                transportStyleOfLabel = [[UILabel alloc]init];
                transportStyleOfLabel.frame = CGRectMake(CGRectGetMaxX(timeOfEatLabel.frame), 10, 150, 21);
                transportStyleOfLabel.text = @"请镖师送饭上门";
                transportStyleOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:transportStyleOfLabel];
                
            }

        }
    }
    if (indexPath.section == 3 && (indexPath.row < array.count)) {
        
        return orderSendCell;
        
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2 && indexPath.row == 1) {
       
        NSLog(@"%@",_dataSource);
        ZmapViewController *vc = [[ZmapViewController alloc]initWithExpress_id:_dataSource[@"express_id"]];
        
        DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
        [(UINavigationController *)dvc.ztabBarController.selectedViewController pushViewController:vc animated:YES];
    }
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSLog(@"sender:%li",sender.tag);
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *order_num = _dataSource[@"dish_list"][0][@"order_num"];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num};
    [NetWorkHandler receivedOrders:dict completionHandler:^(id content) {
        
        NSLog(@"receivedOrders%@",content);
        
        if ([content[@"status"] integerValue] == 1) {
            
            if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                
                [DisplayView displayShowWithTitle:content[@"info"]];
                
            }
            
        }
        
        
    }];
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
