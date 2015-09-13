//
//  PrivateReceivedOrderDetailViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/4.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "PrivateReceivedOrderDetailViewController.h"
#import "PrivateReceivedOrderDetailTableViewCell.h"

@interface PrivateReceivedOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    NSArray *_productList;
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
    
    UILabel *gourmeTelLabel;
    UILabel *gourmeTelOfLabel;
    
    UILabel *gourmeAddressLabel;
    UILabel *gourmeAddressOfLabel;
    
    UILabel *eatTimeLabel;
    UILabel *eatTimeOfLabel;
    
    UILabel *sendStyleLabel;
    UILabel *sendStyleOfLabel;
    
    UILabel *armedTelLabel;
    UILabel *armedTelOfLabel;
    
    UIButton *sendBtn;
    NSString *_order_num;
    
    NSDateFormatter *fomatter;
    
    PrivateReceivedOrderDetailTableViewCell *privateReceivedCell;
}

- (void)initializeInterface;
- (void)initializeDataSource;
@end

@implementation PrivateReceivedOrderDetailViewController


- (id)initWithOrder_num:(NSString *)order_num {
    
    if (self = [super init]) {
        
        _order_num = order_num;
        
    }
    return self;
}


-(void)initializeDataSource {
    
    _productList = [[NSArray alloc]init];
    _dataSource = [[NSMutableDictionary alloc]init];
    _productList = [@[@"1",@"2",@"3"] copy];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *order_num = _order_num;
    NSString *type = @"chef";
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
        
        
//        [numOfLabel setText:[NSString stringWithFormat:@"%@份",_dataSource[@"dish_total"]]];
        
        NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[_dataSource[@"order_time"]doubleValue]];
        [eatTimeOfLabel setText:[fomatter stringFromDate:date1]];
        
        
        [orderStatus setText:_dataSource[@"status"]];
        
//        [privateTelOfLabel setText:_dataSource[@"chef"][@"tel"]];
        //食客电话
        [gourmeTelOfLabel setText:_dataSource[@"guest"][@"tel"]];
        
        //食客地址
        [gourmeAddressOfLabel setText:_dataSource[@"address"]];
        
        //镖师电话
        [armedTelOfLabel setText:_dataSource[@"express"][@"tel"]];
        
        //配送方式
        [sendStyleOfLabel setText:_dataSource[@"express_type"]];
        
        
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
    
    sendBtn = [[UIButton alloc]init];
    sendBtn.frame = CGRectMake(50, 8, ScreenWidth - 100, 30);
    [sendBtn setTitle:@"餐已送出" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [upFooterView addSubview:sendBtn];

}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        
        _productList = [[NSArray alloc] initWithArray:_dataSource[@"dish_list"]];
        return _productList.count + 1;
    }
    else if (section == 2) {
        
        return 4;
    }
    else if (section == 3) {
        
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[@"dish_list"]];
    
    NSString *cellID = [NSString stringWithFormat:@"%li,%li",indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
                orderStatus.text = @"待镖师拿镖";
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
        
        NSString *privateReceivedCellID = @"privateReceivedCellID";
        privateReceivedCell = [tableView dequeueReusableCellWithIdentifier:privateReceivedCellID];
        privateReceivedCell = [tableView dequeueReusableCellWithIdentifier:privateReceivedCellID];

        
        if (!privateReceivedCell) {
            
            privateReceivedCell = [[PrivateReceivedOrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:privateReceivedCellID];
            privateReceivedCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (indexPath.row < array.count ) {
            
            NSLog(@"dish_name:%@",array[indexPath.row][@"dish_name"]);
            NSLog(@"dish_price:%@",array[indexPath.row][@"dish_price"]);
            NSLog(@"dish_num:%@",array[indexPath.row][@"dish_num"]);
            
            privateReceivedCell.dishOfName.text = array[indexPath.row][@"dish_name"];
            privateReceivedCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", array[indexPath.row][@"dish_price"]];
            privateReceivedCell.numOfLabel.text = [NSString stringWithFormat:@"%@份",array[indexPath.row][@"dish_num"]];
        }
        
        
        else if (indexPath.row == array.count ) {
            
            
            
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

        
        
        ///////////

//        for ( int i = 0; i < _productList.count; i ++) {
//            if (indexPath.row == i) {
//                
//                PrivateReceivedOrderDetailTableViewCell *privateReceivedCell = [tableView dequeueReusableCellWithIdentifier:@"privateReceivedCell"];
//                
//                if (!privateReceivedCell) {
//                    
//                    privateReceivedCell = [[PrivateReceivedOrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"privateReceivedCell"];
//                    privateReceivedCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    
//                }
//                return privateReceivedCell;
//            }
//            
//        }
//    
//        if (indexPath.row == _productList.count) {
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
//                totalPriceOfLabel.text = @"￥100.00";
//                [cell.contentView addSubview:totalPriceOfLabel];
//                
//            }
//        }
//        
//    }
    
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            
            if (!gourmeTelLabel) {
                
                gourmeTelLabel = [[UILabel alloc]init];
                gourmeTelLabel.frame = CGRectMake(10, 10, 80, 21);
                gourmeTelLabel.text = @"食客电话";
                gourmeTelLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:gourmeTelLabel];
                
            }
            
            if (!gourmeTelOfLabel) {
                
                gourmeTelOfLabel = [[UILabel alloc]init];
                gourmeTelOfLabel.frame = CGRectMake(CGRectGetMaxX(gourmeTelLabel.frame), 10, 120, 21);
                gourmeTelOfLabel.text = @"";
                gourmeTelOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:gourmeTelOfLabel];
                
            }
            
        }
        else if (indexPath.row == 1) {
            
            if (!gourmeAddressLabel) {
                
                gourmeAddressLabel = [[UILabel alloc]init];
                gourmeAddressLabel.frame = CGRectMake(10, 10, 80, 21);
                gourmeAddressLabel.text = @"食客地址";
                gourmeAddressLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:gourmeAddressLabel];
                
            }
            
            if (!gourmeAddressOfLabel) {
                
                gourmeAddressOfLabel = [[UILabel alloc]init];
                gourmeAddressOfLabel.frame = CGRectMake(CGRectGetMaxX(gourmeAddressLabel.frame), 10, ScreenWidth - CGRectGetMaxX(gourmeAddressLabel.frame) - 10, 21);
                gourmeAddressOfLabel.text = @"";
                gourmeAddressOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:gourmeAddressOfLabel];
            
            }
        }
        else if (indexPath.row == 2) {
            
            if (!eatTimeLabel) {
                
                eatTimeLabel = [[UILabel alloc]init];
                eatTimeLabel.frame = CGRectMake(10, 10, 80, 21);
                eatTimeLabel.text = @"吃饭时间";
                eatTimeLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:eatTimeLabel];
                
            }
            
            if (!eatTimeOfLabel) {
                
                eatTimeOfLabel = [[UILabel alloc]init];
                eatTimeOfLabel.frame = CGRectMake(CGRectGetMaxX(eatTimeLabel.frame), 10, 180, 21);
                eatTimeOfLabel.text = @"";
                eatTimeOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:eatTimeOfLabel];
                
            }
        }
        else if (indexPath.row == 3) {
            
            if (!sendStyleLabel) {
                
                sendStyleLabel = [[UILabel alloc]init];
                sendStyleLabel.frame = CGRectMake(10, 10, 80, 21);
                sendStyleLabel.text = @"配送方式";
                sendStyleLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:sendStyleLabel];
                
            }
            
            if (!sendStyleOfLabel) {
                
                sendStyleOfLabel = [[UILabel alloc]init];
                sendStyleOfLabel.frame = CGRectMake(CGRectGetMaxX(sendStyleLabel.frame), 10, ScreenWidth - CGRectGetMaxX(sendStyleLabel.frame) - 10, 21);
                sendStyleOfLabel.text = @"";
                sendStyleOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:sendStyleOfLabel];
                
            }
        }

    }
    else if (indexPath.section == 3) {
        
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
                armedTelOfLabel.frame = CGRectMake(CGRectGetMaxX(armedTelLabel.frame), 10, 120, 21);
                armedTelOfLabel.text = @"";
                armedTelOfLabel.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:armedTelOfLabel];
                
            }

        }
    }
    if (indexPath.section == 1 && (indexPath.row < array.count)) {
        
        return privateReceivedCell;
        
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
