//
//  DoWaitForReceiveOrderView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "DoWaitForReceiveOrderView.h"
#import "DoWaitForReceiveOrderViewTableViewCell.h"

@interface DoWaitForReceiveOrderView () {
    
    CGRect _frame;
    NSMutableArray *_productList;
    NSMutableArray *_dataSource;
    NSIndexPath *cellIndexPath;
    UILabel *noteOfLabel;
    
    UILabel *numOfLabel;
    UILabel *perAndPrice;
    UILabel *addressOfLabel;
    UILabel *armedPriceOfLabel;
    
    UILabel *totalLabel;
    UILabel *totalOfPriceLabel;
    UILabel *eatOfTimeLabel;
    
    //地址
    UIImageView *positionImageView;
    
    //时间
    
    NSDateFormatter *fomatter;
    UIImageView *timeImageView;
    
    UIButton *refuseBtn;
    UIButton *takeBtn;
    
    int sectionIndex;
}
- (void)initializeInterface;
- (void)initializeDataSource;

@end
@implementation DoWaitForReceiveOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)initializeDataSource {
//    
//    noteOfLabel = [[UILabel alloc]init];
//}
//
//- (void)updateViewWith:(NSMutableDictionary *)params {
//    
//    _dataSource = [[NSMutableArray alloc] initWithArray:params[@"data"]];
//    [_tableView reloadData];
//}
//
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        _frame = frame;
//        [self initializeDataSource];
//        [self initializeInterface];
//    }
//    return self;
//}
//
//- (void)initializeInterface {
//    
//    self.backgroundColor = [UIColor grayColor];
//    
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self addSubview:_tableView];
//
//}
//
//#pragma mark - UITableViewDelegate,UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return _dataSource.count;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CELLID = @"CellID";
////    NSString *CELLID = [NSString stringWithFormat:@"%li,%li",indexPath.section,indexPath.row];
//    DoWaitForReceiveOrderViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
//    if (!cell) {
//        cell = [[DoWaitForReceiveOrderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    [cell setCellModel:_dataSource[indexPath.section]];
//    
//    __weak typeof(self)myself = self;
//    cell.buttonClick = ^(DoWaitForReceiveOrderViewTableViewCell *cell,int tag) {
//        
//        NSLog(@"%i",tag);
//        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *pwd = [userDefaults objectForKey:@"pwd"];
//        NSString *tel = [userDefaults objectForKey:@"tel"];
//        NSString *express_id = [userDefaults objectForKey:@"uid"];
//        NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
//        NSString *order_num = _dataSource[indexPath.section][@"order_num"];
//
//        
//        if (tag == 70) {
//            
//            AlertTextfield *alertText = [[AlertTextfield alloc]initWithFrame:CGRectMake(ScreenWidth/7, ScreenHeight / 2 - 150, ScreenWidth/7*5, 150)];
//            __weak typeof(alertText) textself = alertText;
//            [myself addSubview:alertText];
//            alertText.cancelBlock = ^{
//                noteOfLabel.text = textself.textField.text;
//                NSString *note = noteOfLabel.text;
//                NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num,@"note":note};
//                [NetWorkHandler notPickByChef:dict completionHandler:^(id content) {
//                    
//                    NSLog(@"notPickByChef:%@",content);
//                    [DisplayView displayShowWithTitle:content[@"info"]];
//                }];
//
//            };
//
//            
//        }
//        else if (tag == 71) {
//        
//            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num,@"express_id":express_id};
//            [NetWorkHandler pickByChef:dict completionHandler:^(id content) {
//                NSLog(@"pickByChef:%@",content);
//                [DisplayView displayShowWithTitle:content[@"info"]];
//            }];
//
//        }
//    };
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 212;
//}
//
////headerView 高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0.1;
//    }
//    return 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *headerView = [[UIView alloc]init];
//    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}

- (void)initializeDataSource {
    
    _productList = [[NSMutableArray alloc]init];
     noteOfLabel = [[UILabel alloc]init];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
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
    
    NSArray * array = [[NSArray alloc] initWithArray:_dataSource[section][@"dish_list"]];
    NSLog(@"array:%ld",array.count);
    return array.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    
    NSString *doWaitOrderCellID = @"doWaitOrderCellID";
    DoWaitForReceiveOrderViewTableViewCell *doWaitOrderCell = [tableView dequeueReusableCellWithIdentifier:doWaitOrderCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        totalLabel = [[UILabel alloc]init];
        totalLabel.tag = 5000;
        [cell.contentView addSubview:totalLabel];
        
        totalOfPriceLabel = [[UILabel alloc]init];
        totalOfPriceLabel.tag = 5001;
        [cell.contentView addSubview:totalOfPriceLabel];
        
        positionImageView = [[UIImageView alloc]init];
        positionImageView.tag = 5002;
        [cell.contentView addSubview:positionImageView];
        
        addressOfLabel = [[UILabel alloc]init];
        addressOfLabel.tag = 5003;
        [cell.contentView addSubview:addressOfLabel];
        
        timeImageView = [[UIImageView alloc]init];
        timeImageView.tag = 5004;
        [cell.contentView addSubview:timeImageView];
        
        eatOfTimeLabel = [[UILabel alloc]init];
        eatOfTimeLabel.tag = 5005;
        [cell.contentView addSubview:eatOfTimeLabel];
        
        for (int i = 0; i < 2; i++) {
            UIButton *btn = [[UIButton alloc]init];
            
            [btn addTarget:self action:@selector(buttonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 70 + i;
            [cell.contentView addSubview:btn];
            if (i == 0) {
                
                [btn setTitle:@"拒绝" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
                
            }
            else if (i == 1){
                
                [btn setTitle:@"接单" forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
                
            }
        }
//            UIButton *btn1 = [[UIButton alloc]init];
//            [btn1 setTitle:@"拒绝" forState:UIControlStateNormal];
//            [btn1 setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//            [btn1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//            btn1.tag = 70;
//            [cell.contentView addSubview:btn1];
//            
//            UIButton *btn2 = [[UIButton alloc]init];
//            [btn2 setTitle:@"接单" forState:UIControlStateNormal];
//            [btn2 setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//            [btn2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//            btn2.tag = 71;
//            [cell.contentView addSubview:btn2];
        
    }
    
    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[indexPath.section][@"dish_list"]];
    
    for (int i = 0 ; i < array.count; i ++) {
        
        if (!doWaitOrderCell) {
            
            doWaitOrderCell = [[DoWaitForReceiveOrderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doWaitOrderCellID];
            doWaitOrderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (indexPath.row == i) {
            
            NSDictionary *params = _dataSource[indexPath.section];
            NSArray *dishList = params[@"dish_list"];
            
            if (indexPath.row < dishList.count) {
                
                doWaitOrderCell.dishOfName.text = dishList[indexPath.row][@"dish_name"];
                doWaitOrderCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", dishList[indexPath.row][@"dish_price"]];
                doWaitOrderCell.numOfLabel.text = [NSString stringWithFormat:@"x%@", dishList[indexPath.row][@"dish_num"]];
            }
            
            
        }
        
    }
    if (indexPath.row == array.count) {
        
        totalLabel = (UILabel *)[cell.contentView viewWithTag:5000];
        totalLabel.frame = CGRectMake(10, 12, 80, 20);
        totalLabel.font = [UIFont systemFontOfSize:15];
        totalLabel.text = @"合计";
        
        totalOfPriceLabel = (UILabel *)[cell.contentView viewWithTag:5001];
        totalOfPriceLabel.frame = CGRectMake(ScreenWidth - 100, 12, 90, 20);
        totalOfPriceLabel.font = [UIFont systemFontOfSize:15];
        totalOfPriceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        totalOfPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"total_price"]doubleValue]];
        totalOfPriceLabel.textAlignment = NSTextAlignmentRight;
        
        
        positionImageView = (UIImageView *)[cell.contentView viewWithTag:5002];
        [positionImageView setFrame:CGRectMake(CGRectGetMinX(totalLabel.frame), CGRectGetMaxY(totalLabel.frame) + 20, 16 , 16)];
        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];
        
        
        addressOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
        [addressOfLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 11, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10), 10 )];
        [addressOfLabel setText:[NSString stringWithFormat:@"%@",_dataSource[indexPath.section][@"address"]]];
        [addressOfLabel setFont:[UIFont systemFontOfSize:13]];
        [addressOfLabel setTextColor:[UIColor grayColor]];
        
        
        if (!fomatter) {
            
            fomatter = [[NSDateFormatter alloc] init];
            fomatter.dateFormat = @"yyyy-MM-dd HH:mm";
            
        }
        
        timeImageView = (UIImageView *)[cell.contentView viewWithTag:5004];
        [timeImageView setFrame:CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 12, 16 , 16 )];
        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
        
        
        eatOfTimeLabel = (UILabel *)[cell.contentView viewWithTag:5005];
        eatOfTimeLabel.frame = CGRectMake(CGRectGetMaxX(timeImageView.frame) + 8, CGRectGetMaxY(timeImageView.frame) - 11,(ScreenWidth - CGRectGetMaxX(timeImageView.frame) - 8 - 10), 10 );
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_dataSource[indexPath.section][@"place_time"]doubleValue]];
        [eatOfTimeLabel setText:[fomatter stringFromDate:date]];
        [eatOfTimeLabel setTextColor:[UIColor grayColor]];
        [eatOfTimeLabel setFont:[UIFont systemFontOfSize:13]];
        
        UILabel *line1 = [[UILabel alloc]init];
        line1.frame = CGRectMake(10, CGRectGetMaxY(eatOfTimeLabel.frame) + 12, ScreenWidth - 20, 0.5);
        line1.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
        [cell.contentView addSubview:line1];

       
//        for (int i = 0; i < 2; i++) {
//            UIButton *btn = (UIButton *)[cell.contentView viewWithTag:70 + i];
//            btn.frame = CGRectMake(10 + (20 +(ScreenWidth - 10 * 2 - 20) / 2 )* i, CGRectGetMaxY(line1.frame) + 12, (ScreenWidth - 10 * 2 - 20) / 2, 39);
//            [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//            btn.tag = indexPath.section + i;
//            [cell.contentView addSubview:btn];
//
//        }
        
        refuseBtn = (UIButton *)[cell.contentView viewWithTag:70];
        refuseBtn.frame = CGRectMake(10 , CGRectGetMaxY(line1.frame) + 12, (ScreenWidth - 10 * 2 - 20) / 2, 39);
        [refuseBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [refuseBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
        [refuseBtn addTarget:self action:@selector(buttonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
//        refuseBtn.tag = 70 + indexPath.section;
        [cell.contentView addSubview:refuseBtn];
        
        takeBtn = (UIButton *)[cell.contentView viewWithTag:71];
        takeBtn.frame = CGRectMake(10 + (20 +(ScreenWidth - 10 * 2 - 20) / 2 ), CGRectGetMaxY(line1.frame) + 12, (ScreenWidth - 10 * 2 - 20) / 2, 39);
        [takeBtn setTitle:@"接单" forState:UIControlStateNormal];
        [takeBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
        [takeBtn addTarget:self action:@selector(buttonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
//        takeBtn.tag = 70000000 + indexPath.section;
        [cell.contentView addSubview:takeBtn];
        NSLog(@"indexPath:%ld",indexPath.section);
        sectionIndex = (int)indexPath.section;
        NSLog(@"sectionIndex:%d",sectionIndex);
        
        
    }
    if (indexPath.row < array.count) {
        return doWaitOrderCell;
    }
    else {
        
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = _dataSource[indexPath.section][@"dish_list"];
    if (indexPath.row == array.count ) {
        
        return 170;
    }
    return 44;
}

//headerView 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
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

- (void)buttonPressed:(UIButton *)sender event:(id)event{
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    //获取到当前Cell的indexPath
    NSIndexPath *indexPath= [_tableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"%d  button 的tag %d",(int)indexPath.section,(int)sender.tag);

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [userDefaults objectForKey:@"pwd"];
    NSString *tel = [userDefaults objectForKey:@"tel"];
    NSString *express_id = [userDefaults objectForKey:@"uid"];
    
    NSString *order_num = _dataSource[indexPath.section][@"order_num"];


    if (sender.tag == 71) {
        //接单
        
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num,@"express_id":express_id};
        [NetWorkHandler pickByChef:dict completionHandler:^(id content) {
            NSLog(@"pickByChef:%@",content);
            [DisplayView displayShowWithTitle:content[@"info"]];
        }];

    }
    else if(sender.tag == 70){
        
        NSLog(@"拒绝:%ld",sender.tag - 70);
        
        AlertTextfield *alertText = [[AlertTextfield alloc]initWithFrame:CGRectMake(ScreenWidth/7, ScreenHeight / 2 - 150, ScreenWidth/7*5, 150)];
        __weak typeof(alertText) textself = alertText;
        [self addSubview:alertText];
        alertText.cancelBlock = ^{
            noteOfLabel.text = textself.textField.text;
            NSString *note = noteOfLabel.text;
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num,@"note":note};
            [NetWorkHandler notPickByChef:dict completionHandler:^(id content) {
                
                NSLog(@"notPickByChef:%@",content);
                [DisplayView displayShowWithTitle:content[@"info"]];
            }];
            
        };

    }
    
    
}

@end
