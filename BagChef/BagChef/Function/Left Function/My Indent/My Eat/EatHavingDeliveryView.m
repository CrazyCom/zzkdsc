//
//  EatHavingDeliveryView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EatHavingDeliveryView.h"
#import "EatHavingDeliveryViewTableViewCell.h"
#import "OrderSendDetailViewController.h"
@interface EatHavingDeliveryView()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    CGRect _frame;
    NSMutableArray *_productList;
    NSMutableArray *_dataSource;
    
    UILabel *numOfLabel;
    UILabel *totalOfPrice;
    UILabel *timeOfEat;
    UILabel *timeOfOrder;
    
    UILabel  *freightOfLabel;                      //运费
    UILabel *totalPriceOfLabel;                    //总价
    //UILabel
    UILabel *totalPriceLabel;
    UILabel *armedPriceOfLabel;

    
    UIButton *sendBtn;
}

- (void)initializeInterface;
- (void)initializeDataSource;
@end

@implementation EatHavingDeliveryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)initializeDataSource {
    
    _productList = [[NSMutableArray alloc]init];
    _dataSource = [[NSMutableArray alloc]init];
//    _productList = [@[@"1",@"2"] copy];
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        [self initializeDataSource];
        [self initializeInterface];
    }
    return self;
}

- (void)initializeInterface {
    
    self.backgroundColor = [UIColor grayColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];

}

- (void)updateViewWith:(NSMutableDictionary *)params {
    
    _dataSource = [[NSMutableArray alloc] initWithArray:params[@"data"]];
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    _productList = [[NSMutableArray alloc] initWithArray:_dataSource[section][@"dish_list"]];
    return _productList.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *CELLID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        armedPriceOfLabel = [[UILabel alloc]init];
        armedPriceOfLabel.tag = 5000;
        [cell.contentView addSubview:armedPriceOfLabel];
        
        freightOfLabel = [[UILabel alloc]init];
        freightOfLabel.tag = 5001;
        [cell.contentView addSubview:freightOfLabel];
        
        totalPriceLabel = [[UILabel alloc]init];
        totalPriceLabel.tag = 5002;
        [cell.contentView addSubview:totalPriceLabel];
        
        totalPriceOfLabel = [[UILabel alloc]init];
        totalPriceOfLabel.tag = 5003;
        [cell.contentView addSubview:totalPriceOfLabel];
               
        sendBtn = [[UIButton alloc]init];
//        NSLog(@"%li",[[NSString stringWithFormat:@"%li",indexPath.section]integerValue]);
        sendBtn.tag = 78;
        [cell.contentView addSubview:sendBtn];
        
    }
    
   
    //------------
    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[indexPath.section][@"dish_list"]];
        
    for (int i = 0 ; i < array.count; i ++) {
        
        if (indexPath.row == i) {
            
            EatHavingDeliveryViewTableViewCell *eatHavingDeliveryCell = [tableView dequeueReusableCellWithIdentifier:@"EatHavingDeliveryID"];
            
            if (!eatHavingDeliveryCell) {
                
                eatHavingDeliveryCell = [[EatHavingDeliveryViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EatHavingDeliveryID"];
                eatHavingDeliveryCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            NSDictionary *params = _dataSource[indexPath.section];
            NSArray *dishList = params[@"dish_list"];
            
            if (indexPath.row < dishList.count) {
                
                eatHavingDeliveryCell.dishOfName.text = dishList[indexPath.row][@"dish_name"];
                eatHavingDeliveryCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", dishList[indexPath.row][@"dish_price"]];
                eatHavingDeliveryCell.numOfLabel.text = [NSString stringWithFormat:@"X%@", dishList[indexPath.row][@"dish_num"]];
            }

            return eatHavingDeliveryCell;
        }

    }
    if (indexPath.row == array.count) {
        
        
            
            armedPriceOfLabel = (UILabel *)[cell.contentView viewWithTag:5000];
            armedPriceOfLabel.frame = CGRectMake(12, 10, 80, 20);
            armedPriceOfLabel.font = [UIFont systemFontOfSize:14];
            armedPriceOfLabel.textColor = [UIColor grayColor];
            armedPriceOfLabel.text = @"镖费";
            
        
        
        
            
            freightOfLabel = (UILabel *)[cell.contentView viewWithTag:5001];
            freightOfLabel.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
            freightOfLabel.textAlignment = NSTextAlignmentRight;
            freightOfLabel.textColor = [UIColor grayColor];
            freightOfLabel.font = [UIFont systemFontOfSize:14];
            freightOfLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"express_price"]doubleValue]];
            
            
        

    }
    else if (indexPath.row == array.count + 1) {
        
        
            
            totalPriceLabel = (UILabel *)[cell.contentView viewWithTag:5002];
            totalPriceLabel.frame = CGRectMake(12, 10, 80, 20);
            totalPriceLabel.font = [UIFont systemFontOfSize:15];
            totalPriceLabel.textColor = [UIColor grayColor];
            totalPriceLabel.text = @"合计";
            
        
        
        
            
            totalPriceOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
            totalPriceOfLabel.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
            totalPriceOfLabel.textAlignment = NSTextAlignmentRight;
            totalPriceOfLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
            totalPriceOfLabel.font = [UIFont systemFontOfSize:14];
            totalPriceOfLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"total_price"]doubleValue]];
            
        
        

    }
    else if (indexPath.row == array.count + 2) {
        
        
//            sendBtn = (UIButton *)[cell.contentView viewWithTag:(int)[[NSString stringWithFormat:@"%li",indexPath.section]integerValue]];
            sendBtn = (UIButton *)[cell.contentView viewWithTag:78];
            sendBtn.tag = indexPath.section;
            sendBtn.frame = CGRectMake(50, 8, ScreenWidth - 100, 28);
            [sendBtn setTitle:@"我已收到餐啦" forState:UIControlStateNormal];
            sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [sendBtn setTintColor:[UIColor whiteColor]];
            [sendBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
            [sendBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
           
            

        
    
    }

    return cell;
}

//headerView 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"----");
    OrderSendDetailViewController *vc = [[OrderSendDetailViewController alloc]initWithOrder_num:_dataSource[indexPath.section][@"order_num"]];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
//    [dvc.ztabBarController.viewControllers[0] pushViewController:vc animated:YES];
    [(UINavigationController *)dvc.ztabBarController.selectedViewController pushViewController:vc animated:YES];
    
   
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSLog(@"sender:%li",sender.tag);
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *order_num = _dataSource[sender.tag][@"order_num"];
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

@end
